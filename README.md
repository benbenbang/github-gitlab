# Migrating from Gitlab to Github, or vice versa

## 前言
使用Gitlab工作一段時間，使用上也感覺不錯，然而一些專案或團隊合作需求，有一些原本在Gitlab的Repo需要同步更新到Github，因此研究了一下該如何操作，以下是一些記錄。而以下這些步驟，雖說是討論Github和Gitlab，但基本上只要是git應該都不是問題。

---
## 基本步驟
概念很簡單：部分留（1-4）或直接全改(5)  
1. 由**舊目標**Repo `clone --mirror`[^1] 這邊的例子是我要從原先在Gitlab Repo先複製  
2. 接下來 `push --no-verify --mirror`[^2] 到在Github的**新目標**Repo  
3. 最後 `remote set-url --push origin` 目的是更新原先git中的origin url  
4. 未來push至gitlab後，cd至新的git資料夾中：   
   * git fetch -p origin  
   * git push --no-verify --mirror  
5. 若要原封不動直接移至Github，直接在Repo裡 `remote set-url origin` 吧！   

``` Terminal
# Assume DIR Repo: /Users/username/Desktop/Repo
$ cd /Users/username/Desktop/Repo
$ git clone --mirror git@gitlab.com:username/Repo.git

# As I mentioned in the footnote about `--mirror` which impiles `--bare` may hence create a # visible Repo.git directory
$ cd ~/Repo.git

# Push to GitHub by using the `--mirror` option.
# The `--no-verify` option skips any hooks. 
$ git push --no-verify --mirror git@github.com:username/Repo.git

# Set push URL to the mirror location
$ git remote set-url --push origin git@github.com:username/Repo.git


# To periodically update the Repo on GitHub with what you have in GitLab
$ git fetch -p origin
$ git push --no-verify --mirror
```

---
## Bash Instruction
由於直接全改的操作方式很直觀，也沒共存麻煩，因此檔案只是為了方便需要共存所建立的，然後會囉嗦地先再三確認後才行動。  
.sh裡只要自行修改以下5個變數  
1. `fromGit="github"` # 舊目標Repo在哪  
2. `toGit="gitlab"` # 新目標要送去哪  
3. `usernameF="username on Github"` # 在Github上的Username  
4. `usernameT="username on Gitlab"` # 在Gitlab上的Username  
5. `repo="Repo name"` # Repo名  
   將檔案放在Repo的資料夾中 `bash migrate.sh`   
   首次較為話癆，如果要同步的話就是一行換四行了...  

[^1]: `--mirror`：同時imply使用`--bare`，也就是創建一個「赤裸」可見的Repo.git之外，同時會將local branches的所有tracked file, notes...全部一併map到新的Repo.git，This is what we want!  
[^2]: `--no-verify`：由於在git/hooks下有時會放一些分析或測試檔，但複製到新工作團隊的Repo時不見得要使用這些scripts，因此用`--no-verify`，而push中的default為`--verify`  
