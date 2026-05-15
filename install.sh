#!/bin/bash
# GitHub 镜像工具集 - 安装脚本
# https://github.com/Amoss-1/github-mirror-tool

set -e

echo "=== 安装 GitHub 镜像工具集 ==="

# 确定安装目录
INSTALL_DIR="$HOME/bin"
mkdir -p "$INSTALL_DIR"

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 安装 ghclone
if [ -f "$SCRIPT_DIR/ghclone" ]; then
  cp "$SCRIPT_DIR/ghclone" "$INSTALL_DIR/ghclone"
  chmod +x "$INSTALL_DIR/ghclone"
  echo "OK ghclone -> $INSTALL_DIR/ghclone"
else
  echo "WARN: 找不到 ghclone 脚本，跳过"
fi

# 安装 ghpush
if [ -f "$SCRIPT_DIR/ghpush" ]; then
  cp "$SCRIPT_DIR/ghpush" "$INSTALL_DIR/ghpush"
  chmod +x "$INSTALL_DIR/ghpush"
  echo "OK ghpush -> $INSTALL_DIR/ghpush"
else
  echo "WARN: 找不到 ghpush 脚本，跳过"
fi

# 检查 PATH
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  echo "已添加 $HOME/bin 到 PATH（请运行 source ~/.bashrc 生效）"
fi

# 检查 gh CLI
if command -v gh &>/dev/null || [ -f "/c/Program Files/GitHub CLI/gh.exe" ]; then
  echo "OK gh CLI 已安装"
else
  echo "WARN: gh CLI 未安装，ghpush 需要它才能工作"
  echo "      安装: https://cli.github.com 或 winget install GitHub.cli"
fi

echo ""
echo "=== 安装完成 ==="
echo ""
echo "ghclone - 镜像克隆:  ghclone GEO-optimizer/GEO"
echo "ghpush  - API 推送:   ghpush README.md"
echo "ghpush  - 上传目录:   ghpush ."
