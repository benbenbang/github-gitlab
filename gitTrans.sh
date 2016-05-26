# Edit the following info first and save this file at the Repo folder.
# from/toGit: github,gitlab...
# usernameF/T: username on from/toGit, if not sure check git@your-git-server.com:username/repo.git
# Repo name need no '.git'
fromGit="github"
toGit="gitlab"
usernameF="username on Github"
usernameT="username on Gitlab" 
repo="Repo name"

# Automatically Check and Do Our Job.
# Don't need to change anything if you're not sure.
if [ ! -e "$repo".git ]
then
  # bash to clone the repo.git for the First time usage
  echo "Hi, $USER"
  echo "Please check the following info:"
  echo "You’re going to clone a repo from $fromGit to $toGit"
  echo "The username on the $fromGit is $usernameF"
  echo "and the username on the $toGit is $usernameT"
  echo "The repo name is $repo"
  echo "Finally, make sure you already have a empty repo with the same name $repo on $toGit"
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
        [Nn]* ) exit;;
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
