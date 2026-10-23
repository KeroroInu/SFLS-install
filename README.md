# SFLS 安装与升级

当前版本：**0.1.20，课堂试用版**。一键安装、`sfls update` 和课堂平台 Windows/Mac 完整离线包使用同一版本；自动更新以本仓库 `main/latest.json` 为准。历史版本仅供追溯，固定标签不移动。

公开仓库只放程序发行件，不放学生数据或 API key。联网安装件来自源码提交 `5b46c3567c51c20ca7735e28ce1b7c4956dbeeec`。217 项自动测试中 216 项通过、1 项 Windows 原生检查跳过；已用 0.1.18 的真实更新提取器验证新清单及两个新 ZIP 的兼容性。自动测试不代替学校真机验收或课堂学习效果验证。

## 已安装：直接升级

先结束 AI 操作、关闭游戏和其他 SFLS 窗口，在系统终端运行：

```sh
sfls update
```

SFLS 对话中也可输入 `/update`（兼容 `/updata`）；仅检查版本用 `sfls update --check`。按提示确认后保存记录并运行安装器，仍可能询问下载或个人命令注册许可。完成后用 `sfls --version` 核对 **0.1.20**，回原任务文件夹用 `sfls --resume` 继续。

升级不清理作品、对话、账户和模型密钥；失败时恢复旧启动入口。有效的现行离线 Python/wheel 关联会保留；不会通过扫描历史目录猜测恢复已丢失的关联。自动更新需要 GitHub 和 npm 网络，不是完整离线更新。启动不了、找不到命令或版本太旧时，可重新运行下面的安装器，无需先卸载。

## Mac：一键安装／升级

```sh
f=$(mktemp) && curl --proto '=https' --proto-redir '=https' -fL 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.20/install.sh' -o "$f" && bash "$f"
```

## Windows：在 PowerShell 安装／升级

不是 CMD。学校策略禁止脚本时，请老师按学校批准的方式预装，不要关闭安全防护。

```powershell
& { $f = Join-Path ([IO.Path]::GetTempPath()) ('sfls-' + [guid]::NewGuid() + '.ps1'); Invoke-WebRequest -UseBasicParsing -Uri 'https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.20/install.ps1' -OutFile $f; & $f }
```

也可下载 [Mac 0.1.20 联网包](https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.20/SFLS-0.1.20-mac.zip) / [Windows 0.1.20 联网包](https://raw.githubusercontent.com/KeroroInu/SFLS-install/v0.1.20/SFLS-0.1.20-windows.zip)，完整解压后运行 `Install.command` / `Install.cmd`。Mac 无法双击时，在安装包目录执行 `bash Install.command`。

这些小型 ZIP 不含全部环境，缺环境时仍需 nodejs.org、npm、GitHub 或 PyPI。不能访问 GitHub 时可使用 [Gitee 安装镜像](https://gitee.com/kerorororo/sfls-install)；重新运行镜像安装器可升级并保留个人配置及作品，但仍需其余依赖站点。`sfls update` 的自动更新源仍是 GitHub，不会自动改走 Gitee。学校机房优先使用下面的完整离线包。

## 课堂完整离线包

| 电脑 | 当前完整包 |
| --- | --- |
| Windows 10/11，64 位 x64 | [Windows 0.1.20](http://124.222.152.227/downloads/sfls/SFLS-0.1.20-offline-windows.zip) |
| Mac，Apple 芯片或 Intel | [Mac 0.1.20](http://124.222.152.227/downloads/sfls/SFLS-0.1.20-offline-mac.zip) |

完整包内含 SFLS、Node.js 22.22.0、个人 Python 和 pygame 2.6.1。Windows Python 为 3.12.15（build 20261020），Mac 为 3.12.12；安装这些组件不需要访问 GitHub、npm 或 PyPI。AI 对话、平台操作及任务新增的额外依赖仍可能需要联网。Windows 沿用已经样机验证的 0.1.20 包；Mac 包为本次同版本发行件。

服务器暂用 HTTP。请从本仓库 HTTPS 页面取得下列摘要核对完整性；这不等同于软件签名。

```text
b19bc4e03f9a8f2f984db6e9c97362070bca984930796d142cdfcee2623ef7e7  SFLS-0.1.20-offline-windows.zip
143681e9c7cb9c1edb2c6c782afda2d992c507778fa5a196d17e98e2effa8d31  SFLS-0.1.20-offline-mac.zip
```

完整解压后运行安装器，无需先卸载；安装在当前电脑用户的个人目录，不覆盖学校系统 Python。教师账号装好不等于学生账号可用，有还原系统的机房还需确认重启后能保留。[Windows 机房部署与样机验收说明](http://124.222.152.227/downloads/sfls/SFLS-0.1.20-classroom-installation.txt)包含保留目录和验收清单；Mac 的步骤见完整包内说明。

## 每课使用

从本人平台下载任务包，解压到新文件夹，双击 `Start` 或在任务目录运行 `sfls`。新版个人任务包携带本课限权凭据，经服务器验证后不必重复输入学号密码；不要互相转发。旧任务包保留原登录方式，凭据失效或不匹配时重新从本人平台下载。

首次或换身份时按需配置老师提供的 API key，输入不回显。每个新任务首次启动会按需确认本课 key，回车可沿用同身份已保存的 key；老师换 key 时填写新的。也可退出 SFLS，在任务目录运行 `sfls model` 重新设置。Pi 的 `/login` 不是学生登录。不要把密码或 key 写进工程、README 或聊天。

- 第一课共同体验；第二课起两班宏观路线由任务包提供，两班共用局部四级支架。客户端升级不会替换老师已发出的旧任务。
- 默认先让学生开放表达，一次补一个缺口，按需才给选项。关键代码先邀请试写 1–3 行；不会、已尝试或想看示范时解释并帮写，不以答对或手打为条件。
- 直接说“帮我运行一下／停一下”，或使用 `/play`、`/stop`。图形窗口在本机打开，`input()`/curses 交互终端暂不支持。
- 完成后 `/submit` 确认上传，或 `/pack` 保存 ZIP 后上传平台，以成功回执为准。提交前可一起阅读真实代码，简短回顾目标、需求、算法/方法与关键代码；可直接跳过。选择回顾后，结束或想跳过时需再次输入 `/submit` 或 `/pack` 才继续提交。
- 打包后又修改代码，用 `/repack`（系统终端 `sfls pack --new`）生成新包；旧 ZIP 保留。`/submit` 重传待提交原包，不自动收集后续修改。ZIP 名使用“学号_姓名_任务标题_完整提交编号”，后台仍以原编号关联身份。

原始对话、代码版本、工具输出和客户端时间供后续复核；AI 的支持自述不是掌握评分，耗时也不等于有效学习时长。历史模型测试中的讲解、注释和支持漏记问题仍需结合真实对话检查。

## 卸载与安全

退出所有窗口后运行 `sfls uninstall`，核对范围并输入 `yes`。默认清理个人 SFLS 程序/环境、账户、key 和配置，移除个人命令入口；不扫描或删除任务作品、对话、提交包、系统 Python 或服务器数据。

`sfls uninstall --keep-data` 保留个人配置；`sfls uninstall --dry-run` 仅预览。共用电脑谨慎保留密钥。启动不了可从包中运行 `bash Uninstall.command`（Mac）或 `& .\Uninstall.ps1`（Windows）。活动进程、目录链接或自定义配置会停止清理。npm 全局安装另用 `npm uninstall -g @keroroinu/sfls`。

SFLS 能执行本机命令，不是系统沙箱，请在老师指定目录和普通权限下使用。课堂暂仅允许 `http://124.222.152.227` 的 HTTP 例外，密码/凭据未加密，请勿复用个人密码；其他公网 HTTP 拒绝，证书校验不关闭。启用 HTTPS 后应撤销例外。

安装器未代码签名，不绕过系统安全策略。两平台联网 ZIP 的 SHA-256 见 [SHA256SUMS](SHA256SUMS)。公开可下载不等同于授予 SFLS 自有代码开源许可；第三方许可见包内 `THIRD_PARTY_NOTICES.md`。
