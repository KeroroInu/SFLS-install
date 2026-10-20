# SFLS 安装与升级

当前版本：**0.1.18，课堂试用版**。固定版本文件发布并校验后才启用更新，实际版本以本仓库 `main/latest.json` 为准。

公开仓库只放程序发行件，不放学生数据或 API key。源码提交 `7416cd6`，支架修订 `2026-10-20.2`；195项自动测试中194项通过、1项Windows专属检查跳过。Mac环境与本地打包已验收，Windows机房与新提示的真实模型对话仍需复测。

## 已安装：直接升级

先结束AI操作、关闭游戏和其他SFLS窗口，在系统终端运行：

```sh
sfls update
```

也可在SFLS里输入 `/update`（兼容 `/updata`）；仅检查版本用 `sfls update --check`。确认后保存记录并运行安装器，仍可能询问下载或个人命令注册许可。完成后用 `sfls --version` 核对 `0.1.18`，回原任务文件夹用 `sfls --resume` 继续。

升级不清理作品、记录、账户和模型密钥；失败时恢复旧启动入口。有效的现行离线Python/wheel关联会保留；旧版已经丢失的离线关联不会通过扫描历史目录猜测恢复。更新需要GitHub和npm网络，不是完整离线安装。

0.1.9及更早版本、启动不了或找不到命令时，用下面的安装指令。开发目录、npm安装和自定义 `SFLS_HOME` 不会被自动覆盖。

## Mac 安装／升级：复制一行

```sh
f=$(mktemp) && curl --proto '=https' --proto-redir '=https' -fL 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.18/install.sh' -o "$f" && bash "$f"
```

## Windows：在 PowerShell 复制一行

不是CMD。学校禁止脚本时，请老师按学校批准的方式预装，不要关闭安全防护。

```powershell
& { $f = Join-Path ([IO.Path]::GetTempPath()) ('sfls-' + [guid]::NewGuid() + '.ps1'); Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.18/install.ps1' -OutFile $f; & $f }
```

仓库中的小型ZIP是联网包，不含全部环境；缺环境时还需nodejs.org、GitHub或PyPI。无法访问GitHub时，使用老师从平台分发的完整离线包。Gitee是安装文件镜像，`sfls update`仍使用GitHub和npm，不会自动改走Gitee。

也可下载 [Mac 0.1.18](https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.18/SFLS-0.1.18-mac.zip) / [Windows 0.1.18](https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.18/SFLS-0.1.18-windows.zip)，完整解压后运行 `Install.command` / `Install.cmd`。Mac不能双击时，在安装包目录执行 `bash Install.command`。安装器未代码签名，不绕过系统安全策略。

## 课堂完整离线包

教师平台已发布 [Windows 0.1.18 完整离线包](http://124.222.152.227/downloads/sfls/SFLS-0.1.18-offline-windows.zip) / [Mac 0.1.18 完整离线包](http://124.222.152.227/downloads/sfls/SFLS-0.1.18-offline-mac.zip)。内含SFLS、Node.js 22.22.0、Python 3.12.12和pygame 2.6.1；安装这些组件不需要访问GitHub、npm或PyPI，AI对话和平台操作仍需联网，新任务额外依赖可能需联网。

服务器暂用HTTP。请从本仓库HTTPS页面取得下列摘要核对下载完整性；这不等同于软件签名。

```text
9bcb5b0001f618a04a1e092d15b1928e3e0feec415cfa67f4cd64e009bf212a9  SFLS-0.1.18-offline-windows.zip
e17d8bab200ebaee0c72dc23d947cb5172b508f7519cf86740c54a7a2e12b0ee  SFLS-0.1.18-offline-mac.zip
```

[机房部署与样机验收说明](http://124.222.152.227/downloads/sfls/SFLS-0.1.18-classroom-installation.txt)（包含给老师的沟通文本、保留目录和逐项验收清单）。

完整解压后运行安装器，无需先卸载。安装属于当前电脑用户；教师账号装好不等于学生账号可用，有还原系统的机房还需确认重启后能保留。

## 这一版

本次修复更新检查无进度提示、离线环境缺失却误报成功的问题；完整包会核验并修复环境，安装失败时恢复原入口。提交 ZIP 改为“学号_姓名_任务标题_完整提交编号.zip”，原提交编号仍用于后台归属，旧包仍可重试。

- 第一课共同体验；第二课起两班宏观路线随 `materials/TASK.md` 提供。旧任务不会自动更新，需教师另发新版。两班共用局部L1—L4帮助。
- 默认先开放表达，一轮补一个缺口，按需才给选项。关键代码先邀请试写1–3行；已尝试、不会或想看示范时解释并帮写，不以答对或手打为条件。
- `Start`、`sfls`、`sfls run` 统一启动。完整离线包的本地依赖自动准备；本课环境缺pip时用ensurepip修复，不改系统Python。
- 新配置默认官方 `deepseek/deepseek-flash`，保留已有自定义模型。配置可用不等于账号权限、模型效果或网页传图已验收。
- 新版个人任务包携带本课限权凭据，经服务器验证后不必重复输入学号密码；旧任务包保留原登录方式，凭据过期或不匹配需从本人平台重新下载。
- 提交前可选一起回顾真实代码，串联目标、需求、算法/方法与关键代码；不会就解释、可直接跳过。选择回顾后本次不打包或上传，之后再次输入 `/submit` 或 `/pack` 才继续。

历史模型测试出现过讲解、注释、验证来源和支持漏记问题，新提示不代表已全部解决，仍需核对真实对话。0.1.11/0.1.12旧离线包有启动语法错误，不再分发；旧标签仅追溯。

## 每课使用

从本人平台下载任务包，解压到新文件夹，双击 `Start` 或在任务目录运行 `sfls`。新版个人任务包使用本课限权凭据，不要互相转发；旧任务仍用原登录方式，仅升级客户端不会替换旧任务包或部署服务器。

首次或换身份时按需配置API key，输入不回显；每个新任务首次启动会按需确认本课key，回车可沿用同身份已保存的key。老师换key时填写新key；也可退出SFLS，在任务目录运行 `sfls model`，再运行 `sfls`。升级本身不清理登录与密钥，失效凭据仍需更新。Pi的 `/login` 不是学生登录。不要把密码或key写进工程、README或聊天。

直接说“帮我运行一下／停一下”，或 `/play`、`/stop`；图形窗口在本机打开，`input()`/curses交互终端暂不支持。关闭作品后 `/submit` 确认上传，或 `/pack` 保存ZIP上传平台。若选择一起回顾代码，结束或想跳过时再次输入相应提交命令，不要求先答对。本地init示例与体验包不能正式提交。

打包后再改代码，用 `/repack`（终端用 `sfls pack --new`），旧ZIP保留。`/submit` 重传待提交原包，不自动收集后续修改。包内原始对话、代码版本、工具输出和客户端时间供复核；AI支持自述不是掌握评分，耗时不是有效学习时长。

SFLS不是系统沙箱，请用老师指定目录与普通权限。课堂暂仅允许 `http://124.222.152.227` 的HTTP例外，密码/凭据未加密，请勿复用个人密码；其他公网HTTP拒绝，证书校验不关闭。启用HTTPS后应撤销例外。

## 卸载

退出所有窗口后运行 `sfls uninstall`，核对范围并输入 `yes`。默认清理个人SFLS程序/环境、账户、key和配置，移除个人命令入口；不扫描或删除任务作品、对话、提交包、系统Python或服务器数据。

`sfls uninstall --keep-data` 保留个人配置，`sfls uninstall --dry-run` 仅预览。共用电脑谨慎保留密钥。启动不了可从包中运行 `bash Uninstall.command`（Mac）或 `& .\Uninstall.ps1`（Windows）。活动进程、目录链接或自定义配置会停止清理。npm全局安装另用 `npm uninstall -g @keroroinu/sfls`。

版本标签不可变，不移动旧标签；两平台SHA-256见 `SHA256SUMS`。SFLS自有代码的课堂发行不代表授予开源许可，第三方许可见包内 `THIRD_PARTY_NOTICES.md`。
