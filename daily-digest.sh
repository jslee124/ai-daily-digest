#!/bin/bash

# AI Daily Digest 一键运行脚本
# 自动从配置文件读取参数，无需交互

set -e

SKILL_DIR="/Users/mori/codes/ai-daily/.opencode/skills/ai-daily-digest"
CONFIG_FILE="$HOME/.hn-daily-digest/config.json"
OUTPUT_DIR="./output"

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 AI Daily Digest 自动化脚本${NC}"
echo "========================================"

# 检查配置文件
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}❌ 错误：未找到配置文件${NC}"
    echo ""
    echo "首次使用需要配置，请运行:"
    echo -e "${YELLOW}  opencode${NC}"
    echo -e "然后在 opencode 中输入: ${YELLOW}/digest${NC}"
    echo ""
    echo "配置完成后会自动保存，下次可直接运行此脚本"
    exit 1
fi

# 读取配置
echo -e "${BLUE}📖 读取配置...${NC}"
API_KEY=$(cat "$CONFIG_FILE" | grep -o '"deepseekApiKey": "[^"]*"' | cut -d'"' -f4)
TIME_RANGE=$(cat "$CONFIG_FILE" | grep -o '"timeRange": [0-9]*' | cut -d' ' -f2)
TOP_N=$(cat "$CONFIG_FILE" | grep -o '"topN": [0-9]*' | cut -d' ' -f2)
LANGUAGE=$(cat "$CONFIG_FILE" | grep -o '"language": "[^"]*"' | cut -d'"' -f4)

# 默认值
if [ -z "$TIME_RANGE" ]; then
    TIME_RANGE=48
fi
if [ -z "$TOP_N" ]; then
    TOP_N=15
fi
if [ -z "$LANGUAGE" ]; then
    LANGUAGE="zh"
fi

# 检查 API Key
if [ -z "$API_KEY" ] || [ "$API_KEY" = "" ]; then
    echo -e "${RED}❌ 错误：配置文件中缺少 DeepSeek API Key${NC}"
    echo ""
    echo "请运行 opencode 并执行 /digest 重新配置"
    exit 1
fi

echo -e "${GREEN}✓ 配置加载成功${NC}"
echo ""
echo -e "配置参数："
echo -e "  • 时间范围: ${YELLOW}${TIME_RANGE}小时${NC}"
echo -e "  • 精选数量: ${YELLOW}${TOP_N}篇${NC}"
echo -e "  • 输出语言: ${YELLOW}$([ "$LANGUAGE" = "zh" ] && echo '中文' || echo 'English')${NC}"
echo ""

# 创建输出目录
mkdir -p "$OUTPUT_DIR"

# 生成输出文件名
OUTPUT_FILE="$OUTPUT_DIR/digest-$(date +%Y%m%d-%H%M).md"

echo -e "${BLUE}⏳ 开始抓取和生成摘要...${NC}"
echo ""

# 运行主脚本
export DEEPSEEK_API_KEY="$API_KEY"

npx -y bun "${SKILL_DIR}/scripts/digest.ts" \
  --hours "$TIME_RANGE" \
  --top-n "$TOP_N" \
  --lang "$LANGUAGE" \
  --output "$OUTPUT_FILE"

# 检查是否成功生成
if [ -f "$OUTPUT_FILE" ]; then
    echo ""
    echo -e "${GREEN}✅ 每日摘要生成成功！${NC}"
    echo ""
    echo -e "📄 报告文件: ${YELLOW}${OUTPUT_FILE}${NC}"
    echo ""
    
    # 显示文件大小
    FILE_SIZE=$(ls -lh "$OUTPUT_FILE" | awk '{print $5}')
    echo -e "文件大小: ${FILE_SIZE}"
    
    # 可选：自动打开文件（macOS）
    # open "$OUTPUT_FILE"
else
    echo -e "${RED}❌ 生成失败，请检查错误信息${NC}"
    exit 1
fi

# 显示生成的摘要
cat "$OUTPUT_FILE"
echo ""