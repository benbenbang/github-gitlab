# Edit the following info first and save this file at the Repo folder.
fromGit="git@github.com"
toGit="git@gitlab.com"
username="username"
repo="repo.git"

if [ ! -e "$repo" ]
then
  # bash to clone the repo.git for the First time usage 
  git clone --mirror "$fromGit":"$userName"/"$repo"
  cd "$repo"
  git push --no-verify --mirror "$toGit":"$userName"/"$repo"
  git remote set-url --push origin "$toGit":"$userName"/"$repo"
  git fetch -p origin
  git push --no-verify --mirror
  cd ..
else
  # bash to push to toGit
  cd "$repo"
  git push --no-verify --mirror "$toGit":"$userName"/"$repo"
  git remote set-url --push origin "$toGit":"$userName"/"$repo"
  git fetch -p origin
  git push --no-verify --mirror
  cd ..
fi
