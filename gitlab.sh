git clone --mirror git@your-gitlab-site.com:username/repo.git
cd repo.git
git push --no-verify --mirror git@github.com:username/my-repo.git
git remote set-url --push origin git@github.com:username/my-repo.git
git fetch -p origin
git push --no-verify --mirror
cd ..
