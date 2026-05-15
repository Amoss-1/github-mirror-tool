# GitHub 镜像克隆工具

国内访问 GitHub 不稳定？这个工具帮你自动走镜像克隆仓库。

## 功能

- 自动尝试多个国内镜像源
- 镜像全失败才回退直连
- 支持短格式输入（`用户名/仓库名`）
- 只影响 clone 操作，不影响你的 push/pull/其他网络

## 安装

### 方式一：一键安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/github-mirror-tool/main/install.sh | bash
```

或下载后运行：

```bash
bash install.sh
```

### 方式二：手动安装

1. 下载 `ghclone` 脚本
2. 放到你的 PATH 目录下（如 `~/bin/` 或 `/usr/local/bin/`）
3. 添加执行权限：`chmod +x ghclone`

### 配置 hosts（可选，推荐）

在 `C:\Windows\System32\drivers\etc\hosts`（Windows）或 `/etc/hosts`（Mac/Linux）末尾添加：

```
# GitHub 加速
20.205.243.166    github.com
20.205.243.165    codeload.github.com
20.205.243.168    api.github.com
185.199.108.215   github.githubassets.com
185.199.108.133   raw.githubusercontent.com
140.82.113.3      gist.github.com
```

> 注意：hosts 中的 IP 可能过期，如果连不上请查询最新 IP 更新。

## 使用

```bash
# 短格式（推荐）
ghclone GEO-optimizer/GEO

# 完整地址
ghclone https://github.com/GEO-optimizer/GEO.git

# 查看帮助
ghclone
```

## 工作原理

```
ghclone GEO-optimizer/GEO
  ↓
自动拼接: https://github.com/GEO-optimizer/GEO.git
  ↓
依次尝试镜像:
  1. https://ghproxy.com/https://github.com/...
  2. https://mirror.ghproxy.com/https://github.com/...
  3. https://ghproxy.net/https://github.com/...
  ↓
全部失败 → 回退直连 github.com
```

## 安全性

| 关注点 | 说明 |
|--------|------|
| 影响范围 | 只影响 clone 操作，push/pull 走直连 |
| 账号安全 | 不涉及你的 GitHub 账号密码 |
| 私有仓库 | 私有仓库请直接用 `git clone`，不走镜像 |
| hosts 修改 | 只影响 GitHub 域名的 DNS 解析，不影响其他网站 |

## 常见问题

**Q: 克隆失败怎么办？**
A: 镜像站有时会失效，等几分钟重试。也可以直接 `git clone` 试试直连。

**Q: 能用在私有仓库吗？**
A: 不建议。私有仓库需要认证，镜像站无法处理。请用 `git clone` 直连。

**Q: Windows 能用吗？**
A: 需要 Git Bash 或 WSL。在 Git Bash 中使用。

## License

MIT
