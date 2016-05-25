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
  echo "We're now preparing to clone the git from $fromGit to $toGit"
  git clone --mirror "$fromGit":"$username"/"$repo"
  echo "Done."
  cd "$repo"
  echo "Prepare to push to $toGit"
  git push --no-verify --mirror "$toGit":"$username"/"$repo"
  git remote set-url --push origin "$toGit":"$username"/"$repo"
  git fetch -p origin
  git push --no-verify --mirror
  cd ..
else
  # bash to push to toGit
  cd "$repo"
  echo "Prepare to push to $toGit"
  git fetch -p origin
  git push --no-verify --mirror
  cd ..
fi
