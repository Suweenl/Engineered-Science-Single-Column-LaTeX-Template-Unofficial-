\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{es-template}[2025/11/12 Engineered Science-like single-column article template (optimized)]
\RequirePackage{ragged2e}

% -------------------------
% Class options
% -------------------------
\newif\ifes@draft
\DeclareOption{draft}{\es@drafttrue}
\DeclareOption{final}{\es@draftfalse}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% -------------------------
% Base class
% -------------------------
\LoadClass[12pt,a4paper]{article}

% -------------------------
% Engine check
% -------------------------
\RequirePackage{iftex}
\ifPDFTeX
  \ClassError{es-template}{This class requires XeLaTeX or LuaLaTeX (fontspec).}{Please compile with XeLaTeX or LuaLaTeX.}
\fi

% -------------------------
% Fonts & fontspec
% -------------------------
\RequirePackage{fontspec}
\defaultfontfeatures{Ligatures=TeX}

% --- 主字体 Times New Roman：优先绑定工程本地文件以避免 Overleaf 系统查找卡顿 ---
%   支持两种常见命名：
%   1) fonts/times.ttf, timesbd.ttf, timesi.ttf, timesbi.ttf
%   2) fonts/Times New Roman.ttf, Times New Roman Bold.ttf, Times New Roman Italic.ttf, Times New Roman Bold Italic.ttf
\newcommand*\es@fontpath{fonts/}
\newif\if@tnrA \newif\if@tnrB
\IfFileExists{\es@fontpath times.ttf}{\@tnrAtrue}{\@tnrAfalse}
\IfFileExists{\es@fontpath Times New Roman.ttf}{\@tnrBtrue}{\@tnrBfalse}

\if@tnrA
  \setmainfont{Times New Roman}[
    Path=\es@fontpath, Extension=.ttf,
    UprightFont=times, BoldFont=timesbd, ItalicFont=timesi, BoldItalicFont=timesbi
  ]
\else\if@tnrB
  \setmainfont{Times New Roman}[
    Path=\es@fontpath,
    UprightFont={Times New Roman.ttf},
    BoldFont={Times New Roman Bold.ttf},
    ItalicFont={Times New Roman Italic.ttf},
    BoldItalicFont={Times New Roman Bold Italic.ttf}
  ]
\else
  % 回退到系统查找（仍为 Times New Roman，外观不变；仅首次可能慢）
  \setmainfont{Times New Roman}
\fi\fi

% --- Calibri 用作标题、作者等（保持原设定，绑定本地文件，若无则回退） ---
\newif\if@calA \newif\if@calB
\IfFileExists{\es@fontpath calibri.ttf}{\@calAtrue}{\@calAfalse}
\IfFileExists{CALIBRI.ttf}{\@calBtrue}{\@calBfalse}

\if@calA
  \newfontfamily\calibrifont{Calibri}[
    Path=\es@fontpath, Extension=.ttf,
    UprightFont=calibri, BoldFont=calibrib, ItalicFont=calibrii, BoldItalicFont=calibriz
  ]
\else\if@calB
  \newfontfamily\calibrifont{CALIBRI}[
    Path=./,
    UprightFont=CALIBRI.ttf, BoldFont=CALIBRIB.ttf, ItalicFont=CALIBRII.ttf
    % 如有 BoldItalic 可在此补充
  ]
\else
  \newfontfamily\calibrifont{Calibri} % 回退
\fi\fi

% 等宽字体（与外观无关，保持即可）
\setmonofont{Latin Modern Mono}

% -------------------------
% Page geometry（保持你的数值）
% -------------------------
\RequirePackage[
  paperwidth=22.2cm,
  paperheight=28.5cm,
  top=1.85cm,
  bottom=1.7cm,
  left=1.8cm,
  right=1.8cm
]{geometry}

% -------------------------
% Microtypography & spacing
% -------------------------
\IfFileExists{microtype.sty}{%
  \RequirePackage{microtype}
  \microtypecontext{spacing=nonfrench}
}{}
\RequirePackage{setspace}
\setstretch{1.0}

% -------------------------
% Utilities
% -------------------------
\RequirePackage{xcolor}
\RequirePackage{enumitem}
\setlist{nosep}
\ifes@draft
  \PassOptionsToPackage{draft}{graphicx}
\fi
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{multirow}
\RequirePackage{array}
\IfFileExists{siunitx.sty}{%
  \RequirePackage{siunitx}
  % 原为 detect-all（较慢且全局），多数情况下等价外观可由以下实现；
  % 如你必须保持 detect-all，请在 main.tex 中局部开启。
  \sisetup{detect-weight=true, detect-inline-weight=math}
}{}

% --- Equations ---
\RequirePackage{amsmath}
% 如需章节级编号可放开： (1.1), (1.2) ...
% \numberwithin{equation}{section}

% -------------------------
% 图表标题样式设置
% -------------------------
\RequirePackage{subcaption}
\RequirePackage{caption}

% 正文引用蓝色
\newcommand{\figref}[1]{\hyperref[#1]{\textcolor{blue}{Fig.~\ref{#1}}}}
\newcommand{\tabref}[1]{\hyperref[#1]{\textcolor{blue}{Table~\ref{#1}}}}

\AtBeginDocument{%
    \DeclareCaptionFont{bluebf}{\color[HTML]{0000FF}\bfseries\rmfamily}  % 蓝色加粗新罗马
    \DeclareCaptionFont{blackrm}{\rmfamily}  % 黑色新罗马
    \captionsetup[figure]{labelfont={bluebf}, textfont={blackrm}, labelsep=colon, name=Fig.}
    \captionsetup[table]{labelfont={bluebf}, textfont={blackrm}, labelsep=colon, name=Table}
}

% -------------------------
% Headers/footers, titles
% -------------------------
\RequirePackage{fancyhdr}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
% \fancyfoot[C]{\thepage} % 如需页码可放开

\RequirePackage{titlesec}
% Section titles in Times New Roman
\titleformat{\section}{\bfseries\fontsize{10.5}{10.5}\selectfont}{\thesection.}{0.25em}{}
\titleformat{\subsection}{\bfseries\fontsize{10.5}{10.5}\selectfont}{\thesubsection}{0.25em}{}
\titleformat{\subsubsection}{\bfseries\fontsize{10.5}{10.5}\selectfont}{\thesubsubsection}{0.25em}{}
\titlespacing*{\section}{0pt}{\baselineskip}{0pt}
\titlespacing*{\subsection}{0pt}{\baselineskip}{0pt}
\titlespacing*{\subsubsection}{0pt}{\baselineskip}{0pt}

% -------------------------
% Title / Author / Affiliation
% -------------------------
\newcommand{\es@title}{}
\newcommand{\es@authors}{}
\newcommand{\es@affils}{}
\newcommand{\es@date}{}

\renewcommand{\title}[1]{\gdef\es@title{#1}}
\newcommand{\authors}[1]{\gdef\es@authors{#1}}
\newcommand{\affils}[1]{\gdef\es@affils{#1}}
\renewcommand{\date}[1]{\gdef\es@date{#1}}

\renewcommand\maketitle{%
  \begingroup
    \parindent=0pt
    \vspace*{-1em}%
    % 标题 — Calibri 加粗 20pt（保持不变）
    {\calibrifont\fontsize{20pt}{25pt}\bfseries\selectfont \es@title \par}%
    \vspace{1em}%
    % 作者 — Times New Roman 10pt
    {\fontsize{10pt}{10pt}\selectfont \es@authors \par}%
    \vspace{1em}%
    % 机构 — Times New Roman 9pt Italic（你的原设为 10.5pt 注释中有出入，这里保留 9pt）
    {\fontsize{9pt}{9pt}\itshape\selectfont \es@affils \par}%
    \vspace{1em}%
    % 日期 — Times New Roman 10pt
    {\fontsize{10pt}{12pt}\selectfont \es@date \par}%
  \endgroup
}

% -------------------------
% Abstract
% -------------------------
\RequirePackage{abstract}
\renewcommand{\abstractnamefont}{\calibrifont\bfseries\fontsize{12pt}{12pt}\selectfont}
\renewcommand{\abstracttextfont}{\calibrifont\fontsize{10.5pt}{12pt}\selectfont}
\renewcommand{\absnamepos}{flushleft}
\renewenvironment{abstract}{
  {\abstractnamefont \noindent \abstractname\par\vspace{-0.4em}}
  \noindent\rule{\linewidth}{0.2pt}
  \noindent
  \abstracttextfont
  \justifying
}{%
  \par\vspace{1em}
}

% -------------------------
% Keywords
% -------------------------
\newenvironment{keywords}{%
  \noindent
  {\rmfamily\itshape\fontsize{10.5pt}{10pt}\selectfont Keywords}
  {\rmfamily\fontsize{10pt}{10pt}\selectfont:\hspace{0.25em}}
  \rmfamily\fontsize{10pt}{10pt}\selectfont
  \ignorespaces
}{%
  \par\vspace{1em}
}

% -------------------------
% Table of Contents Module
% -------------------------
\newenvironment{tocmodule}[2][]{%
  \noindent{\calibrifont\bfseries\fontsize{12pt}{12.5pt}\selectfont Table of Contents\par}%
  \ifx&#1&\else
    \noindent\makebox[0pt][l]{\includegraphics[width=0.3\linewidth]{#1}}%
  \fi
  \par\vspace{1em}
  \noindent{\rmfamily\itshape\fontsize{10.5pt}{10.5pt}\selectfont Innovative Description: }%
  {\rmfamily\fontsize{10.5pt}{10.5pt}\selectfont #2\par}%
  \noindent\textcolor[HTML]{412F85}{\rule{\linewidth}{2pt}}%
}{}

% -------------------------
% Bibliography（保持你的 biblatex 设定）
% -------------------------
\RequirePackage[
  backend=biber,
  style=numeric,
  sorting=none,
  maxnames=99,
  minnames=99
]{biblatex}
\addbibresource{references.bib}
\setlength{\biblabelsep}{0.25em}

% 上标蓝色引用（保持）
% \DeclareCiteCommand{\supercite}
%   {\usebibmacro{prenote}}
%   {\textsuperscript{\textcolor[HTML]{0000FF}{[\usebibmacro{cite}]}} }
%   {\multicitedelim}
%   {\usebibmacro{postnote}}
% \let\cite\supercite

\DeclareCiteCommand{\supercite}
  {\usebibmacro{prenote}}
  {\textsuperscript{\textcolor[HTML]{0000FF}{[\usebibmacro{cite}]}}}
  {\textsuperscript{\textcolor[HTML]{0000FF}{,\space}}} % ← 分隔符也上标、蓝色
  {\usebibmacro{postnote}}
\let\cite\supercite



% 期刊蓝色斜体等（保持）
\DeclareFieldFormat[article]{journaltitle}{\textcolor[HTML]{0000FF}{\textit{#1}}}
\DeclareFieldFormat[article]{title}{#1}
\DeclareFieldFormat[book]{title}{#1}
\DeclareFieldFormat{doi}{doi: \nolinkurl{#1}}
\DeclareFieldFormat{pages}{#1}
\DeclareNameAlias{sortname}{last-first}

\DeclareBibliographyDriver{article}{%
  \printnames{author},\space
  \printfield{title},\space
  \printfield[journaltitle]{journaltitle},\space
  \printfield{year},\space
  \iffieldundef{volume}{}{\textbf{\printfield{volume}}},\space
  \printfield{pages}%
  \iffieldundef{doi}{}{\addcomma\space \printfield{doi}}%
  \finentry
}
\DeclareBibliographyDriver{book}{%
  \printnames{author},\space
  \printfield{title},\space
  \printlist{publisher},\space
  \printfield{year},\space
  \printfield{volume}%
  \finentry
}
\AtBeginBibliography{\justifying}

% -------------------------
% Floats & paragraphs
% -------------------------
\setlength{\intextsep}{10pt plus 2pt minus 2pt}
\setlength{\textfloatsep}{12pt plus 2pt minus 2pt}
\setlength{\parindent}{1.5em}
\setlength{\parskip}{0pt}
\AtBeginDocument{\justifying}

% -------------------------
% Hyperref（最后加载，防止重复与选项冲突；保持蓝色链接）
% -------------------------
\PassOptionsToPackage{hyphens}{url}
\RequirePackage[colorlinks=true, linkcolor=blue, citecolor=blue, urlcolor=blue, unicode, psdextra]{hyperref}

% -------------------------
% Helper macros
% -------------------------
\newcommand{\corr}{\textsuperscript{*}}
\newcommand{\email}[1]{\texttt{#1}}

% Abbrev macros: \etal, \eg （统一句点与空格）
\RequirePackage{xspace}
\makeatletter
\DeclareRobustCommand{\onedot}{\futurelet\@let@token\@onedot}
\def\@onedot{\ifx\@let@token.\else.\null\fi\xspace}
\makeatother

\DeclareRobustCommand{\etal}{\emph{et~al}\onedot} % → “et al.”
\DeclareRobustCommand{\eg}{\emph{e.g}\onedot}     % → “e.g.”

% --- Equation reference helpers & spacing ---
\newcommand{\eqnref}[1]{Eq.~\eqref{#1}} % 可用 Eq.~(1)
\AtBeginDocument{
  \setlength{\abovedisplayskip}{6pt plus 2pt minus 2pt}
  \setlength{\belowdisplayskip}{6pt plus 2pt minus 2pt}
}

\endinput
