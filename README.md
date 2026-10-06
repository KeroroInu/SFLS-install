# SFLS 安装

SFLS 是课堂编程学习伙伴。先从老师的平台下载任务包，解压后在该文件夹启动 SFLS。

当前版本：**0.1.2，课堂预览版**。这是公开安装分发仓库，不存放学生数据或 API 密钥。

## Mac：在终端复制这一行

```sh
f=$(mktemp) && curl --proto '=https' --proto-redir '=https' -fL 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.2/install.sh' -o "$f" && bash "$f"
```

## Windows：在 PowerShell 复制这一行

```powershell
& { $f = Join-Path ([IO.Path]::GetTempPath()) ('sfls-' + [guid]::NewGuid() + '.ps1'); Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.2/install.ps1' -OutFile $f; & $f }
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

安装地址固定为 `v0.1.2`；更新会使用新版本，不移动旧标签。两平台 ZIP 的 SHA-256 见 `SHA256SUMS`。本仓库提供 SFLS 自有代码的课堂体验发行件，不代表授予其开源许可。运行所用第三方组件遵循各自许可证，见安装包内 `THIRD_PARTY_NOTICES.md`。
