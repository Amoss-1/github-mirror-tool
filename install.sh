#!/bin/bash
# GitHub 镜像克隆工具 - 安装脚本

set -e

echo "=== 安装 GitHub 镜像克隆工具 ==="

# 确定安装目录
INSTALL_DIR="$HOME/bin"
mkdir -p "$INSTALL_DIR"

# 下载 ghclone 脚本
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ -f "$SCRIPT_DIR/ghclone" ]; then
  cp "$SCRIPT_DIR/ghclone" "$INSTALL_DIR/ghclone"
else
  echo "错误: 找不到 ghclone 脚本"
  exit 1
fi

chmod +x "$INSTALL_DIR/ghclone"

# 检查 PATH
if ! echo "$PATH" | grep -q "$HOME/bin"; then
  echo 'export PATH="$HOME/bin:$PATH"' >> "$HOME/.bashrc"
  echo "已添加 $HOME/bin 到 PATH（请运行 source ~/.bashrc 生效）"
fi

echo ""
echo "✓ 安装完成！"
echo ""
echo "使用方法:"
echo "  ghclone GEO-optimizer/GEO"
echo "  ghclone https://github.com/xxx/xxx.git"
echo ""
echo "可选: 配置 hosts 文件加速，详见 README.md"
