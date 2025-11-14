# Engineered Science Single-Column LaTeX Template (Unofficial)

> An unofficial LaTeX class that reproduces the single-column page geometry, blue superscript numeric citations, and caption styles of the *Engineered Science* journal’s author template. This project is not affiliated with or endorsed by the journal; it is a community recreation for research and educational use.

> **Disclaimer**: This repository targets the look-and-feel of the *Engineered Science* journal template, but it is **not** an official template. It is a community-built replica based on publicly observable formatting rules. Always verify with the journal’s latest author guidelines before submission.


## ✨ Key Features

- **Single-column** layout with custom page size **22.2 cm × 28.5 cm**
- **Blue superscript** numeric citations (`[n]`); in multi-citations the **comma is also superscripted**
- `Fig.` / `Table` labels in **blue bold**, caption body in black, Times-based text
- Built-in quick reference macros: `\figref`, `\tabref`, `\secref`, `\eqnref`
- `subcaption` enabled and tuned for **1×N horizontal galleries**
- `amsmath` enabled for equations; optional Times-style math via `unicode-math`
- `biblatex + biber`: numeric style, all authors printed; journal titles in **blue italics**
- Handy text macros: `\etal` and `\eg` with smart spacing
- Fonts are loaded from a local `fonts/` directory first (faster on Overleaf)

---

## 🔧 Quick Start

### Recommended structure
```
project/
├─ main.tex
├─ es-template.cls
├─ references.bib
├─ figures/
└─ fonts/                 # optional local Times/Calibri .ttf files
   ├─ times.ttf, timesbd.ttf, timesi.ttf, timesbi.ttf
   └─ calibri.ttf, calibrib.ttf, calibrii.ttf, calibriz.ttf
```

### Minimal `main.tex`
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

### Compile
- **Engine:** XeLaTeX or LuaLaTeX (enforced by the class)
- **Bibliography:** `biber` (not `bibtex`)
- **Overleaf:** Menu → Compiler: XeLaTeX; Biber runs automatically

---

## 🆚 Differences vs. stock `article`

- Custom page size and margins matching the journal’s Word layout
- `\cite{...}` renders **blue superscript** `[n]`; in multi-citations the **comma is also superscripted**
- Journal titles in the bibliography are **blue italics**; article titles are plain
- Section headings at `10.5pt` Times; `Fig.`/`Table` labels are blue bold with colon separators
- Helper macros: `\figref`, `\tabref`, `\secref`, `\eqnref`, `\etal`, `\eg`
- `subcaption` and single-column **1×N** galleries are first-class patterns

---

## 🔗 Cross-referencing (house style)

### Bibliography
```latex
...,\cite{keyA}           % single
...,\,\cite{keyA,keyB}    % multiple; comma is superscripted too
```
- Place punctuation **before** `\cite`. Use `\,` for a thin space if needed.

### Figures/Tables/Sections
```latex
\figref{fig:pipeline}                            % Fig. X (clickable, blue)
\figref{fig:pipeline}\subref{fig:pipeline-b}     % Fig. X(b)
\tabref{tab:ablation}                            % Table Y
\secref{sec-intro}                               % Section 1
```

### Equations
```latex
Eq.~\eqref{eq:loss}   % “Eq. (1)”
% or the convenience macro
\eqnref{eq:loss}
```

---

## 🖼 Figures & Subfigures (single-column 1×N)

**Single figure**
```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=\linewidth]{figures/pipeline.pdf}
  \caption{Overall pipeline.}
  \label{fig:pipeline}
\end{figure}
```

**1×4 or 1×6 gallery**
```latex
\begin{figure}[t]
  \centering
  \begin{subfigure}[t]{0.155\textwidth}\centering
    \includegraphics[width=\linewidth]{figures/a.jpg}\caption{}\label{fig:a}
  \end{subfigure}\hfill
  % repeat up to six blocks (0.155–0.16\textwidth each)
  \caption{One-line 1×6 gallery.}
  \label{fig:six-wide}
\end{figure}
```
- Avoid specifying both `width=` and `height=` simultaneously. If you need a unified height, use `height=..,keepaspectratio` and omit `width=`.
- For debugging, `\documentclass[draft]{es-template}` renders figure boxes without embedding images.

---

## 🧮 Equations

- `amsmath` is enabled, so `\eqref` is available out of the box; `\eqnref` prints “Eq. (n)”.  
- To make math look closer to Times, optionally enable in the class:
  ```latex
  \RequirePackage{unicode-math}
  \setmathfont{TeX Gyre Termes Math} % or XITS Math
  ```
- Example:
  ```latex
  \begin{equation}
    \rho_{\text{oil}}=\frac{m_{2}-m_{0}}{m_{1}-m_{0}}\,\rho_{\text{water}}
    \label{eq:density}
  \end{equation}
  ... using \eqnref{eq:density}.
  ```

---

## 📚 Bibliography (biblatex + biber)

- Options: `style=numeric`, `sorting=none`, `maxnames=minnames=99`
- Journal titles: **blue italics**; article titles: plain (no quotes)
- **Multi-citation comma** is superscripted (template adjusts the delimiter)

> If compilation stalls or references look wrong, try **Recompile from scratch** on Overleaf, then compile twice (aux/bbl/bcf refresh).


