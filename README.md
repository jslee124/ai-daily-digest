# AI Daily Digest

从 Karpathy 推荐的 90 个热门技术博客（Hacker News Popularity Contest 2025）抓取最新文章，通过 DeepSeek AI 评分/摘要，生成结构化的 Markdown 每日精选。

## 功能

- 批量抓取 RSS/Atom，按时间范围过滤
- AI 评分（相关性/质量/时效性）+ 自动分类（AI/安全/工程/工具/观点/其他）
- 生成中文标题、结构化摘要、推荐理由、关键词
- 生成可读的 Markdown 报告：Top 3、分类列表、Mermaid 图表、话题标签

## 运行环境

- Node.js（用于 `npx`）
- `bun`（可通过 `npx -y bun` 自动拉起）
- DeepSeek API Key（通过环境变量 `DEEPSEEK_API_KEY` 提供）

## 快速开始（一键脚本）

最简单的方式是使用 `daily-digest.sh` 一键运行脚本：

1) 首次使用需要通过 OpenCode 配置：
   - 运行 `opencode`
   - 在 OpenCode 中输入 `/digest`
   - 完成配置后会自动保存到 `~/.hn-daily-digest/config.json`

2) 后续直接运行：

```bash
./daily-digest.sh
```

脚本会自动读取配置并生成报告，报告保存在 `./output/` 目录下，同时会在终端高亮显示。

---

## 快速开始（直接运行脚本）

1) 设置环境变量：

```bash
export DEEPSEEK_API_KEY="<your-deepseek-api-key>"
```

2) 运行（默认：48 小时、15 篇、中文）：

```bash
mkdir -p ./output

npx -y bun ./.opencode/skills/ai-daily-digest/scripts/digest.ts \
  --hours 48 \
  --top-n 15 \
  --lang zh \
  --output ./output/digest-$(date +%Y%m%d).md
```

参数说明：

- `--hours <n>`：抓取最近 n 小时（默认 48）
- `--top-n <n>`：最终保留 n 篇（默认 15）
- `--lang <zh|en>`：输出语言（默认 zh）
- `--output <path>`：输出文件路径（默认 `./digest-YYYYMMDD.md`）

## 终端显示优化

脚本会自动检测并使用以下工具美化 Markdown 显示：

- **优先**：`bat` - 支持语法高亮、行号、Git 差异（推荐！）
- **备选**：`glow` - 专门的终端 Markdown 渲染器
- **回退**：`cat` - 普通文本显示

安装推荐工具：

```bash
# macOS 使用 Homebrew
brew install glow  # 更好的 Markdown 渲染体验
```

## OpenCode 用法（Skill）

本仓库包含一个 OpenCode skill：`ai-daily-digest`。

- 入口文档：`.opencode/skills/ai-daily-digest/SKILL.md`
- 主脚本：`.opencode/skills/ai-daily-digest/scripts/digest.ts`

如果你在 OpenCode 里加载了该 skill，可使用 `/digest` 走交互式流程（时间范围、精选数量、输出语言、API Key）。

## 输出内容

生成的 Markdown 报告通常包含：

- `## 📝 今日看点`：3-5 句趋势总结
- `## 🏆 今日必读`：Top 3 深度展示（标题/摘要/理由/标签）
- `## 📊 数据概览`：统计表 + Mermaid 分类饼图/关键词柱状图 + 话题标签云
- 分类文章列表：按 6 大分类分组

## API Key 安全

- 项目代码不会把 Key 写入仓库：脚本只读取 `process.env.DEEPSEEK_API_KEY`
- 不要把 Key 直接写进源码或提交到 GitHub
- 建议仅通过环境变量注入（或在你本地的私有配置中保存）

获取 DeepSeek API Key：<https://platform.deepseek.com/api_keys>

## 常见问题

- `DEEPSEEK_API_KEY not set`：请先 `export DEEPSEEK_API_KEY=...`
- 抓取失败：部分 RSS 源可能临时不可用，脚本会跳过失败的源继续运行
- `No articles found in time range`：增大 `--hours`（例如 `--hours 168`）
