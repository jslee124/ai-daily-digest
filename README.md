# 📰 AI Daily Digest

智能抓取 Karpathy 推荐的顶级技术博客，通过 DeepSeek AI 多维度评分筛选，生成结构化每日精选摘要报告。

## ✨ 核心功能

### 智能内容筛选
- **批量 RSS 抓取**：从 90+ 个顶级技术博客并行抓取（支持 RSS/Atom 格式）
- **AI 三维度评分**：DeepSeek AI 从相关性、质量、时效性三个维度评分（1-10 分）
- **智能分类**：自动归类为 6 大类别
  - 🤖 **AI / ML** - 人工智能、机器学习、大语言模型
  - 🔒 **安全** - 安全漏洞、隐私保护、加密技术
  - ⚙️ **工程** - 软件工程、系统架构、编程语言
  - 🛠️ **工具 / 开源** - 开发工具、开源项目、新框架/库
  - 💡 **观点 / 杂谈** - 行业观点、个人思考、职业文化
  - 📝 **其他** - 以上类别之外的内容

### AI 摘要生成
- **中文标题翻译**：将英文标题翻译为自然的中文表达
- **结构化摘要**：4-6 句话概括核心内容，包含问题背景、关键论点、核心结论
- **推荐理由**：1 句话说明"为什么值得读"
- **关键词提取**：自动提取 2-4 个技术关键词

### 可视化报告
生成的 Markdown 报告包含：
1. **📝 今日看点** - AI 归纳的 3-5 句宏观趋势总结
2. **🏆 今日必读 Top 3** - 中英双语标题、结构化摘要、推荐理由、关键词标签
3. **📊 数据概览** - 统计表格 + Mermaid 分类饼图 + 高频关键词柱状图
4. **🏷️ 话题标签云** - 前 20 个高频关键词及其出现次数
5. **📈 纯文本图表** - 终端友好的 ASCII 柱状图
6. **分类文章列表** - 按 6 大分类分组展示，每篇含评分、摘要、标签

## 📂 项目结构

```
.
├── daily-digest.sh                 # 一键运行脚本（推荐）
├── .opencode/
│   └── skills/
│       └── ai-daily-digest/
│           ├── SKILL.md            # OpenCode Skill 文档
│           └── scripts/
│               └── digest.ts       # 主程序（RSS 抓取 + AI 评分）
├── output/                         # 生成的报告目录
└── README.md                       # 本文件
```

## 🚀 快速开始

### 方式一：OpenCode Skill（推荐）

最简单的方式，提供交互式配置向导：

```bash
opencode
```

在 OpenCode 中输入：

```
/digest
```

按提示选择：
- 时间范围（24h / 48h / 72h / 7天）
- 精选数量（10 / 15 / 20 篇）
- 输出语言（中文 / English）
- DeepSeek API Key

配置会自动保存到 `~/.hn-daily-digest/config.json`，下次可直接使用一键脚本。

### 方式二：一键脚本

配置完成后，直接运行：

```bash
./daily-digest.sh
```

脚本会自动：
- 读取已保存的配置
- 生成带时间戳的报告到 `./output/` 目录
- 使用 `glow` / `bat` / `cat` 自动在终端展示

**可选：全局使用**

```bash
# 1. 复制脚本到 home 目录
cp daily-digest.sh ~/

# 2. 在 ~/.zshrc 或 ~/.bashrc 中添加
export AI_DAILY_DIGEST_HOME="/Users/mori/codes/ai-daily"

# 3. 重新加载配置
source ~/.zshrc

# 4. 之后可在任意位置执行
~/daily-digest.sh
```

### 方式三：手动运行

适合需要自定义参数的场景：

```bash
# 设置 API Key
export DEEPSEEK_API_KEY="your-deepseek-api-key"

# 创建输出目录
mkdir -p ./output

# 运行（示例：抓取 72 小时内文章，精选 20 篇）
npx -y bun ./.opencode/skills/ai-daily-digest/scripts/digest.ts \
  --hours 72 \
  --top-n 20 \
  --lang zh \
  --output ./output/digest-$(date +%Y%m%d).md
```

## 📋 参数说明

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `--hours <n>` | 抓取最近 n 小时的文章 | 48 |
| `--top-n <n>` | AI 筛选后保留 n 篇精选 | 15 |
| `--lang <zh\|en>` | 输出语言（中文 / 英文） | zh |
| `--output <path>` | 输出文件路径 | ./digest-YYYYMMDD.md |

## 🔧 环境要求

- **Node.js** - 用于 `npx` 命令
- **Bun** - 运行时（通过 `npx -y bun` 自动安装）
- **DeepSeek API Key** - 必需，[在此获取](https://platform.deepseek.com/api_keys)

**可选（终端显示优化）**：
- `glow` - 专门的终端 Markdown 渲染器（推荐）
- `bat` - 支持语法高亮

```bash
# macOS 安装
crew install glow
# 或
brew install bat
```

## ⚙️ 配置说明

### 配置文件

路径：`~/.hn-daily-digest/config.json`

```json
{
  "deepseekApiKey": "your-api-key",
  "timeRange": 48,
  "topN": 15,
  "language": "zh",
  "lastUsed": "2026-02-15T12:00:00Z"
}
```

### 环境变量

| 变量名 | 说明 | 必需 |
|--------|------|------|
| `DEEPSEEK_API_KEY` | DeepSeek API Key | 是（手动运行时需要） |
| `AI_DAILY_DIGEST_HOME` | 项目根目录路径（包含 `.opencode/` 的目录） | 否（脚本不在项目目录时需要） |

## 🔒 API Key 安全

- 项目代码**不会**将 Key 写入仓库，只读取 `process.env.DEEPSEEK_API_KEY`
- 不要把 Key 直接写进源码或提交到 GitHub
- 配置文件保存在用户主目录（`~/.hn-daily-digest/`），已加入 `.gitignore`

## 📊 执行流程

```
Step 1/5: 抓取 RSS
  └─ 并发抓取 90+ 个 RSS 源（每批 10 个）
  └─ 支持 RSS 2.0 和 Atom 1.0 格式

Step 2/5: 时间过滤
  └─ 按 --hours 参数过滤最近文章

Step 3/5: AI 评分
  └─ 三维度评分（相关性/质量/时效性，各 1-10 分）
  └─ 自动分类 + 提取关键词
  └─ 每批 10 篇，并发 2 批

Step 4/5: 生成摘要
  └─ 中文标题翻译
  └─ 结构化摘要（背景/论点/结论）
  └─ 推荐理由生成

Step 5/5: 趋势总结
  └─ AI 生成今日技术圈趋势总结

输出：结构化 Markdown 报告
```

## 📝 数据源

90+ 个 RSS 源来自 [Hacker News Popularity Contest 2025](https://refactoringenglish.com/tools/hn-popularity/)，由 [Andrej Karpathy](https://x.com/karpathy) 推荐。

包含顶级技术博客如：
- **simonwillison.net** - Simon Willison 的博客
- **paulgraham.com** - Paul Graham 的随笔
- **overreacted.io** - Dan Abramov 的博客
- **gwern.net** - Gwern Branwen 的研究博客
- **krebsonsecurity.com** - 安全新闻
- **antirez.com** - Redis 作者 antirez 的博客
- **daringfireball.net** - John Gruber 的科技评论
- ...以及 80+ 其他优质技术博客

完整列表内嵌于 `digest.ts` 中。

## 🖼️ 输出示例

生成的报告包含：

1. **今日看点** - 宏观趋势总结
2. **Top 3 深度展示** - 带奖牌图标的精选文章
3. **数据概览** - 统计表 + Mermaid 图表
4. **分类列表** - 按 6 大分类详细展示

示例报告见 `output/digest-20260215-2148.md`

## 🛠️ 故障排除

### "DEEPSEEK_API_KEY not set"
需要提供 DeepSeek API Key，可在 https://platform.deepseek.com/api_keys 免费获取。

### "Failed to fetch N feeds"
部分 RSS 源可能暂时不可用，脚本会跳过失败的源并继续处理。只要成功抓取部分源，就会继续生成报告。

### "No articles found in time range"
尝试扩大时间范围（如从 24 小时改为 48 小时或 7 天）。

## 📄 技术栈

- **运行时**: Bun (TypeScript)
- **AI 模型**: DeepSeek Chat
- **数据源**: 90+ 个 RSS/Atom 订阅源
- **输出格式**: Markdown + Mermaid 图表

## 📜 许可证

MIT

---

*基于 [Hacker News Popularity Contest 2025](https://refactoringenglish.com/tools/hn-popularity/) RSS 源列表，由 [Andrej Karpathy](https://x.com/karpathy) 推荐*
