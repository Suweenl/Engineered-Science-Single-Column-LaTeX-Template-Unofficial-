# Engineered Science 单栏 LaTeX 模板（非官方）

> 这是一个 **非官方** 的 LaTeX ，用于复现 *Engineered Science* 期刊的单栏排版风格：自定义纸张尺寸、蓝色上标数字引用、蓝色粗体图表标题等。该项目与期刊**无隶属或背书关系**，仅供研究与教学使用。投稿请以期刊**最新官方指南**为准。

---

## 一、模板适用与特点

- **目标期刊**：*Engineered Science*（仿制其外观与样式，**非官方**）  
- **排版**：单栏、纸张 **22.2 cm × 28.5 cm**
- **引用**：文中 `\cite{}` 输出 **蓝色上标** `[n]`，多条合并时**逗号也上标**
- **图表**：`Fig.` / `Table` 标签为**蓝色加粗**，说明文字黑色
- **交叉引用**：内置 `\figref`、`\tabref`、`\secref`、`\eqnref`，点击即跳转
- **子图**：启用 `subcaption`，支持 **1×N** 横排（单行多图）
- **文献**：`biblatex + biber` 数值型样式，期刊名为**蓝色斜体**

> 适合在 Overleaf 或本地 XeLaTeX / LuaLaTeX 环境使用。

---

## 二、版式与字体规范（一目了然）

**页面与正文**  
- 纸张：`22.2 cm × 28.5 cm`  
- 正文字体：Times New Roman，**12pt**  
- 段落缩进：普通段落 **1.5em**；**章节标题后的首段不缩进**（保持 LaTeX 默认）

**标题层级**  
- Section：Times New Roman，**10.5pt 加粗**（编号如 “1.”）  
- Subsection：Times New Roman，**10.5pt 加粗**  
- Subsubsection：Times New Roman，**10.5pt 加粗**

**首页信息（\maketitle）**  
- 标题：**Calibri 20pt 加粗**  
- 作者：Times New Roman **10pt**  
- 单位：Times New Roman **9pt 斜体**  
- 日期：Times New Roman **10pt**

**摘要与关键词**  
- “Abstract” 标题：**Calibri 12pt 加粗**，左对齐  
- 摘要正文：**Calibri 10.5pt**（约 12pt 行距），整栏宽度；标题下有细横线  
- 关键词（`keywords` 环境）：*Keywords* 为 **10.5pt 斜体**，内容 **10pt**

**图表标题**  
- 图：`Fig.` 标签**蓝色加粗**，说明黑色；格式示例：`Fig. 1: …`  
- 表：`Table` 标签**蓝色加粗**，说明黑色；与图一致

---

## 三、`.ttf` 字体怎么放、为什么放

- **是什么**：`.ttf` 是 TrueType Font 文件。XeLaTeX / LuaLaTeX 通过 `fontspec` 直接加载。  
- **放在哪里**：建议放在仓库的 `/` 目录，模板会**优先**加载本地 `.ttf`（常见命名如下）。
  - `/times.ttf, timesbd.ttf, timesi.ttf, timesbi.ttf`
  - `/calibri.ttf, calibrib.ttf, calibrii.ttf, calibriz.ttf`
- **为什么要放**：
  - 保证与官方的字体外观一致  
  - **加快 Overleaf 编译**（避免在线检索系统字体）
- **注意授权**：请确认字体的使用与分发许可。无授权不建议提交到仓库，可依赖系统字体。

---

## 四、项目结构与最小示例

**最小 `main.tex`**：
```latex
\documentclass{es-template} % or [draft]

\title{Your Title}
\authors{Author A, Author B}
\affils{Affiliation line 1; Affiliation line 2}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
Your abstract text goes here.
\end{abstract}

\section{Introduction}\label{sec-intro}
Underwater landmarks,\cite{keyA,keyB} see \figref{fig:six-wide} and Eq.~\eqref{eq:density}.
Our ablation appears in \tabref{tab:ablation}.

\begin{figure}[t]
  \centering
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/a.jpg}\caption{}\label{fig:a}
  \end{subfigure}\hfill
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/b.jpg}\caption{}\label{fig:b}
  \end{subfigure}\hfill
  % ... up to six items ...
  \caption{A one-line 1×N gallery.}\label{fig:six-wide}
\end{figure}

\begin{equation}
  \rho_{\text{oil}}=\frac{m_{2}-m_{0}}{m_{1}-m_{0}}\,\rho_{\text{water}}
  \label{eq:density}
\end{equation}

\printbibliography
\end{document}
```

---

## 五、交叉引用与文献样式（按模板来）

**文献引用**  
- 单条：`...,\cite{keyA}`  
- 多条：`...,\,\cite{keyA,keyB}`（**逗号也为上标**）  
- 标点统一写在 `\cite` 前面；需要更紧凑可用 `\,` 提供细空格。

**图/表/节/公式**  
- 图：`\figref{fig:pipeline}` → *Fig. X*（蓝色可点击）  
- 表：`\tabref{tab:ablation}` → *Table Y*  
- 节：`\secref{sec-intro}` → *Section 1*  
- 公式：`Eq.~\eqref{eq:loss}` 或 `\eqnref{eq:loss}` → “Eq. (1)”

**参考文献（`biblatex + biber`）**  
- 数值型、按出现顺序；**期刊名蓝色斜体**、文章标题黑色无引号、DOI 为 `doi: ...`  
- Overleaf 建议 **Recompile from scratch** 再编两次，避免缓存导致的交叉引用问题。

---

## 六、图与 1×N 横排建议

**单图**
```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=\linewidth]{figures/pipeline.pdf}
  \caption{总体流程。}
  \label{fig:pipeline}
\end{figure}
```

**单行 1×6 图集**
```latex
\begin{figure}[t]
  \centering
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/a.jpg}\caption{}\label{fig:a}
  \end{subfigure}\hfill
  % 最多 6 块（每块 0.155–0.16\textwidth）
  \caption{单行 1×6 图集示例。}
  \label{fig:six-wide}
\end{figure}
```
> 避免同时设置 `width=` 与 `height=`；若需统一高度，使用 `height=..,keepaspectratio` 并省略 `width=`。

---

## 七、编译方式

- 引擎：**XeLaTeX / LuaLaTeX**（类文件强制）  
- 参考文献：**biber**（不是 bibtex）  
- Overleaf：菜单中选择 XeLaTeX；biber 自动执行

---

## 八、常见问题（快速定位）

1. **引擎报错**：仅支持 XeLaTeX / LuaLaTeX。  
---

## 九、协议与说明

- 免责声明：本模板仅复现视觉风格，**不代表**官方格式完全一致；投稿以**官方最新要求**为准。

