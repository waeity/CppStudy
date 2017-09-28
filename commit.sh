#! /bin/bash

# 提交代码到github

get_all_ch_dir() {
	all_files=`ls`
	for f in $all_files; do
		if [ -d $f ]; then
			echo -e "$f \c"
		fi
	done
}

clear_build() {
	all_ch_dir=$(get_all_ch_dir)
	for ch_dir in $all_ch_dir; do
		cd $ch_dir
		sh build.sh clear
		cd ..
	done
}

show_status() {
	if git status | grep 'nothing to commit'; then
		return 1
	else
		echo "Changed files: "
		git status -s -u
		return 0
	fi
}

commit() {
	git add *
	git commit -m "commit"

	echo "Committing ..."
	git push origin master
}

main() {
	clear_build

	if ! show_status; then
		return 0
	fi

	echo -e "--------------------------\nIs it ok [y/n]: \c"
	read answer

	if [ "$answer" == "y" ]; then
		commit
	fi
}

main

exit 0