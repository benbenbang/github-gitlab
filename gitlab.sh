# bash gitlabFT.sh for First time clone 
# git clone --mirror git@gitlab.com:username/repo.git
# cd repo.git
# git push --no-verify --mirror git@github.com:username/repo.git
# git remote set-url --push origin git@github.com:username/repo.git
# git fetch -p origin
# git push --no-verify --mirror
# cd ..

# bash gitlab.sh
cd repo.git
git push --no-verify --mirror git@github.com:username/repo.git
git remote set-url --push origin git@github.com:username/repo.git
git fetch -p origin
git push --no-verify --mirror
cd ..
