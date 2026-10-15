# SFLS 安装

> 请勿安装 0.1.3：该版本存在 npm 安装目录识别问题。请使用下方 0.1.12；旧标签仅留作追溯。

SFLS 是课堂编程学习伙伴。先从老师的平台下载任务包，解压后在该文件夹启动 SFLS。

当前版本：**0.1.12，课堂试用版**。这是公开安装分发仓库，不存放学生数据或 API 密钥。

2026-10-15 构建，源码提交 `5f91e2c`，支架细则 `2026-10-14.1`；82 项自动测试通过。测试不代表真实模型教学效果或 Windows 机房环境已验证。

0.1.12 修复课堂平台登录后的身份校验，检查 API key 中误粘贴的中文、说明文字等，避免 ByteString 报错；支持教师提供的离线 Python 和课程依赖。GitHub 仍提供联网安装包，完整离线包请从教师端获取。

经教师确认，暂时仅对课堂地址 `http://124.222.152.227` 允许公网 HTTP 登录和提交；其他公网 HTTP 地址或端口仍拒绝。HTTP 不加密密码、凭证和作品，请只用课堂专用密码，不复用其他账号密码。此例外应在平台启用 HTTPS 后移除；没有关闭证书校验或允许携带凭证跳转。

新版在关键代码处邀请学生预测、判断或解释；答不上来就解释并帮助写好，继续在原作品上修改，不以答对换代码。课堂打包前缺少实现想法时，邀请补一两句并自动写入 README，可跳过，不用自己排版；已有说明或可引用的原话不重复问，前后测不加这个提醒。新增 `/advice` 建议入口，修复 `sfls --resume`；沿用自然语言运行、像素贪吃蛇 Logo、用户/AI 区分配色、安全重新打包与 `.drawio` 原件收集。

`/advice` 需要先登录平台，实名确认后发送原文；平台必须另行部署 `/api/advice` 配套接口。仅升级 SFLS 不代表老师的服务器已经支持建议收件。未确认送达时本地保留，可重试；不要填写密码或 API key。

## 升级

0.1.10 起支持 `/update`，也支持 `/updata`：检查新版，确认后保存对话、退出界面并运行安装器。作品、记录、账户和 API key 保留；失败时恢复旧启动入口。完成后在原任务文件夹输入 `sfls --resume` 继续本课。

系统终端可用 `sfls update`，仅检查版本用 `sfls update --check`。请先结束 AI 操作、关闭游戏和其他 SFLS 窗口；安装器仍可能询问下载或注册许可。两班请按老师要求统一升级，不自动后台更新。

**0.1.9 及更早版本没有这条命令**，先用下方安装指令升级一次到 0.1.12，以后才可使用。更新清单是本仓库 main 的 `latest.json`，安装包使用不可变版本标签。

## Mac：在终端复制这一行

```sh
f=$(mktemp) && curl --proto '=https' --proto-redir '=https' -fL 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.12/install.sh' -o "$f" && bash "$f"
```

## Windows：在 PowerShell 复制这一行

```powershell
& { $f = Join-Path ([IO.Path]::GetTempPath()) ('sfls-' + [guid]::NewGuid() + '.ps1'); Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.12/install.ps1' -OutFile $f; & $f }
```

Windows 如果提示禁止执行脚本，请交给老师按学校规定预装，不要关闭安全防护。Windows 安装尚待学校真机验收。

## 装好后

安装时按提示确认下载和注册终端命令。重新打开终端，进入解压后的任务文件夹，输入：

```sh
sfls
```

首次使用会引导登录本人平台账户、输入老师提供的模型密钥，以及准备本课 Python 环境。也可以双击新版任务包中的 `Start`。

API key 输入时不回显；缺少 Python 时只有输入 `y` 才会同意下载，直接回车表示取消。
在系统终端输入 `sfls --version` 应显示 `0.1.12`。如果还显示旧版，先关闭并重新打开终端，检查是否仍用了旧的安装链接。
进入后可直接说“帮我运行一下”“停一下”，或用 `/play`、`/stop`。自动运行使用本课环境和 `project/main.py`，可打开图形游戏窗口；独立交互终端（如 `input()`、curses）暂不支持。进程结束不代表功能通过，还需观察游戏效果。

完成后关闭作品，用 `/submit` 确认上传，或 `/pack` 打包交给老师。包中含任务作品、原始对话、工具结果、代码快照及客户端时间记录；支架等级是 AI 自述，不是能力评分，耗时也不是有效学习时长。密钥不应写入项目或聊天。两个班请统一版本。

打包后又修改了作品？在 SFLS 内输入 `/repack`，确认后生成新包；旧 ZIP 保留，新包生成失败不影响旧待提交包。系统终端也可用 `sfls pack --new`。`/submit` 重传现有待提交包，不会自动包含打包后的改动。离线 `init` 示例没有平台身份绑定，正式课堂请从本人平台账户下载任务包。

## 安装会做什么

- 复用可用的 Node；缺少时确认下载固定版本。Python 在首次启动任务时检查，缺少时确认下载。
- 软件放在个人 `.sfls-runtime` 目录，本课 Python 环境放在任务目录 `.sfls/environment`。
- 经确认后注册个人 `sfls` 命令，保留原 shell/PATH 备份，不要求管理员权限、不修改机器级 PATH 或系统 Python。
- 下载包先校验 SHA-256，再运行安装器；校验不能替代发布者签名。安装器目前没有代码签名。
- 模型密钥不放进任务文件夹。SFLS 可执行本机命令，不是系统沙箱，请使用老师指定的实验目录与账户。

需要访问 GitHub/raw.githubusercontent.com、nodejs.org、registry.npmjs.org；缺 Python 时需要 GitHub，课程第三方库需要 PyPI。模型连接、额度和机房网络需老师提前测试。不要在第一节课临时让全班同时下载环境。

无法使用在线命令时，可下载本仓库对应的 ZIP，完整解压后运行 `Install.command`（Mac）或 `Install.cmd`（Windows）。

## 版本与声明

安装地址固定为 `v0.1.12`；更新会使用新版本，不移动旧标签。两平台 ZIP 的 SHA-256 见 `SHA256SUMS`。本仓库提供 SFLS 自有代码的课堂体验发行件，不代表授予其开源许可。运行所用第三方组件遵循各自许可证，见安装包内 `THIRD_PARTY_NOTICES.md`。

可直接下载 [Mac 0.1.12](https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.12/SFLS-0.1.12-mac.zip) 或 [Windows 0.1.12](https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.12/SFLS-0.1.12-windows.zip)。旧版不会自动升级；退出 SFLS 后重新运行新版安装命令，不覆盖任务作品和账户设置。

0.1.4 修复了 Homebrew 升级导致 Node 路径失效、npm 依赖指向临时安装目录的问题，并固定独立安装目录，避免 npm 上溯修改个人项目。重新运行上面的新版安装命令即可升级，不覆盖任务作品或账户配置。

如果使用过 0.1.3 且安装自检失败，请先核对个人目录是否出现新增的 @keroroinu/sfls 依赖、原 npm 工具是否仍在。升级不能恢复已被 npm 移除的旧依赖，请联系老师人工处理，不要删除整个共享 node_modules。

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
