% JETPL to article
%
% Simple class to use jetpl.cls commands and have figures inside text
%
% Options:
% * onlynames 		- will only put names of figures inside frames
% * smallerfigures 	- will make figures a bit smaller
% * colorrefs 		- will color missing cites and refs
% * colorcite 		- same
%
% Created by xtotdam
% Some parts were taken from original jetpl.cls - many kudos to its creators [http://jetpletters.ru/ru/info.shtml]

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jetpl2article}[2019/07/17 LaTeX class that converts JETP Letters' class to simple article]

\LoadClass[10pt]{article}

\RequirePackage{microtype}

\RequirePackage{cmap}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1,T2A]{fontenc}

\RequirePackage{commath}

\RequirePackage{xifthen}

\newboolean{colorreferrors}

\DeclareOption{onlynames}{
	\renewcommand{\insertfigure}[1]{\fbox{#1}}
}

\DeclareOption{colorcite}{
	\setboolean{colorreferrors}{true}
}

\DeclareOption{colorref}{
	\setboolean{colorreferrors}{true}
}

\DeclareOption{smallerfigures}{
	\renewcommand{\insertfigure}[1]{
		\fbox{\includegraphics[width=0.7\linewidth]{#1}}
	}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\RequirePackage[sort&compress,numbers,square]{natbib}
\RequirePackage[english,russian]{babel}

\bibliographystyle{jetpl}


\RequirePackage{amsmath}
\RequirePackage{geometry}

\geometry{%
	a4paper,
	twoside,
	left=2cm,
	right=1.5cm,
	top=1cm,
	bottom=2cm%
}

\RequirePackage{hyperref}

\RequirePackage{graphicx}
\newcommand{\insertfigure}[1]{\includegraphics[height=0.8\textheight,width=\linewidth,keepaspectratio]{#1}}

\RequirePackage{xcolor}
\DeclareRobustCommand{\red}[1]{\textcolor{red}{#1}}
\DeclareRobustCommand{\blue}[1]{\textcolor{blue}{#1}}
\DeclareRobustCommand{\green}[1]{\textcolor{green}{#1}}


% FROM jetpl.cls

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


\renewcommand\maketitle{\par
	\begingroup
		% \renewcommand\thefootnote{\@fnsymbol\c@footnote}%
        \def\@makefnmark{\rlap{\@textsuperscript{\normalfont\@thefnmark}}}%
        \long\def\@makefntext##1{\parindent 1em\noindent
            \hb@xt@1.8em{%
                \hss\@textsuperscript{\normalfont\@thefnmark}}##1}%
		\setcounter{footnote}{0}%
	    \if@twocolumn
		\twocolumn[\@maketitle]%
		\else
		\global\@topnum\z@
		\@maketitle%\@thanks
		\fi
		\thispagestyle{plain}\@thanks
		\setcounter{equation}{0}
	\endgroup
}

\def\@maketitle{%
	\vbox{\vspace*{-4mm}
	{\tiny Typeset with \href{https://github.com/xtotdam/jetpl2article}{JETPL2article}}
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

\ifthenelse{
	\boolean{colorreferrors}
}{
	\RequirePackage{soul}
	\RequirePackage{etoolbox}

	\newcommand{\missingref} {\sethlcolor{yellow}\color{black}\hl{Ref}}
	\newcommand{\missingcite}{\sethlcolor{orange}\color{black}\hl{Cite}}

	\makeatletter
	\patchcmd{\@setref}{\bfseries ??}{\missingref}{}{}

	\patchcmd{\NAT@citexnum}{\reset@font\bfseries?}{\missingcite}{}{}
	% \patchcmd{\NAT@citex}{\reset@font\bfseries ?}{\missingcite}{}{}
	% \patchcmd{\@citex}{\bfseries ?}{\missingcite}{}{}
	\makeatother
}{
	\relax
}



