[toc]

## 贡献流程
* fork Magpie Fly仓库<br>
    https://github.com/wuba/magpie_ui.git **地址待定**

```
git clone https://github.com/{your organization}/magpie_ui.git
```

* 添加远程地址
```
cd magpie_ui
git remote add upstream https://github.com/wuba/magpie_ui.git
```

* 创建开发分支
```
git checkout -b {your branch name}
```
* 如何创建组件模板，请参考[使用文档](doc/magpie_ui.md)

* 提交代码
```
git commit -m "{your commit msg}"
```

* rebase master
```
git checkout master//切到master分支
git pull upstream master//拉取上游master最新代码
git checkout {your branch name}//切回开发分支
git rebase master//rebase master
git push origin {your branch name}//提交代码到远程开发分支
```

* 申请Pull Request

    在你的github仓库，切到{your branch name},点击`New Pull Request`，填写msg提交即可
