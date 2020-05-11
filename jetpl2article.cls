% JETPL to article
%
% Simple class to use jetpl.cls commands and have figures inside text
%
% Options:
% * onlynames 		- will only put names of figures inside frames
% * smallerfigures 	- will make figures a bit smaller
% * colormissing 	- will make missing \cite and \ref colourful using fixme package
%
% Created by xtotdam

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jetpl2article}[2019/07/17 LaTeX class that converts JETP Letters' class to simple article]

\LoadClass[a4paper]{article}

\RequirePackage{cmap}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1,T2A]{fontenc}

\RequirePackage[sort&compress,square]{natbib}
\bibliographystyle{jetpl}

\RequirePackage[russian]{babel}

\RequirePackage{geometry}
\RequirePackage{amsmath}

\RequirePackage{hyperref}

\geometry{left=2cm}
\geometry{right=1.5cm}
\geometry{top=1cm}
\geometry{bottom=2cm}

\RequirePackage{graphicx}

\newcommand{\insertfigure}[1]{\includegraphics[height=0.8\textheight,width=0.9\linewidth,keepaspectratio]{#1}}

\RequirePackage{xifthen}

\newboolean{colormissing}
\setboolean{colormissing}{false}

\DeclareOption{onlynames}{
	\renewcommand{\insertfigure}[1]{\fbox{#1}}
}
\DeclareOption{smallerfigures}{
	\renewcommand{\insertfigure}[1]{
		\fbox{\includegraphics[width=0.7\linewidth]{#1}}
	}
}
\DeclareOption{colormissing}{
	\setboolean{colormissing}{true}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\newcommand{\rus}{}

\def\rtitle#1{}
\def\sodtitle#1{}
\def\rauthor#1{}
\def\sodauthor#1{}

\newcommand\@address{}
\newcommand\@authoraddress{}

\renewcommand{\author}[1]{%
	\expandafter\def\expandafter\@authoraddress\expandafter
	{\@authoraddress%
		{\dimen0=-\prevdepth\advance\dimen0 by8mm%
			\nointerlineskip\centering%
			\vrule height\dimen0 width0pt depth3mm\relax\ignorespaces{%
				\slshape#1}\unskip\par
		}%
	}%
}

\def\address#1{\expandafter\def\expandafter\@authoraddress\expandafter
	{\@authoraddress{\footnotesize\sl\centering\ignorespaces#1\unskip\par}}}

\newcommand\@dates{}
\newcommand{\dates}[2]{\gdef\@dates{{\footnotesize\centering #1}\par
}}

\newcommand\@abstract{}
\renewcommand{\abstract}[1]{\gdef\@abstract{\parbox{155mm}{%
			\hspace*{5.5mm}\small\ignorespaces#1}}%
}

\def\@maketitle{%
	\vbox{\vspace*{-4mm}
	{\tiny Assembled using \href{https://github.com/xtotdam/jetpl2article}{JETPL2article}}
	\vspace*{1cm}
		\begin{center}
			{\Large\rmfamily\bfseries\upshape\@title\par\vspace*{-4mm}}%
			\vskip12pt plus.1fil minus6pt%
			\@authoraddress\par
			\vspace*{-3mm}
			\vskip6pt plus.1fil minus3pt%
			\vspace*{3mm}%
			\@dates\par
			\vskip2em plus.1fil minus1ex%
			\@abstract%
			\vskip2em plus1em minus1ex%
			\par
		\end{center}
	}%
}

\renewcommand\maketitle{\par
	\setcounter{footnote}{0}%
    \if@twocolumn
	\twocolumn[\@maketitle]%
	\else
	\global\@topnum\z@
	\@maketitle%\@thanks
	\fi
	\setcounter{equation}{0}
}


\ifthenelse{\boolean{colormissing}}{
	
	% makes fixes colorful
	\RequirePackage{fixme}
	\RequirePackage{xcolor}
	\RequirePackage{soulutf8}
	\RequirePackage{etoolbox}
	
	\fxsetup{
		status=draft,
		author= ,
		layout=inline,nomargin,
		theme=color}
	\definecolor{fxnote}{rgb}{0,0,0}    % black
	\definecolor{fxwarning}{rgb}{0,0,0} % black
	\definecolor{fxerror}{rgb}{0,0,0}   % black
	\definecolor{fxfatal}{rgb}{0,0,0}   % black
	\colorlet{fxnotebg}{green!60}     % define the background colour:
	\colorlet{fxwarningbg}{yellow!60} % define the background colour:
	\colorlet{fxerrorbg}{red!60}      % define the background colour:
	\colorlet{fxfatalbg}{red!30}      % define the background colour:
	% redefine the layout macro:
	\makeatletter
	\renewcommand*\FXLayoutInline[3]{%
		\@fxdocolon {#3}{%
			\@fxuseface {inline}%
			\begingroup
			\sethlcolor{fx#1bg}%
			\color {fx#1}\ignorespaces \hl{#3\@fxcolon #2}%
			\endgroup}}
	
	\renewcommand*\FXLayoutContentsLine[3]{%
		\iffx@mode@multiuser%
		\fxaddcontentsline{\ignorespaces#3 \protect\sethlcolor{fx#1bg}\color{fx#1}\hl{\fxnotename{#1}: #2}}%
		\else%
		\fxaddcontentsline{\protect\sethlcolor{fx#1bg}\color{fx#1}\hl{\fxnotename{#1}: #2}}%
		\fi}
	\makeatother
	
	% emphasizes missing references and citations
	
	\makeatletter
	\patchcmd{\@setref}{\bfseries ??}{\fxerror{Ref}}{}{}
	\patchcmd{\@citex}{\bfseries ?}{\fxerror{Cite}}{}{}
	\makeatother

}{}
