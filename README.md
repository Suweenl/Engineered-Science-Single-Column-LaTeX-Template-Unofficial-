# Engineered Science 单栏 LaTeX 模板（非官方）

> 一个仿制 *Engineered Science* 期刊作者模板版式的非官方 LaTeX 类，复现其单栏页面几何、蓝色上标数字引用以及图表标题样式。本项目与该期刊无隶属或背书关系，仅供研究与教学用途。

> **免责声明**：本仓库仅在外观和排版风格上对 *Engineered Science* 期刊模板进行复现，**并非官方模板**。投稿前请务必以期刊最新作者指南为准。

## ✨ 主要特性

- **单栏**版式，自定义纸张尺寸 **22.2 cm × 28.5 cm**
- **蓝色上标**数字引用（`[n]`）；**多条引用**时逗号同样为上标显示
- `Fig.` / `Table` 标签**蓝色加粗**
- 内置便捷交叉引用宏：`\\figref`、`\\tabref`、`\\secref`、`\\eqnref`
- `biblatex + biber`：数值型样式、作者不省略；期刊名为**蓝色斜体**
- 常用缩写宏：`\\etal`、`\\eg`（带智能点号/空格）

---

## 🔧 快速开始


### 最小 `main.tex`
```latex
\documentclass{es-template} % 或 [draft]

\title{Your Title}
\authors{Author A, Author B}
\affils{Affiliation line 1; Affiliation line 2}
\date{\today}

\begin{document}
\maketitle

\begin{abstract}
在此填写摘要。
\end{abstract}

\section{Introduction}\label{sec-intro}
Underwater landmarks,\cite{keyA,keyB} 见 \figref{fig:six-wide}，以及公式 Eq.~\eqref{eq:density}。
消融实验见 \tabref{tab:ablation}。

\begin{figure}[t]
  \centering
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/a.jpg}\caption{}\label{fig:a}
  \end{subfigure}\hfill
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/b.jpg}\caption{}\label{fig:b}
  \end{subfigure}\hfill
  % ... 最多 6 个子图 ...
  \caption{单行 1×N 图集示例。}\label{fig:six-wide}
\end{figure}

\begin{equation}
  \rho_{\text{oil}}=\frac{m_{2}-m_{0}}{m_{1}-m_{0}}\,\rho_{\text{water}}
  \label{eq:density}
\end{equation}

\printbibliography
\end{document}
```

### 编译
- **引擎：** XeLaTeX 或 LuaLaTeX（类文件会强制检查）
- **参考文献：** 使用 `biber`（不是 `bibtex`）
- **Overleaf：** Menu → Compiler: XeLaTeX；Biber 自动运行

---

## 🆚 与原生 `article` 的差异

- 页面尺寸与边距匹配期刊 Word 模板
- `\cite{...}` 输出为**蓝色上标** `[n]`；**多条**时逗号同为上标
- 参考文献中期刊名为**蓝色斜体**；文章标题为黑色、无引号
- 节标题字号为 `10.5pt`（Times）；`Fig.`/`Table` 标签为蓝色加粗且冒号分隔
- 内置工具宏：`\figref`、`\tabref`、`\secref`、`\eqnref`、`\etal`、`\eg`
- `subcaption` 与单栏 **1×N** 图集为首选用法

---

## 🔗 交叉引用（本模板风格）

### 文献引用
```latex
...,\cite{keyA}           % 单条
...,\,\cite{keyA,keyB}    % 多条（逗号同为上标）
```
- 标点通常写在 `\cite` 之前；需要更细空隙可用 `\,`。

### 图/表/节
```latex
\figref{fig:pipeline}                         % Fig. X（蓝色可点击）
\figref{fig:pipeline}\subref{fig:pipeline-b}  % Fig. X(b)
\tabref{tab:ablation}                         % Table Y
\secref{sec-intro}                            % Section 1
```

### 公式
```latex
Eq.~\eqref{eq:loss}   % “Eq. (1)”
% 或使用便捷宏
\eqnref{eq:loss}
```

---

## 🖼 图与子图（单栏 1×N）

**单图**
```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=\linewidth]{figures/pipeline.pdf}
  \caption{总体流程。}
  \label{fig:pipeline}
\end{figure}
```

**1×4 或 1×6 图集**
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
- 避免同时设置 `width=` 与 `height=`；如需统一高度，使用 `height=..,keepaspectratio` 并省略 `width=`。
- 调试阶段可用 `\documentclass[draft]{es-template}` 显示占位框。

---

## 🧮 公式

- 已启用 `amsmath`，可直接使用 `\eqref`；便捷宏 `\eqnref` 输出 “Eq. (n)”。  
- 若需更接近 Times 的数学外观，可在类文件中启用：
  ```latex
  \RequirePackage{unicode-math}
  \setmathfont{TeX Gyre Termes Math} % 或 XITS Math
  ```
- 示例：
  ```latex
  \begin{equation}
    \rho_{\text{oil}}=\frac{m_{2}-m_{0}}{m_{1}-m_{0}}\,\rho_{\text{water}}
    \label{eq:density}
  \end{equation}
  ... 参见 \eqnref{eq:density}。
  ```

---

## 📚 参考文献（biblatex + biber）

- 选项：`style=numeric`，`sorting=none`，`maxnames=minnames=99`
- 期刊名：**蓝色斜体**；文章标题：黑色无引号
- **多文献并列**时，**分隔逗号为上标**（模板已调整分隔符）

> 若编译卡顿或引用异常，建议 Overleaf 使用 **Recompile from scratch** 清理缓存文件，然后再连续编译两遍。

---

## 🅰️ 内置宏

- 交叉引用：`\figref{...}`、`\tabref{...}`、`\secref{...}`、`\eqnref{...}`
- 缩写：`\etal` → *et al.*；`\eg` → *e.g.*（均带智能点号与空格）
- 其他：`\corr`（通讯作者 * 号）、`\email{...}`（等宽体邮件地址）

---

## 🙋 常见问答

**可以使用 `\cref{fig:...}` 吗？**  
类文件未内置 `cleveref`。如果你偏好 `\cref`，请在 `main.tex` 添加：
```latex
\usepackage[nameinlink]{cleveref}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Table}{Tables}
\crefname{section}{Section}{Sections}
```


**句末的句号会一起变成上标吗？**  
不会。我们仅对每一条引用块和分隔符进行上标处理，后续标点保持基线。
