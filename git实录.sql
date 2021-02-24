
# 启动git-bash,执行以下命令

cd ~/.ssh
ssh-keygen -t rsa -C "593642275@qq.com"
# 此处要求你输入目录，默认不输入

cat ~/.ssh/id_rsa.pub
# 将文件内容贴到 https://github.com ( Settings--SSH keys--New SSH key ），就是相当于在线上github官网上面注册了ssh

# 此命令验证key（对于 Permanently added the RSA host key for IP address... 提示可以不用去管）
ssh -T git@github.com

# 把本地仓库传到github上去，设置username和email，因为github每次commit都会记录他们
git config --global user.name "aJavaBird"
git config --global user.email "593642275@qq.com"

# 进入自己的仓库目录 D:\myWork\gitRepository
cd /D/myWork/gitRepository

# 检出项目：https://github.com/aJavaBird/ChineseChess （注意最后要加上.git）
git clone https://github.com/aJavaBird/ChineseChess.git

# 进入 D:\myWork\gitRepository\ChineseChess 目录，增加一个test.txt 文件，随便输入点内容
# 提交这个文件，commit 最后的那个参数是提交注释
git add test.txt
git commit -m "this is a test,here is comment"
git push origin master

# 删除文件（需要验证）
git rm test.txt
git commit -m "rm the test"
git push origin master

# git clone https://github.com/aJavaBird/cdAlarm.git
# git clone https://github.com/zaqzaq/TankOnLine
# git clone https://github.com/Mr-Viker/Tetris--H5
# git clone https://github.com/hbsxcjp/ChinaChess_h5

# Github上如何取消fork别人的repository : https://blog.csdn.net/allenzyoung/article/details/50302471

# 查看当前分支
git branch

# 创建本地分支
git checkout -b 2019Branch

# 将本地分支推送到远端
git push origin 2019Branch
# 你的代码库(repository)可以存放在你的电脑里，同时你也可以把代码库托管到Github的服务器上。在默认情况下，origin指向的就是你本地的代码库托管在Github上的版本。

# 新建项目，并托管到Github上
# 首先去github上面新建一个repository（https://github.com/aJavaBird/testAdd）
git init
git remote add origin https://github.com/aJavaBird/testAdd.git
git add .
git status
git commit -m "add a project to github,for test"
git push -u origin master

# 删除github上的repository：进入这个repository，选择Settings，拖到最下面，点击“Delete this repository”

# 进入自己的仓库目录 D:\myWork\gitRepository
cd /D/myWork/gitRepository
git clone https://github.com/Activiti/Activiti.git

# 分布式商场操作实录
# 进入自己的仓库目录，不需要创建子目录 ldbz-shop，在 git clone 时会自动创建
cd /D/myWork/gitRepository
git clone https://github.com/aJavaBird/ldbz-shop.git

# --------------------------------  待操作 -------------------------------------
# 同步远程服务器上的数据到本地
git fetch origin
# 远程已有remote_branch分支但未关联本地分支local_branch且本地已经切换到local_branch
git push -u origin/remote_branch
# 远程没有有remote_branch分支并，本地已经切换到local_branch
git push origin local_branch:remote_branch
# --------------------------------  待操作 -------------------------------------

cd /D/myWork/gitRepository
git clone https://github.com/aJavaBird/tomcat80.git

cd /D/myWork/gitRepository
git clone https://github.com/dianping/cat.git

cd /D/myWork/gitRepository
git clone https://github.com/ityouknow/spring-boot-examples.git

cd /D/myWork/gitRepository
git clone https://github.com/ZHENFENG13/My-Blog.git

cd /D/myWork/gitRepository
git clone https://github.com/aJavaBird/demo.spring.aspect.git

# 并不需要主干
cd /D/myWork/gitRepository
git clone https://github.com/spring-projects/spring-data-elasticsearch.git

cd /D/myWork/gitRepository
git clone https://github.com/quanke/elasticsearch-java.git

cd /D/myWork/gitRepository
git clone https://github.com/whiney/springboot-elasticsearch.git

cd /D/myWork/gitRepository
git clone https://github.com/1160809039/elasticsearch-demo.git


# 上传 tzl-es 项目到 github
git init
git remote add origin https://github.com/aJavaBird/zhc-es.git
git add .
git commit -m "zhc-es"
git push -u origin master
# 提交前先更新（因为可能线上已经有代码修改过了）
git pull
# 提交代码
git add .
git commit -m "添加操作记录"
git push origin master


# 冲突报错:error: You have not concluded your merge (MERGE_HEAD exists).的原因可能是在以前pull下来的代码自动合并失败
# 解决办法一:保留本地的更改,中止合并->重新合并->重新拉取
git merge --abort
git reset --merge
git pull
# 解决办法二:舍弃本地代码,远端版本覆盖本地版本(慎重)
git fetch --all
git reset --hard origin/master
git fetch

# 房地产经验贴
cd /D/myWork/gitRepository
git clone https://github.com/houshanren/hangzhou_house_knowledge.git

# Python - 100天从新手到大师
cd /D/myWork/gitRepository
git clone https://github.com/jackfrued/Python-100-Days.git

# Python Tornado 写的开源网站——螺壳网
cd /D/myWork/gitRepository
git clone https://github.com/alvan/luokr.com.git


cd /D/myWork/gitRepository/ZhcRpc-history
git pull
# 提交代码
git add .
git commit -m "ZhcRpc框架编写过程实录"
git push origin master


cd /D/myWork/gitRepository/myTest
git init
git remote add origin https://github.com/aJavaBird/myTest.git
git add .
git commit -m "我的maven测试项目"
git push -u origin master


cd /D/myWork/gitRepository
cd /D/myWork/workspace-big/study
git clone https://github.com/mercyblitz/thinking-in-spring-boot-samples.git

# 上传 mini-xixi-history 项目到 github
git init
git remote add origin https://github.com/aJavaBird/mini-xixi-history.git
git add .
git commit -m "mini-xixi 历史版本"
git push -u origin master

cd /D/myWork/gitRepository
git clone -b 5.1.x https://github.com/spring-projects/spring-framework.git

# 解决从github上面下代码慢问题
#   配置github的相关地址ip到host
#   从 https://www.ipaddress.com/ 获取ip
# 192.30.253.112  github.com
# 199.232.69.194 github.global.ssl.fastly.net
# 140.82.114.9 codeload.github.com
#    设置完host，可以考虑刷新一下dns: ipconfig /flushdns
#   另外一种方式，是使用码云，建库时选择从github导入。
# 配host存在问题，使用码云亲测有效

# 码云也需要配置公钥什么的一堆东西（和github类似）
cd /D/myWork/giteeRepository
git clone -b 5.1.x https://gitee.com/happybei/spring-framework.git

cd /D/myWork/gitRepository
git clone https://github.com/aJavaBird/cloud2020.git
cd /D/myWork/gitRepository/cloud2020
# git pull 看起来像 git fetch + git merge
git pull
# 提交代码
git add .
git commit -m "ribbon 配置"
git push origin master

# git 提交时某些文件时不想提交的，需要过滤一下: 
# 可以在项目目录下面加一个 .gitignore 文件，在此文件中添加过滤规则

# https://github.com/git-for-windows/git/releases/download/v2.27.0.windows.1/Git-2.27.0-64-bit.exe

# 下载图平台核心代码
cd /D/myWork/gitWorkspace
git clone -b dev-2.19.0.DMP http://git.sz.haizhi.com/product/gp/graph.git
git clone -b dev-2.19.1.GAP http://git.sz.haizhi.com/product/gp/gap.git


# Git鼓励大量使用分支：
# 查看分支：git branch
# 创建分支：git branch <name>
# 切换分支：git checkout <name>
# 创建+切换分支：git checkout -b <name>
# 合并某分支到当前分支：git merge <name>
# 删除分支：git branch -d <name>

# 分支合并参考：https://blog.csdn.net/zl1zl2zl3/article/details/94019526
# 分支新建参考：https://www.cnblogs.com/smileyes/p/8943234.html

# 合并dev分支 到 master:
# 进入工作目录
cd /D/zhanghongchao/workspace-big/workspace_master
# down dev分支（需要合并到主干的分支）
git clone -b dev http://172.21.3.38/imsp/crm-fd.git
# 进入项目
cd crm-fd
# 查看当前分支
git branch
# 切换到master分支
git checkout master
# 合并dev分支到当前分支
git merge dev
# 提交代码到 master
git push -u origin master

# 上线合并代码后，同步到分支dev_20200622_corpgroup（如果有多个分支并行开发，则此三个语句需要执行多次）
# 切换到需要同步的分支
git checkout dev_20200622_corpgroup
# 合并master分支代码到当前分支
git merge master 
# push代码到远程分支
git push -u origin dev_20200622_corpgroup

# 解决冲突（从主干master 合并 到 dev_20200622_corpgroup）
# 代码合并后，会报错 MERGING，需要手动解决冲突，确认代码无误后，执行如下：
git add .
git commit -m "代码合并后冲突解决"
git push origin dev_20200622_corpgroup

# 上线成功后，删除老分支dev
git push origin --delete dev

# 创建新分支
# 进入工作目录
cd /D/zhanghongchao/workspace-big/workspace_master
# 拉下master分支
git clone -b master http://172.21.3.38/imsp/crm-fd.git
# 进入项目
cd crm-fd
# 创建并切换到新分支（执行此命令前是在master分支，执行后切换到了dev_20200622_corpgroup分支）
git checkout -b dev_20200622_corpgroup
# 这两步可以不用
# git add .
# git commit -m "集团客户分支"
# 上传分支代码
git push origin dev_20200622_corpgroup
# 仅切换分支（不创建新分支）
git checkout master

# 代码回滚（假设开发在dev分支提交了代码后，发现代码提交错了，需要回滚到上一个分支）
# 先确认所在的分支是 dev 分支，然后再进行回退
# 查看当前分支
git branch
# 回退到上个版本
git reset --hard HEAD^
# git reset --hard HEAD~3 回退到前3次提交之前，以此类推，回退到n次提交之前
# git reset --hard commit_id 退到/进到，指定commit的哈希码（这次提交之前或之后的提交都会回滚）
# 强推到远程：(可能需要解决对应分支的保护状态)
git push origin HEAD --force


/*
.gitignore不能忽略 .idea文件的问题-解决方案: 
1. 删除 .idea 目录（本地删除然后同步到远程）
2. .gitignore 文件中添加 .idea/
参考: https://blog.csdn.net/lqf19921217/article/details/83379071
*/

# 导出最近38天内的提交记录（从简单到详细）
# 每次提交为 一条记录
git log --shortstat --since="38 day ago" > D:/tmp/commit.log
# 每次提交以及修改过的文件（不展示文件明细）都展示
git log --stat --stat-width=800 --since="38 day ago" > D:/tmp/commit2.log
# 每次提交以及修改过的文件（展示文件明细）都展示
git log -p --pretty=format:"%ai , %an: %s" --since="38 day ago" >> D:/tmp/commit3.log

# 新加笔记项目
git init
git remote add origin https://github.com/aJavaBird/myStudyNote.git
git add .
git commit -m "我的学习笔记"
git push origin master

# 新加leetCode刷题项目（需要先创建repositories：LeetCode）
git init
git remote add origin https://github.com/aJavaBird/LeetCode.git
git add .
git commit -m "LeetCode刷题项目"
git push origin master

