
gitMigr() {
# Edit the following info first and save this file at the Repo folder.
# from/toGit: github,gitlab...
# usernameF/T: username on from/toGit, if not sure check git@your-git-server.com:username/repo.git
# Repo name need no '.git'
MYPWD=${PWD}
VAR="${MYPWD##*/}"
DIR=$(grep 'git@github.com' .git/config)
if grep -q 'git@github.com' .git/config ; then 
	fromGit='github'
	toGit="gitlab"
elif grep -q 'git@gitlab.com' .git/config ; then 
	fromGit='gitlab'
	toGit="github"
else
	while true; do
		echo "I cannot find git config from Github or Gitlab in current directory"
		echo -n "Do you want to type your git server manually [ENTER:YES or NO]: "
		read answer
		case $answer in
			[Yy]* )
			cp migrate.sh $MYPWD 
			echo "Okay, I've copy a bash file to $MYPWD, Edit then Push!"
			exit;;
			[Nn]* ) exit;;
			*) echo "Please answer yes or no.";;
		esac
	done
fi

usernameF="username on Github"
usernameT="username on Gitlab" 
repo=${DIR:33}

# Automatically Check and Do Our Job.
# Don't need to change anything if you're not sure.
if [ ! -e "$repo.git" ]
then
  # bash to clone the repo.git for the First time usage
  echo "Hi, $USER"
  echo "Please check the following info:"
  echo "You’re going to clone a repo from $fromGit to $toGit"
  echo "The username on the $fromGit is $usernameF"
  echo "and the username on the $toGit is $usernameT"
  echo "The repo name is $repo"
  echo "Finally, make sure you already have a empty repo as the same name $repo on $toGit"
  while true; do
    echo -n "Is everything right? [ENTER:YES or NO]: "
    read answer
    case $answer in
        [Yy]* ) 
        echo "We're now preparing to clone the git from $fromGit to $toGit" 
        git clone --mirror "git@$fromGit.com":"$usernameF"/"$repo.git"
        echo "Done for cloning."
        cd "$repo.git"
        echo "Prepare to push to $toGit"
        git push --no-verify --mirror "git@$toGit.com":"$usernameT"/"$repo.git"
        git remote set-url --push origin "git@$toGit.com":"$usernameT"/"$repo.git"
        cd ..
        break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
  done
else
  # bash to push to toGit
  cd "$repo.git"
  echo "Prepare to push to $toGit"
  git fetch -p origin
  git push --no-verify --mirror
  cd ..
fi
}