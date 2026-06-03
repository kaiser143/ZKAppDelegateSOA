#!/bin/bash
set -euo pipefail

# 在仓库根目录执行：自动升 patch 版本 → 更新 podspec → lint → 提交 / 打 tag → push → trunk push

PODSPEC="ZKAppDelegateSOA.podspec"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${SCRIPT_DIR}"

increment_version() {
   local usage=" USAGE: $FUNCNAME [-l] [-t] <version> [<position>] [<leftmost>]
           -l : remove leading zeros
           -t : drop trailing zeros
    <version> : The version string.
   <position> : Optional. The position (starting with one) of the number
                within <version> to increment.  If the position does not
                exist, it will be created.  Defaults to last position.
   <leftmost> : The leftmost position that can be incremented.  If does not
                exist, position will be created.  This right-padding will
                occur even to right of <position>, unless passed the -t flag."

   local flag_remove_leading_zeros=0
   local flag_drop_trailing_zeros=0
   while [ "${1:0:1}" == "-" ]; do
      if [ "$1" == "--" ]; then shift; break
      elif [ "$1" == "-l" ]; then flag_remove_leading_zeros=1
      elif [ "$1" == "-t" ]; then flag_drop_trailing_zeros=1
      else echo -e "Invalid flag: ${1}\n$usage"; return 1; fi
      shift; done

   if [ ${#@} -lt 1 ]; then echo "$usage"; return 1; fi
   local v="${1}"
   local targetPos=${2-last}
   local minPos=${3-${2-0}}

   local IFSbak; IFSbak=IFS; IFS='.'
   read -ra v <<< "$v"

   if [ "${targetPos}" == "last" ]; then
      if [ "${minPos}" == "last" ]; then minPos=0; fi
      targetPos=$((${#v[@]}>${minPos}?${#v[@]}:$minPos)); fi
   if [[ ! ${targetPos} -gt 0 ]]; then
      echo -e "Invalid position: '$targetPos'\n$usage"; return 1; fi
   (( targetPos--  )) || true

   while [ ${#v[@]} -lt ${minPos} ]; do v+=("0"); done;

   v[$targetPos]=`printf %0${#v[$targetPos]}d $((10#${v[$targetPos]}+1))`;

   if [ $flag_remove_leading_zeros == 1 ]; then
      for (( pos=0; $pos<${#v[@]}; pos++ )); do
         v[$pos]=$((${v[$pos]}*1)); done; fi

   if [[ ${flag_drop_trailing_zeros} -eq "1" ]]; then
        for (( p=$((${#v[@]}-1)); $p>$targetPos; p-- )); do unset v[$p]; done
   else for (( p=$((${#v[@]}-1)); $p>$targetPos; p-- )); do v[$p]=0; done; fi

   echo "${v[*]}"
   IFS=IFSbak
   return 0
}

if [[ ! -f "${PODSPEC}" ]]; then
   echo "error: ${PODSPEC} not found in ${SCRIPT_DIR}" >&2
   exit 1
fi

currentVersion=$(grep -E "s\.version\s*=" "${PODSPEC}" | head -1 | sed -E "s/.*['\"]([^'\"]+)['\"].*/\1/")
if [[ -z "${currentVersion}" ]]; then
   echo "error: cannot parse s.version from ${PODSPEC}" >&2
   exit 1
fi

# 递增第三位 patch：0.1.2 -> 0.1.3
newVersion=$(increment_version "${currentVersion}" 3)

lineNumber=$(grep -nE "s\.version\s*=" "${PODSPEC}" | head -1 | cut -d: -f1)
sed -i "" "${lineNumber}s/${currentVersion}/${newVersion}/g" "${PODSPEC}"

echo "Pod: ZKAppDelegateSOA"
echo "Current version: ${currentVersion}"
echo "New version:     ${newVersion}"

echo "Running pod lib lint..."
pod lib lint "./${PODSPEC}" --allow-warnings

git add "${PODSPEC}"
git commit -am "${newVersion}"
git tag "${newVersion}"

defaultBranch=$(git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null | sed 's|^origin/||' || true)
if [[ -z "${defaultBranch}" ]]; then
   if git show-ref --verify --quiet refs/heads/main; then
      defaultBranch="main"
   else
      defaultBranch="master"
   fi
fi

git push -u origin "${defaultBranch}" --tags
pod trunk push "./${PODSPEC}" --verbose --allow-warnings

echo "Done. Published ${newVersion}"
