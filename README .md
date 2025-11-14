# Engineered Science Single-Column LaTeX Template (Unofficial)

> An unofficial LaTeX class that reproduces the single‑column page geometry, blue superscript numeric citations, and caption styles of the *Engineered Science* journal’s author template. This project is not affiliated with or endorsed by the journal; it is a community recreation for research and educational use.

> **Disclaimer**: This repository targets the look-and-feel of the *Engineered Science* journal template, but it is **not** an official template. It is a community-built replica based on publicly observable formatting rules. Always verify with the journal’s latest author guidelines before submission.

# Engineered Science-like Single-Column LaTeX Template (`es-template`)

> A XeLaTeX/LuaLaTeX class that reproduces an Engineered-Science-style **single-column** layout with blue superscript numeric citations, Times-based typography, and strict caption styling.  
> 适配 Overleaf / 本地 TeX Live。

## ✨ Features at a glance

- **单栏**排版，纸张尺寸 **22.2 cm × 28.5 cm**（期刊定制）
- **蓝色上标**数字引用（`[n]`），多条并列时**逗号也上标**
- `Fig.` / `Table` 标签**蓝色粗体**，正文黑色 Times
- 预设 `\figref`、`\tabref`、`\secref` 快速交叉引用（蓝色可点击）
- 图集**1×N 横排**、`subcaption` 已启用
- 公式引用 `\eqref` / 便捷 `\eqnref`，可选 Times-style 数学
- `biblatex` + `biber`，数值型、全部作者、期刊名蓝色斜体
- `\etal`、`\eg` 等缩写宏已内置，书写省心
- 字体优先从 `fonts/` 目录加载（减少 Overleaf 字体检索时间）

---

## 🔧 Quick Start

### 1) 目录结构建议
```
project/
├─ main.tex
├─ es-template.cls
├─ references.bib
├─ figures/ ...         % 图片
└─ fonts/               % 可选：Times/Calibri 本地字体（.ttf）
   ├─ times.ttf, timesbd.ttf, timesi.ttf, timesbi.ttf
   └─ calibri.ttf, calibrib.ttf, calibrii.ttf, calibriz.ttf
```

### 2) `main.tex` 最小示例
```latex
\documentclass{es-template} % or [draft]

\title{Your Title}
\authors{Author A, Author B}
\affils{Affiliation line 1; Affiliation line 2}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
Your abstract.
\end{abstract}

\section{Introduction}\label{sec-intro}
Underwater landmarks,\cite{keyA,keyB} see \figref{fig:six-wide}
and Eq.~\eqref{eq:density}. Our ablation in \tabref{tab:ablation}.

\begin{figure}[t]
  \centering
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/a.jpg}\caption{}\label{fig:a}
  \end{subfigure}\hfill
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/b.jpg}\caption{}\label{fig:b}
  \end{subfigure}\hfill
  % ... up to 6 items ...
  \caption{One-line 1×N gallery.}\label{fig:six-wide}
\end{figure}

\begin{equation}
  \rho_{\text{oil}}=\frac{m_{2}-m_{0}}{m_{1}-m_{0}}\,\rho_{\text{water}}
  \label{eq:density}
\end{equation}

\printbibliography
\end{document}
```

### 3) 编译方式
- **Engine:** XeLaTeX 或 LuaLaTeX（模板会强制检查）
- **Bibliography:** `biber`（不是 `bibtex`）
- **Overleaf:** Menu → Compiler: XeLaTeX；Biber 自动

---

## 🆚 What’s different from stock `article`?

- **页面**：`22.2×28.5 cm` + 定制页边距（几乎等效官方 Word 模板）
- **引用**：`\cite{...}` → **蓝色上标** `[n]`；**多条**时逗号也在上标里
- **期刊名**：参考文献 `journaltitle` **蓝色斜体**
- **标题**：节标题 `10.5pt`（Times），`Fig./Table` 蓝色粗体 + 冒号
- **工具宏**：`\figref`、`\tabref`、`\secref`、`\eqnref`、`\etal`、`\eg` 内置
- **图片**：内置 `subcaption`；推荐**一行 1×N** 横排

---

## 🔗 Cross-referencing (规范用法)

### 文献引用（蓝色上标）
```latex
...,\cite{keyA}           % 单条
...,\,\cite{keyA,keyB}    % 多条合并（逗号也上标）
```
> 逗号通常放在 `\cite` 前；需要更细空隙可用 `\,`。

### 图/表/节
```latex
\figref{fig:pipeline}            % Fig. X（蓝色可点击）
\figref{fig:pipeline}\subref{fig:pipeline-b}  % Fig. X(b)
\tabref{tab:ablation}            % Table Y
\secref{sec-intro}               % Section 1
```

### 公式
```latex
Eq.~\eqref{eq:loss}   % “Eq. (1)”
% 或用便捷宏
\eqnref{eq:loss}
```

---

## 🖼 Figures & Subfigures（单栏 1×N 横排）

**单图：**
```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=\linewidth]{figures/pipeline.pdf}
  \caption{Overall pipeline.}
  \label{fig:pipeline}
\end{figure}
```

**1×4 或 1×6：**
```latex
\begin{figure}[t]
  \centering
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/a.jpg}\caption{}\label{fig:a}
  \end{subfigure}\hfill
  % repeat 6× (use 0.155–0.16\textwidth each)
  \caption{One-line 1×6 gallery.}
  \label{fig:six-wide}
\end{figure}
```
- 不要同时给 `width=` 和 `height=`；若统一高度，用 `height=..,keepaspectratio`，去掉 `width=`。
- 调试期可用 `\documentclass[draft]{es-template}`（只占位）。

---

## 🧮 Equations

- 已启用 `amsmath`，直接使用 `\eqref`；可选 `\eqnref` 输出 “Eq. (n)”
- 想让数学外观更像 Times，可在 `cls` 中启用（可选）：
  ```latex
  \RequirePackage{unicode-math}
  \setmathfont{TeX Gyre Termes Math} % or XITS Math
  ```
- 示例：
  ```latex
  \begin{equation}
    \rho_{\text{oil}}=\frac{m_{2}-m_{0}}{m_{1}-m_{0}}\,\rho_{\text{water}}
    \label{eq:density}
  \end{equation}
  ... using \eqnref{eq:density}.
  ```

---

## 📚 Bibliography (biblatex + biber)

- 选项：`style=numeric`, `sorting=none`, `maxnames=minnames=99`
- 期刊名：蓝色斜体；文章标题：黑色无引号；DOI 前缀 `doi:`
- **多文献并列**的**逗号也上标**（模板已修正 `\multicitedelim`）

> **首次编译慢/卡？**  
> 使用 Overleaf 的 **Recompile from scratch** 清理 `.aux/.bbl/.bcf`，再编两遍。

---

## 🅰️ Built-in handy macros

- `\figref{...}`, `\tabref{...}`, `\secref{...}`, `\eqnref{...}`
- `\etal` → *et al.*（智能句点与空格）  
  `\eg`  → *e.g.*（同上）
- `\corr`（通讯作者*号）、`\email{...}`（等宽体邮件）

---

## ⚠️ Common pitfalls & how to avoid

1. **引擎错误**：本模板仅支持 **XeLaTeX/LuaLaTeX**。  
2. **重复加载 `hyperref`**：模板已在末尾加载；请勿在 `main.tex` 再 `\usepackage{hyperref}`。  
3. **在标题/图注中使用 `\cite`**：这些位置会写入目录/书签，建议避免；若必须，使用 `\protect\cite{...}`。  
4. **字体卡顿**：建议把 Times/Calibri 放在 `fonts/` 目录（模板会优先加载本地字体）。  
5. **多文献拼写错误**：`\label{tab:synthetic_data}` ≠ `\tabref{tab:synthethic_data}`（拼写必须**完全一致**；编两遍）。  
6. **1×N 子图溢出**：每块宽度 0.155–0.16`\textwidth` + `\hfill`，不要兼设 `width` 与 `height`。

---

## 📄 License

建议开源协议（如 MIT）：
```
MIT License — Copyright (c) 2025 <Your Name>
```

---

## 🙋 FAQ

**Q: 我想要用 `\cref{fig:...}` 可以吗？**  
A: 模板未内置 `cleveref`。若你偏好 `\cref`，在 `main.tex` 加：
```latex
\usepackage[nameinlink]{cleveref}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Table}{Tables}
\crefname{section}{Section}{Sections}
```

**Q: 连续引用时 `[3],[4]` 的逗号会不会掉到基线？**  
A: 不会。模板已将**分隔符也置于上标**，`\,\cite{a,b,c}` → `[3], [4], [5]`（全为上标蓝色）。

**Q: 句末的句号会不会被带到上标？**  
A: 不会。我们采用“**逐条上标 + 分隔符上标**”的实现，不会把后续标点一起上标。