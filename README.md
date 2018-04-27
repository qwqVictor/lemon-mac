# lemon-mac
简易 OI 评测系统 —— lemon 在 macOS 上的移植版本。  
当前最新版本: lemon 1.2  
作者: [@Zhipeng Jia](https://github.com/zhipeng-jia)
### 构建
只需将原版 clone 下来，也就是原版源码在 project-lemon 文件夹下。  
只需执行: 
```bash
bash make.sh
```
便会自动帮助您构建 lemon。

### 依赖组件
* Qt 4 (必需，没有不可编译)
* rpl (`make.sh` 需要，您也可以选择手动 Patch)
* 一个支持 21 世纪语法的 C/C++ 编译器
* brew (如果上述组件已经全部安装则不需要)

在安装了 brew 的情况下，上述组件均可由 `make.sh` 来安装。

### 图标问题
如果您的 lemon 出现没有图标的情况，  
`make.sh` 已经帮助您打开了一个图标文件，您只需要按下 Command-C 将此**图像**(不是文件本身)拷贝下来，然后再 lemon 程序上右键->显示简介。  
选中左上角的默认图标，然后按下 Command-V，即可替换图标。

**Patched with ❤️ by [Victor Huang](https://imvictor.tech).**