\ProvidesClass{mcdowellcv}[2017/06/18 v1.2.0 McDowell CV class]

% Set up the fonts according to options
\def\mainfontsize{10pt}
\def\mainfontface{Times New Roman}

\DeclareOption{calibri}{%
  \def\mainfontface{Calibri}
}

\ProcessOptions\relax

% Set font size and paper type
\LoadClass[letterpaper,\mainfontsize]{article} 

% Set document margins
\usepackage[left=0.30in,top=15pt,right=0.50in,bottom=0.40in]{geometry} 

% Set font face
\usepackage{fontspec}
\setmainfont[SmallCapsFeatures={Renderer=Basic},
Ligatures={TeX, NoCommon, NoDiscretionary}]{\mainfontface}

% Remove paragraph indentation
\usepackage[parfill]{parskip} 

% Required for boldface (\bf and \bfseries) tabular columns
\usepackage{array} 

% Required for ifthenelse statements
\usepackage{etoolbox} 

% Suppress page numbers
\pagestyle{empty} 

% Flexible tables
\usepackage{tabu}

% For custom margins
\usepackage{changepage}

% To customize lists
\usepackage{enumitem}
% Remove left margin from lists, suppress vertical item separation and set top 
% separation to a negative value to suppress a single parskip before lists
\setlist{leftmargin=*, noitemsep, topsep=-1\parskip}

% For adjusting spacing based on the platform used
\usepackage{ifthen}
\usepackage{ifplatform}

% For spcaed small caps
\usepackage{microtype}

\DeclareMicrotypeSet*{smallcapsi} { 
	encoding = {OT1,T1,T2A,LY1,OT4,QX,T5,TS1,EU1,EU2},
	shape = {sc*,si,scit}
}

%--------------------------------------------------------------------------------
%                                    Constants                                  -
%--------------------------------------------------------------------------------

\ifthenelse{\equal{\platformname}{\notwindowsname}}{
	\def\namespaceskip{0.575em}
	\def\afterheaderspace{1.1pt}
	\def\beforesectionheaderspace{0pt}
	\def\sectionheadermargin{6pt}
	\def\beforesectionheaderhrulespace{2.85pt}
	\def\sectionheaderhrlueheight{0.518pt}
	\def\aftersectionheaderspace{-5.8pt}
	\def\aftersinglelinesubsectionheaderspace{-20.25pt}
	\def\afterdoublelinesubsectionheaderspace{-11.75pt}
	\def\aftermultilinesubsectionheaderspace{-7.75pt}
	\def\afteremptysubsectionheaderspace{1.25pt}
	\def\subsectionmargin{9pt}
	\def\aftersubsectionspace{2.1pt}
}{
	\def\namespaceskip{1em}
	\def\afterheaderspace{1pt}
	\def\beforesectionheaderspace{-5pt}
	\def\sectionheadermargin{250pt}
	\def\beforesectionheaderhrulespace{2pt}
	\def\sectionheaderhrlueheight{0.5pt}
	\def\aftersectionheaderspace{0.5pt}
	\def\aftersinglelinesubsectionheaderspace{-16.5pt}
	\def\afterdoublelinesubsectionheaderspace{-10pt}
	\def\aftermultilinesubsectionheaderspace{-4pt}
	\def\afteremptysubsectionheaderspace{1pt}
	\def\subsectionmargin{9pt}
	\def\aftersubsectionspace{1.5pt}
}

%--------------------------------------------------------------------------------
%                            Header Setup and Printing                          -
%--------------------------------------------------------------------------------

% Address line 1
\makeatletter

\newcommand\addrstreet[1]{\def\@addrstreet{#1}}
\addrstreet{}

\newcommand\printaddrstreet{
	\small{\@addrstreet}
}

\makeatother

% Address line 2
\makeatletter

\newcommand\addrcity[1]{\def\@addrcity{#1}}
\addrcity{}

\newcommand\printaddrcity{
	\small{\@addrcity}
}

\makeatother

% Linkedin and Github
\makeatletter

\newcommand\linkedinandgithub[1]{\def\@linkedinandgithub{#1}}
\linkedinandgithub{}

\newcommand\printlinkedinandgithub{
	\small{\@linkedinandgithub}
}

\makeatother

% Leetcode
\makeatletter

\newcommand\leetcode[1]{\def\@leetcode{#1}}
\leetcode{}

\newcommand\printleetcode{
	\small{\@leetcode}
}

\makeatother

% Name
\makeatletter

\newcommand\name[1]{\def\@name{#1}}
\name{}

\newcommand\printname{
	\typeout {kokoko}
	\typeout \spaceskip
	\spaceskip \namespaceskip \relax
	\textbf{\LARGE\textls[110]{\textsc{\@name}}}
}

\makeatother

% spaces
\makeatletter

\newcommand\spaces[1]{\def\@spaces{#1}}
\spaces{}

\newcommand\printspaces{
	{\@spaces}
}

\makeatother

% mail
\makeatletter

\newcommand\mail[1]{\def\@mail{#1}}
\mail{}

\newcommand\printmail{
	\small{\@mail}
}

\makeatother

% Contacts
\makeatletter

\newcommand\contacts[1]{\def\@contacts{#1}}
\contacts{}

\newcommand\printcontacts{
	\small{\@contacts}
}

\makeatother

\makeatletter
\newcommand\makeheader{
	\begin{center}
		\begin{tabu} to 1\textwidth { X[l,m] X[2,c,m] X[r,m] }
		    \printaddrstreet & \printname & \printcontacts \\
		    \printaddrcity & \printspaces & \printmail \\
		    \printspaces & \printlinkedinandgithub
		\end{tabu}	
	\end{center}
	\vspace*{\afterheaderspace}
}
\makeatother

%--------------------------------------------------------------------------------
%                            Sections and Subsections                           -
%--------------------------------------------------------------------------------

% Print a section header
\makeatletter
\newenvironment{cvsection}[1]{
	\vspace*{\beforesectionheaderspace}
	% Set text margins to equal \tabcolsep (6pt by default)
	\begin{adjustwidth}{\sectionheadermargin}{\sectionheadermargin}
		\textsc{\textbf{#1}}
	\end{adjustwidth}
	\vspace*{\beforesectionheaderhrulespace}
	\hrule height \sectionheaderhrlueheight
	\vspace*{\aftersectionheaderspace}
}{}
\makeatother

% Print a subsection
\makeatletter
% Define toggles checking if titles were defined
\newtoggle{lefttitledefined}
\newtoggle{centertitledefined}
\newtoggle{righttitledefined}

\newenvironment{cvsubsection}[4][1]{
	\notblank{#2}{\toggletrue{lefttitledefined}}{}
	\notblank{#3}{\toggletrue{centertitledefined}}{}
	\notblank{#4}{\toggletrue{righttitledefined}}{}
	\ifboolexpr{togl {lefttitledefined} and togl {centertitledefined} and togl {righttitledefined}}{
		\begin{tabu} to 1\textwidth { X[l,p] X[c,p] X[r,p] }
			\textbf{#2} & \textbf{#3} & \textbf{#4} \\
		\end{tabu}
		% Add space according to the specified number of lines
		\ifnumcomp{#1}{=}{1}{\vspace*{\aftersinglelinesubsectionheaderspace}}{
			\ifnumcomp{#1}{=}{2}{\vspace*{\afterdoublelinesubsectionheaderspace}}{
				\vspace*{\aftermultilinesubsectionheaderspace}
			}
		}
	}{
	    \ifboolexpr{togl {lefttitledefined} and togl {righttitledefined}}{
    		\begin{tabu} to 1\textwidth { X[l,p] X[r,p] }
    			\textbf{#2} & \textbf{#4} \\
    		\end{tabu}
    		% Add space according to the specified number of lines
    		\ifnumcomp{#1}{=}{1}{\vspace*{\aftersinglelinesubsectionheaderspace}}{
    			\ifnumcomp{#1}{=}{2}{\vspace*{\afterdoublelinesubsectionheaderspace}}{
    				\vspace*{\aftermultilinesubsectionheaderspace}
    			}
    		}
    	}
	}{
		\vspace*{\afteremptysubsectionheaderspace}
	}
	\togglefalse{lefttitledefined}
	\togglefalse{centertitledefined}
	\togglefalse{righttitledefined}
	\begin{adjustwidth}{\subsectionmargin}{\subsectionmargin}
}
{
	\end{adjustwidth}
	\vspace*{\aftersubsectionspace}
}
\makeatother