## Github ←→ Gitlab
因為一些需要，有時需要將同一個Repo推到Github及Gitlab  
以下是一些記錄  

---
### github → gitlab

``` terminal
# 先回到家目錄
$ cd ~/
```
``` terminal
# Clone the repo from GitLab：使用`--mirror` option：
# 這時資料夾內會產生一個新的my-repo.git
$ git clone --mirror git@your-gitlab-site.com:username/repo.git
```
``` terminal
# 往下一層切換
$ cd ~/repo.git
```
``` terminal
# Push to GitHub：使用`--mirror` 及 `--no-verify` 
$ git push --no-verify --mirror git@github.com:username/repo.git
```
``` terminal
# Set push URL to the mirror location
$ git remote set-url --push origin git@github.com:username/repo.git
```
``` terminal
# 要Update GitHub → GitLab
git fetch -p origin
git push --no-verify --mirror
```

---
### github ← gitlab
同理，但是這個步驟可略
``` terminal
# Set push URL to the mirror location
$ git remote set-url --push origin git@github.com:username/repo.git
```

---
### Example: Gitlab.sh
若懶得打字，可直接做一個如gitlab.sh，方便快速
