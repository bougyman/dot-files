#!/bin/bash
here=$(cd $(dirname $BASH_SOURCE) && pwd)
cd $here/..
dotdir=$(pwd)
echo "Adding dotfiles from ${dotdir}" 1>&2
for t in .[a-zA-Z]*;do
	echo $t|egrep -qi '^.git(modules|ignore|.orig)?$'
	if [ $? -eq 0 ];then
		echo "ignoring $t" 1>&2
		continue
	fi
	if [ -e ~/"$t" ];then
		echo -n "~/$t exists, replace? (N/y) " 1>&2
		read -n 1 yesno
		echo
		echo $yesno|grep -qi '^y'
		if [ $? -eq 0 ];then
			echo Ok, replacing
			mv -b ~/"$t" ~/"$t".orig-dotfiles
		else
			echo Ok, skipping
			continue
		fi
	fi
	echo "Linking ${dotdir}/$t to ~/$t"
	ln -s "${dotdir}"/"$t" ~/"$t"
done

