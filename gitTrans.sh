# Edit the following info first and save this file at the Repo folder.
fromGit="git@github.com"
toGit="git@gitlab.com"
username="username"
repo="repo.git"

# Automatically check and do our job.
# Don't have to change anything.
if [ ! -e "$repo" ]
then
  # bash to clone the repo.git for the First time usage 
  echo "Hi, $USER"
  echo "Please check the following info:"
  echo "You’re going to clone a repo from $fromGit to $toGit"
  echo "And the username and repo are $username and $repo, respectively"
  while true; do
    echo -n "Is everything right? [ENTER:YES or NO]: "
    read answer
    case $answer in
        [Yy]* )
        echo "We're now preparing to clone the git from $fromGit to $toGit"
        git clone --mirror "$fromGit":"$username"/"$repo"
        echo "Done for cloning"
        cd "$repo"
        echo "Prepare to push to $toGit"
        git push --no-verify --mirror "$toGit":"$username"/"$repo"
        git remote set-url --push origin "$toGit":"$username"/"$repo"
        cd ..
        break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
  done
else
  # bash to push to toGit
  cd "$repo"
  echo "Prepare to push to $toGit"
  git fetch -p origin
  git push --no-verify --mirror
  cd ..
fi
