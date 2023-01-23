%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% This is file `olli-handout.cls'
%%
%% CC0 Oliver Schneider (assarbad.net), 2015, 2020, 2023
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{olli-handout}[2023/01/23 LaTeX handout class]

\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{landscape}{\OptionNotUsed}
\DeclareOption{twoside}{\OptionNotUsed}
\DeclareOption{draft}{\OptionNotUsed}
\DeclareOption{notitlepage}{\OptionNotUsed}
\DeclareOption{openright}{\OptionNotUsed}
\DeclareOption{leqno}{\OptionNotUsed}
\DeclareOption{fleqn}{\OptionNotUsed}
\DeclareOption{openbib}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%% PROCESS OPTIONS
\ProcessOptions

% Base class from which we derive and required packages
\LoadClass[a4paper,fontsize=12pt,twoside=false,onecolumn,final,openany,parskip=full-,chapterprefix=false]{scrreprt}
\RequirePackage{fontspec}
\RequirePackage{microtype}
\RequirePackage{fontawesome5}
\RequirePackage[english]{babel}
\RequirePackage[yyyymmdd]{datetime}
\RequirePackage[os=win]{menukeys}
\RequirePackage{bbding} % for symbols
\RequirePackage{textcomp} % for even more symbols
\RequirePackage{listings}
\RequirePackage{tabularx}
\RequirePackage[automark]{scrlayer-scrpage}
\RequirePackage[
    unicode,
    bookmarksnumbered=false,
    breaklinks=false,
    colorlinks=true,
    linkcolor={red!40!black},
    citecolor={blue!40!black},
    urlcolor={blue!60!black},
    pdfpagelayout=OneColumn,
    pdfstartview=FitH
]{hyperref}
\RequirePackage{fancyvrb}
\RequirePackage{varioref}
\RequirePackage{ascii}
\RequirePackage{graphicx}
\RequirePackage{luatex85} %% required for attachfile below
\RequirePackage{attachfile}
\RequirePackage{tcolorbox}
\RequirePackage{xifthen}
\RequirePackage{scrhack}

%\geometry{a4paper,portrait,margin=18mm,top=24mm,bottom=24mm}

\attachfilesetup{color={0 0 0}}

% Better tilde symbol
\newcommand{\mytilde}{{\small\ensuremath{\sim}}}

% Define own framed list style for Bash listings
\lstnewenvironment{lstbash}[1][false] % set argument to true in order to enable adjustments for use inside of framed environments
{
%\noindent\minipage{\linewidth}
\lstset{
    belowskip=-.5\baselineskip, % adjust the vertical spacing below
    frame=single,
    breaklines=true, % allows to break lines
    breakatwhitespace=true,
    postbreak=\raisebox{0ex}[0ex][0ex]{\ensuremath{\hookrightarrow\space}}, % puts a hooked arrow behind broken lines
    numbers=left,
    stepnumber=1,
    numberstyle=\tiny,
    showstringspaces=false,
    showlines=true,
    emptylines=*2,
    xleftmargin=.7ex,
    xrightmargin=.7ex,
    language=bash,
    keywordstyle=\color{blue},
    basicstyle=\ttfamily,
    morecomment=[l]{\#},
    morekeywords={user@host},
    alsoletter={~\$},
    morekeywords=[2]{user@host:},
    keywordstyle=[2]{\color{red}},
    literate={\$}{{\textcolor{red}{\$}}}1
    {:}{{\textcolor{red}{:}}}1
    {~}{{\textcolor{red}{\mytilde}}}1
    {`}{\textasciigrave}1,
}
\ifthenelse{\equal{#1}{true}}{
\lstset{
    belowskip=.5ex, % adjust the vertical spacing below
    xleftmargin=1em,
}
}{
\lstset{
    belowskip=-.5\baselineskip, % adjust the vertical spacing below
    xleftmargin=.7ex,
}
}
}
{
%\endminipage
}

% Uses fancyvrb
\DefineVerbatimEnvironment{GenericListing}{Verbatim}{numbers=none,numbersep=2pt,frame=single,framesep=.5ex,samepage=true}

% For menukeys
\renewmenumacro{\keys}[+]{roundedkeys} %% shadowedroundedkeys

% Make use of tcolorbox for stuff
\tcbuselibrary{hooks}
\newenvironment{refmanbash}{%%\tcbset{}
\begin{tcolorbox}[before nobreak=\parfillskip0pt,before app=\parfillskip0pt]
{\ArrowBoldDownRight} Bash \TT{man} page topic:
}{%
\end{tcolorbox}
}
\newenvironment{hintbox}{%
\begin{tcolorbox}[colback=white,colframe=black,boxrule=0.4pt,before nobreak=\parfillskip0pt,before app=\parfillskip0pt]
}{%
\end{tcolorbox}
}

% Colors for links
\newcommand{\linkclr}[1]{\textcolor[rgb]{0.00,0.00,0.70}{#1}}
\newcommand{\linktxtclr}[1]{\textcolor[rgb]{0.00,0.00,0.35}{#1}}

\newcommand{\olliWPLogo}{\faIcon{wikipedia-w}}
\newcommand{\olliTerminal}{\faIcon{terminal}}
\newcommand{\olliExternalLink}{\faIcon{external-link-alt}}
\newcommand{\olliEnvelope}{\faIcon[regular]{envelope}}
\newcommand{\olliHandLeft}{\faIcon[regular]{hand-point-right}}
\newcommand{\olliDownload}{\faIcon{download}} % \faIcon{file-download}
\newcommand{\olliLink}{\faIcon{link}}
\newcommand{\olliBook}{\faIcon{book}}
\newcommand{\olliPenRD}{\PencilRightDown}
\newcommand{\olliPenR}{\PencilRight}

% Own stuff
\newcommand{\term}{\textcolor[rgb]{0.00,0.50,0.00}{\olliTerminal}}
\newcommand{\termcmd}[1]{\mbox{{\term} ``\texttt{#1}''}}
\newcommand{\Arg}[1]{\mbox{``\texttt{#1}''}}
\newcommand{\TT}[1]{\mbox{\texttt{#1}}}
\newcommand{\TTQ}[1]{\mbox{``\texttt{#1}''}}
\newcommand{\namecmd}[1]{\mbox{\texttt{#1}}}
\newcommand{\fname}[1]{\mbox{\texttt{#1}}}
\newcommand{\dname}[1]{\mbox{\texttt{#1}}}

\title{\mytitle}
\author{\myself\\\myemail}

\newcommand*{\HREFpdfcreator}{LaTeX}
\newcommand*{\HREFpdftitle}{\mytitle}
\newcommand*{\HREFpdfauthor}{\myself (\myemail)}
\newcommand*{\HREFpdfkeywords}{}
\newcommand*{\HREFpdfsubject}{}

% Date format
\newdateformat{isodate}{\THEYEAR-\twodigit{\THEMONTH}-\twodigit{\THEDAY}}
\renewcommand{\dateseparator}{-}

\newcommand{\extlink}[2]{\href{#1}{\linktxtclr{#2}\,\linkclr{\small\olliExternalLink}}}
\newcommand{\wplink}[2]{\href{#1}{\linktxtclr{#2}\,\linkclr{\olliWPLogo}}}
\newcommand{\mailto}[1]{\href{mailto:#1@assarbad.net}{#1@assarbad.net\,\linkclr{\small\olliEnvelope}}}

\clearpairofpagestyles
\pagestyle{scrheadings}
\cfoot[\pagemark]{\pagemark}
\ohead[]{\small\textup{\textsf{\mytitle}}}
\ihead[]{\raisebox{1ex}{\faLinux}}

\setcounter{secnumdepth}{3}

\AtBeginDocument{%
  \setcounter{tocdepth}{3}
  \hypersetup{%
    pdftitle={\HREFpdftitle},
    pdfauthor={\HREFpdfauthor},
    pdfsubject={\HREFpdfsubject},
    pdfkeywords={\HREFpdfkeywords},
    pdfcreator={\HREFpdfcreator}
  }%
}
