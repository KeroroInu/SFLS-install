# SFLS 安装

> 暂停安装：0.1.3 发现 npm 安装目录识别问题，请勿安装该版本。正在发布修复版；下面旧的 0.1.3 命令暂不使用。

SFLS 是课堂编程学习伙伴。先从老师的平台下载任务包，解压后在该文件夹启动 SFLS。

当前版本：**0.1.3，课堂预览版**。这是公开安装分发仓库，不存放学生数据或 API 密钥。

## Mac：在终端复制这一行

```sh
f=$(mktemp) && curl --proto '=https' --proto-redir '=https' -fL 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.3/install.sh' -o "$f" && bash "$f"
```

## Windows：在 PowerShell 复制这一行

```powershell
& { $f = Join-Path ([IO.Path]::GetTempPath()) ('sfls-' + [guid]::NewGuid() + '.ps1'); Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.3/install.ps1' -OutFile $f; & $f }
```

Windows 如果提示禁止执行脚本，请交给老师按学校规定预装，不要关闭安全防护。Windows 安装尚待学校真机验收。

## 装好后

安装时按提示确认下载和注册终端命令。重新打开终端，进入解压后的任务文件夹，输入：

```sh
sfls
```

首次使用会引导登录本人平台账户、输入老师提供的模型密钥，以及准备本课 Python 环境。也可以双击新版任务包中的 `Start`。

## 安装会做什么

- 复用可用的 Node；缺少时确认下载固定版本。Python 在首次启动任务时检查，缺少时确认下载。
- 软件放在个人 `.sfls-runtime` 目录，本课 Python 环境放在任务目录 `.sfls/environment`。
- 经确认后注册个人 `sfls` 命令，保留原 shell/PATH 备份，不要求管理员权限、不修改机器级 PATH 或系统 Python。
- 下载包先校验 SHA-256，再运行安装器；校验不能替代发布者签名。安装器目前没有代码签名。
- 模型密钥不放进任务文件夹。SFLS 可执行本机命令，不是系统沙箱，请使用老师指定的实验目录与账户。

需要访问 GitHub/raw.githubusercontent.com、nodejs.org、registry.npmjs.org；缺 Python 时需要 GitHub，课程第三方库需要 PyPI。模型连接、额度和机房网络需老师提前测试。不要在第一节课临时让全班同时下载环境。

无法使用在线命令时，可下载本仓库对应的 ZIP，完整解压后运行 `Install.command`（Mac）或 `Install.cmd`（Windows）。

## 版本与声明

安装地址固定为 `v0.1.3`；更新会使用新版本，不移动旧标签。两平台 ZIP 的 SHA-256 见 `SHA256SUMS`。本仓库提供 SFLS 自有代码的课堂体验发行件，不代表授予其开源许可。运行所用第三方组件遵循各自许可证，见安装包内 `THIRD_PARTY_NOTICES.md`。

0.1.3 修复了 Homebrew 升级导致 Node 路径失效、npm 依赖指向临时安装目录的问题。重新运行上面的新版安装命令即可升级，不覆盖任务作品或账户配置。

## 卸载

先关闭其他 SFLS 窗口，再在终端运行（无需进入任务目录）：

```sh
sfls uninstall
```

会先列出删除范围，输入 `yes` 确认后，删除 SFLS 专用程序、下载的 Node/Python、缓存，以及本机账户、API 密钥和配置，同时移除个人 PATH 的 SFLS 入口。

可选命令：

```sh
sfls uninstall --keep-data   # 保留账户、模型配置及密钥，只删除专用程序与环境
sfls uninstall --dry-run     # 预览删除范围，不实际删除
sfls uninstall --yes         # 跳过确认，执行默认清理
```

任务文件夹内的代码、对话记录和提交包始终保留，不扫描磁盘删除学生作品；系统原有 Node/Python、服务器数据也不受影响。Mac 原终端配置备份保留。任务内 Python 环境若依赖被删除的专用解释器，重装 SFLS 后需重新准备。共用电脑不要随意保留账户和密钥。

**旧版 0.1.2 或启动失败：**可先升级；也可下载新版 ZIP，解压后在安装包目录运行 `bash Uninstall.command`（Mac）或 `& .\Uninstall.ps1`（Windows），选项相同且不依赖 Node。运行中、目录链接、自定义 SFLS_HOME 等情况会停止并要求人工处理，不会强行清理。

如果曾通过 npm 全局安装，另运行 `npm uninstall -g @keroroinu/sfls`；以上卸载脚本仅清理 SFLS 专用目录，不修改 npm 的共享目录。卸载后重新打开终端。Windows 尚待机房真机验收。
