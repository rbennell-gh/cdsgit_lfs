#!/bin/bash
#git lsf lock *.oa and *.sdb files underneath given directory

LCVdir=$(realpath $1)
#rootdir=$(realpath $2)
output=()
cd ${LCVdir}
files=$(find . -type f \( -name '*.oa' -o -name '*.sdb' \))

for f in $files
	do
		if [ -z "$(git lfs locks --path=${f})" ]
		then
			#checkout latest before we lock the file
			git lfs lock ${f} && git fetch && git checkout origin/master -- $(dirname ${f})
		else
			echo "${f} already locked"
		fi
	done

