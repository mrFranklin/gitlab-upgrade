#!bin/sh

if [ -d $1 ]; then
	echo "begin to change .bundle to .git ..."
else
	echo "$1 must be a dir"
	exit 1
fi

function walk() {
	echo "file path: $1"
	for file in `ls $1`
	do
		file=$1/$file
		echo $file
		if test -d $file; then
			walk ${file}
		fi
		if test -f $file && [ ${file##*.} = "bundle" ]; then
			gitFile=${file%.*}".git"
			echo gitFile: $gitFile
			if [ ! -d $gitFile ]; then
				echo "begin to unpack bundle file: $file"
				echo "make dir: ${gitFile}"
				mkdir -p $gitFile
				tar xvf $file -C $gitFile/
				echo "unpack bundle file: $file success!"
				rm -rf $file
				echo "bundle file removed"
			fi
		fi
	done
}

walk $1
