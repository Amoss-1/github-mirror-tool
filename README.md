# GitHub 镜像工具集

公司内网访问 GitHub 不稳定？这组工具帮你解决 clone 和 push 的问题。

## 工具列表

| 工具 | 功能 | 原理 |
|------|------|------|
| `ghclone` | 镜像克隆仓库 | 走国内 CDN 镜像下载 |
| `ghpush` | API 方式推送文件 | 通过 gh API 上传，绕过 git push |

## 适用场景

| 你的问题 | 用哪个 |
|----------|--------|
| `git clone` 超时 | `ghclone` |
| `git push` 连不上 | `ghpush` |
| 浏览器能上 GitHub 但命令行不行 | `ghclone` + `ghpush` |
| 完全上不了 GitHub | 需要代理或 VPN |

## 安装

### 前提条件

- Git Bash（Windows）或 bash（Mac/Linux）
- `ghpush` 需要 [GitHub CLI](https://cli.github.com) 并登录

### 方式一：手动安装（推荐）

```bash
# 下载脚本
# 把 ghclone 和 ghpush 放到 ~/bin/ 目录
mkdir -p ~/bin
cp ghclone ghpush ~/bin/
chmod +x ~/bin/ghclone ~/bin/ghpush

# 确保 ~/bin 在 PATH 中
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

### 方式二：运行安装脚本

```bash
bash install.sh
```

## 使用

### ghclone — 克隆仓库

```bash
# 短格式（推荐）
ghclone GEO-optimizer/GEO

# 完整地址
ghclone https://github.com/GEO-optimizer/GEO.git

# 查看帮助
ghclone
```

原理：依次尝试 `ghproxy.com` → `mirror.ghproxy.com` → `ghproxy.net`，全失败才直连。

### ghpush — 推送文件

```bash
# 上传单个文件到当前仓库
ghpush README.md

# 上传整个目录
ghpush .

# 上传到指定仓库
ghpush src/ Amoss-1/my-repo

# 带自定义提交信息
ghpush main.py user/repo 'feat: 新功能'
```

原理：通过 GitHub API 上传文件，不走 git push 通道。

限制：
- 单文件不能超过 1MB
- 只能上传文本文件
- 需要 gh CLI 已登录

## 工作原理

```
git clone / git push 连不上 GitHub？
  │
  ├─ clone → ghclone（国内镜像下载）
  │
  └─ push  → ghpush（API 上传）
```

## 常见问题

**Q: ghclone 克隆失败？**
A: 镜像站有时会失效，等几分钟重试。私有仓库不支持镜像克隆。

**Q: ghpush 上传失败？**
A: 确认 `gh auth status` 已登录。单文件超过 1MB 会被跳过。

**Q: 这个工具安全吗？**
A: ghclone 只下载公开仓库，不涉及账号。ghpush 通过官方 gh CLI 操作，走 HTTPS 加密通道。

**Q: Windows 能用吗？**
A: 在 Git Bash 中使用。需要先安装 Git 和 GitHub CLI。

## License

MIT
