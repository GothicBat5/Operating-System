BASE=$(dirname $(dirname $(readlink -f $0)))
BRANCH=$1
pushd $BASE > /dev/null
  if [[ ! ( -d common-${BRANCH} || -d common${BRANCH} )  \
        || ${BRANCH} == ""                               \
        || ${BRANCH} == "modules" ]]; then
    echo "usage: $0 <branch>"
    echo
    echo "Branches available: "
    ls -d common-* | sed 's/common-/\t/g' | grep -v modules
    ls -d common1?-* | sed 's/common/\t/g'
    exit 1
  fi
  echo "Switching to $BRANCH"
  for dir in common common-modules/virtual-device; do
    if [ -L ${dir} ]; then
      rm ${dir}
    fi
    for candidate in ${dir}-${BRANCH} ${dir}${BRANCH}; do
      if [ -d ${candidate} ]; then
          (
            cd $(dirname $candidate)
            ln -vs $(basename ${candidate}) $(basename ${dir})
          )
      fi
    done
  done
  # now switch the build tools between trunk and legacy version
  case "${BRANCH}" in
    4.4|4.9|4.14-stable|4.19-stable|11-5.4|12-5.4|12-5.10)
      suffix="legacy"
      ;;
    *)
      suffix="trunk"
      ;;
  esac
  for dir in "build" "kernel" "prebuilts" "tools"; do
    ln -vsnf "${dir}-${suffix}" "${dir}"
  done
popd > /dev/null
