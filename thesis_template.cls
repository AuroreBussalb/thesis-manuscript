
%########################################################################
% Options
%########################################################################
\RequirePackage{ifthen}
\RequirePackage{keyval}
\LoadClass[a4paper,twoside,12pt]{book}
\usepackage[plainpages=false,pdfpagelabels,colorlinks=true]{hyperref}
\hypersetup{
    citecolor=blue,%
    filecolor=blue,%
    linkcolor=blue,%
    urlcolor=blue
}
\def\@thesis@language{french}
\def\@thesis@babel@language{french}
\def\@thesis@select@language{%
  \expandafter\expandafter\expandafter\selectlanguage\expandafter\expandafter\expandafter{\@thesis@babel@language}%
}

\define@key{thesis_template}{mainlanguage}{%
  \gdef\@thesis@language{#1}%
  \ifthenelse{\equal{#1}{french}}{%
    \gdef\@thesis@babel@language{francais}%
  }{%
    \gdef\@thesis@babel@language{#1}%
  }%
}

\def\@thesis@languages{english,francais}
\define@key{thesis_template}{morelanguage}{%
  \edef\@thesis@languages{#1,\@thesis@languages}%
}

\newif\if@thesis@parttoc
\@thesis@parttocfalse
\define@key{thesis_template}{parttoc}[]{\@thesis@parttoctrue}

\newif\if@thesis@logos
\@thesis@logosfalse
\define@key{thesis_template}{logos}[]{\@thesis@logostrue}

\newif\if@thesis@lists
\@thesis@listsfalse
\define@key{thesis_template}{lists}[]{\@thesis@liststrue}

\let\@keyval@options@list\@empty
\def\@extract@key#1=#2\@extract@key{#1}

\def\ProcessKeyvalOptions#1{%
  \let\@tempa\@empty
  \let\@tempb\@empty
  \@for\CurrentOption:=\@keyval@options@list\do{%
    \expandafter\expandafter\expandafter\def\expandafter\expandafter\expandafter\@key\expandafter\expandafter\expandafter{%
      \expandafter\@extract@key\CurrentOption=\@extract@key%
    }%
    \@ifundefined{KV@#1@\@key}{\edef\@tempa{\@tempa,\CurrentOption,}}{\edef\@tempb{\@tempb,\CurrentOption,}}
  }%
  \@for\CurrentOption:=\@tempa\do{%
    \ifx\CurrentOption\@empty%
    \else%
      \PassOptionsToClass{\CurrentOption}{book}%
    \fi%
  }%
  \edef\@tempb{%
    \noexpand\setkeys{#1}{\@tempb}%
  }%
  \@tempb%
  \AtEndOfPackage{%
    \let\@unprocessedoptions\relax%
  }%
}

\DeclareOption*{%
  \expandafter\expandafter\expandafter\def\expandafter\expandafter\expandafter\@keyval@options@list\expandafter\expandafter\expandafter{%
    \expandafter\@keyval@options@list\expandafter,\CurrentOption%
  }%
}

\ProcessOptions\relax
\ProcessKeyvalOptions{thesis_template}%

%########################################################################
% Base class and packages
%########################################################################

\usepackage{caption}
\captionsetup{{labelsep=endash}}


% Write accents directly in source code
\usepackage[utf8]{inputenc} 
\usepackage[T1]{fontenc}
%\usepackage[french]{babel}

% Insert blank pages
\usepackage{afterpage}

\newcommand\blankpage{%
    \null
    \thispagestyle{empty}%
    \addtocounter{page}{-1}%
    \newpage}
		
% Quotes 
\usepackage[square]{natbib}
\bibliographystyle{abbrvnat}

% Font Helvetica
\renewcommand{\familydefault}{\sfdefault}
\def\helvetica{\fontfamily{phv}\selectfont}
\def\helveticaitalic{\fontfamily{phv}\itshape\selectfont}
\def\helveticabold{\fontfamily{phv}\bfseries\selectfont}
\def\helveticabolditalic{\fontfamily{phv}\bfseries\itshape\selectfont}
\usepackage[usenames,dvipsnames]{xcolor}

% Line spacing
\setlength{\baselineskip}{0.5mm}
\setlength{\parskip}{2mm}

% For pictures in the pdf
\usepackage{graphicx}

% For tables
\usepackage{multirow}
\usepackage{booktabs}
\usepackage{threeparttable}

% landscape page
\usepackage{lscape}

% for argmin and argmax
\usepackage{amsmath}
\DeclareMathOperator*{\argmin}{argmin}

% Captions
\usepackage{booktabs,caption}

% Color
\usepackage{xcolor}


% for abs values
\usepackage{commath}

% For hyperlinks in the pdf 
%\usepackage{hyperref} 

% For ref with figure, table or equation before the number
\usepackage{cleveref}

% for figures in table of figures
\graphicspath{ {figures/} }

%Language
\RequirePackage[\@thesis@languages,\@thesis@babel@language]{babel}
\RequirePackage{textcomp}
\RequirePackage[autolanguage]{numprint}

%Page setup

\RequirePackage[hmargin={2.5cm,2.5cm},vmargin={2.5cm,2.5cm}]{geometry}
\RequirePackage{fancyhdr}
\RequirePackage{lastpage}
\RequirePackage[avantgarde]{quotchap}
%\usepackage[nottoc,numbib]{tocbibind}
\usepackage[nottoc]{tocbibind}

%Part table of contents
\def\@finalize@parttoc{%
  \if@thesis@doneparttoc%
  \else%
    \doparttoc%
    \faketableofcontents%
  \fi%
}
\if@thesis@parttoc%
  \AtEndDocument{\@finalize@parttoc}
  \RequirePackage{minitoc}

  \renewcommand\ptctitle{\summaryname}
%  \mtcsetdepth{parttoc}{3}
  \setcounter{tocdepth}{2}
  \newif\if@thesis@doneparttoc
  \@thesis@doneparttocfalse
  \let\@old@tableofcontents=\tableofcontents
  \def\tableofcontents{%
    \@thesis@doneparttoctrue%
    \doparttoc%
    \@old@tableofcontents%
  }
\fi

%Logos
\if@thesis@logos
\usepackage{graphicx}
\RequirePackage{ifpdf}
\fi

%Math
\RequirePackage{amsmath,amssymb,amsfonts}

%Misc
\RequirePackage{tabularx}


%########################################################################
% Lists and parts setup
%########################################################################

\newlength\defparindent
\newlength\defitemsep
\newlength\itemizesep
\newlength\itemizeparskip

\setlength\defparindent{20pt}
\setlength\parskip{0.5\baselineskip}
\setlength\itemizesep{0.3333\baselineskip}
\setlength\defitemsep\itemizesep
\setlength\itemizeparskip{0.25\baselineskip}

% Glossaries
\usepackage[toc, acronym, shortcuts]{glossaries}
\usepackage{glossary-mcols}
\usepackage{etoolbox}

\AtBeginDocument{%
\renewcommand{\labelitemi}{$\bullet$}%
\renewcommand{\labelitemii}{$\cdot$}%
\renewcommand{\labelitemiii}{-}%
\renewcommand{\chaptermark}[1]{\markboth{\chaptername\ \thechapter.\ #1}{}}%
\renewcommand{\contentsname}{Table des mati\`{e}res}%
\renewcommand*{\glspostdescription}{}%
\renewcommand{\glsnamefont}[1]{\textmd{#1 :}}%
\titleformat{\chapter}[display] {\fontsize{17pt}{12pt}\selectfont \bfseries}{\chaptertitlename\ \thechapter}{20pt}{\Huge}%
\titleformat*{\section}{\Large\bfseries\sffamily}%
\titleformat*{\subsection}{\large\bfseries\sffamily}%
\titleformat*{\subsubsection}{\large\bfseries\sffamily}%
\titleformat{\paragraph}[display] {\bfseries}{\theparagraph}{10pt}{\normalsize}%
\titlespacing*{\paragraph}{\parindent}{2em}{1em}%
\titlespacing*{\subsubsection}{0em}{2em}{1em}%
\titlespacing*{\subsection}{0em}{2.25em}{1.5em}%
\titlespacing*{\section}{0em}{2.5em}{1.75em}%
}

% separation entre figure et texte
\setlength{\intextsep}{1cm}
\setlength{\textfloatsep}{1cm}

%\setcounter{secnumdepth}{3} % subsubsection numbered


%\titleformat*{\section}{\Large\bfseries\sffamily}
%\titleformat*{\subsection}{\large\bfseries\sffamily}
%\titleformat*{\subsubsection}{\itshape}

%\titleformat{\chapter}
  %{\Large\bfseries} % format
  %{}                % label
  %{0pt}             % sep
  %{\huge}         

%\AtBeginDocument{%
  %\if@test@lists%
    %\setlength\parindent\defparindent%
    %\let\olditemize=\itemize%
    %\renewenvironment{itemize}{%
      %\olditemize%
      %\addvspace{\itemizesep}%
      %\setlength\itemindent{9pt}%
      %\setlength\itemsep\defitemsep%
      %\addtolength\itemsep{-\itemizeparskip}%
      %\setlength\parskip\itemizeparskip%
      %\setlength\parindent\defparindent%
    %}{%
      %\endlist%
      %\addvspace{\itemizesep}%
    %}%
    %\let\oldenumerate=\enumerate%
    %\renewenvironment{enumerate}{%
      %\olditemize%
      %\addvspace{\itemizesep}%
      %\setlength\itemindent{8pt}%
      %\setlength\itemsep\defitemsep%
      %\addtolength\itemsep{-\itemizeparskip}%
      %\setlength\parskip\itemizeparskip%
      %\setlength\parindent\defparindent%
    %}{%
      %\endlist%
      %\addvspace{\itemizesep}%
    %}%
		%%\renewcommand{\labelitemi}{$\bullet$}%
    %%\renewcommand{\labelitemii}{$\cdot$}%
    %%\renewcommand\labelitemiii{-}%
  %\fi%
  %\let\@test@old@part=\@part%
  %\let\@test@old@endpart=\@endpart
  %\def\@endpart{}
  %\let\beforeparttoc\empty
%%\if@test@parttoc\vfill\doparttoc\fi%
     %\def\@part[#1]#2{%
     %\@test@old@part[#1]{#2}%
     %\if@test@parttoc\parttoc\fi%
  %%   \@test@old@endpart%
   %}%
  %%\if@test@parttoc\vfill\parttoc\fi%
  %\renewcommand\sectionmark[1]{\markright{#1}\gdef\@test@current@section{#1}}%
  %\renewcommand\subsectionmark[1]{\markboth{\thesubsection\ -\ \emph{#1}}{\@test@current@section}}%
%}

%########################################################################
% Page setup
%########################################################################

\tolerance=10000
\hbadness=10000


\usepackage{fancyhdr}

%% first reset the headers and footers
\fancyhead{}
\fancyfoot{}
%% make the odd pages have the section name on the top right
%\fancyhead[RO]{\sffamily\bfseries \rightmark}
\fancyhead[RO]{\sffamily \leftmark}
%\fancyhead[RO]{\sffamily \chaptername\hspace{1cm} \thechapter}
%% make the even pages have the chapter name on the top left
%\fancyhead[LE]{\sffamily\bfseries \leftmark}
\fancyhead[LE]{Aurore Bussalb - Th\`{e}se de doctorat - 2020}

%% page nums on the bottom in a nice box
%% even side pages
%\fancyfoot[LE]{\psboxit{box 0.8 setgray fill}
%{\framebox[10mm][c]{\rule{0cm}{4mm}\color{black}{\bfseries \thepage}}}}
%% odd side pages
%\fancyfoot[RO]{\psboxit{box 1 setgray fill}
%{\hspace{\textwidth}\psboxit{box 0.8 setgray fill}
%{\framebox[10mm][c]{\rule{0cm}{4mm}\color{black}{\bfseries \thepage}}}}}

%% page nums on the bottom without box
%% even side pages
\fancyfoot[LE]{\thepage}
%% odd side pages
\fancyfoot[RO]{\thepage}


%% make the bottom line above the page number box
%\renewcommand{\footrulewidth}{0.4pt}
%\renewcommand{\footruleskip}{0mm}
%% now redefine the plain style pages (chapter pages, contents pages)
%% to have the same page number stuff on the bottom
\fancypagestyle{plain}{
\fancyhf{}
%\fancyfoot[RO]{\psboxit{box 1 setgray fill}
%{\hspace{\textwidth}\psboxit{box 0.8 setgray fill}
%{\framebox[10mm][c]{\rule{0cm}{4mm}\color{black}{\bfseries \thepage}}}}}
\fancyfoot[RO]{\thepage}
%\renewcommand{\headrulewidth}{0pt}
%\renewcommand{\footrulewidth}{0.5pt}
}


\fancypagestyle{style2}{
\fancyhf{}
\fancyhead[LE]{Aurore Bussalb - Th\`{e}se de doctorat - 2020}
\fancyhead[RO]{Table des mati\`{e}res}
\fancyfoot[RO]{\thepage}
\renewcommand{\headrulewidth}{0.5pt}
}

\fancypagestyle{style3}{
\fancyhf{}
\fancyhead[LE]{Aurore Bussalb - Th\`{e}se de doctorat - 2020}
\fancyhead[RO]{Table des figures}
\fancyfoot[RO]{\thepage}
\renewcommand{\headrulewidth}{0.5pt}
}

\fancypagestyle{style4}{
\fancyhf{}
\fancyhead[LE]{Aurore Bussalb - Th\`{e}se de doctorat - 2020}
\fancyhead[RO]{Bibliographie}
\renewcommand{\headrulewidth}{0.5pt}
}

\fancypagestyle{style5}{
\fancyhead[LE]{}
\fancyhead[RO]{}
\renewcommand{\headrulewidth}{0pt}
\fancyfoot[RO]{\thepage}
\fancyfoot[LE]{\thepage}
}

\usepackage[calcwidth]{titlesec}
%% bring the style into effect
%% (must come after all the fancyhead and fancyfoot stuff)


\pagestyle{fancy}

% Redefine the plain page style
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[RO]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}% Line at the header invisible
  \renewcommand{\footrulewidth}{0pt}% Line at the footer invisible
}



%########################################################################
% Multilingual abstracts
%########################################################################

%\def\keywordsname{Keywords}
%\def\summaryname{Summary}
%
%\addto\captionsfrench{%
  %\renewcommand\keywordsname{Mots-clefs}%
  %\renewcommand\summaryname{Sommaire}%
%}
%
%\addto\captionsenglish{%
  %\renewcommand\keywordsname{Keywords}%
  %\renewcommand\summaryname{Summary}%
%}
%
%\addto\captionsgerman{%
  %\renewcommand\keywordsname{Schlagworte}%
  %\renewcommand\summaryname{Inhaltsverzeichnis}%
%}
%
%\addto\captionsitalian{%
  %\renewcommand\keywordsname{Keywords}%
  %\renewcommand\summaryname{Indice}%
%}
%
%\newenvironment{abstract}[1][\@thesis@language]{%
  %\edef\@test@current@abstract@language{#1}%
  %\expandafter\expandafter\expandafter\selectlanguage\expandafter\expandafter\expandafter{#1}%
  %\small%
  %\setlength\parskip{0pt}%
  %\parindent=\defparindent%
  %\begin{center}%
    %\ifthenelse{\equal{#1}{\@test@language}}{}{%
      %\textsc{%
        %\normalsize%
        %\@ifundefined{@title@#1}{%
          %\ClassError{test-thesis}{No title given for language "#1"}{Title for language "#1" is mandatory for this class. You should provide one using the title command.}%
        %}{%
          %\csname @title@#1\endcsname%
          %\nopagebreak[4]%
          %\\[1ex]%
        %}%
      %}%
    %}%
    %{\bfseries\abstractname}%
  %\end{center}%
  %\unskip%
  %\medskip%
  %\nopagebreak[4]%
  %\par%
%}{%
  %\nopagebreak[4]%
  %\\[\smallskipamount]%
  %\nopagebreak[4]%
  %\textbf{\uppercase{\keywordsname}} : %
  %\@ifundefined{@keywords@\@test@current@abstract@language}{%
    %\ClassError{test-thesis}{No keywords given for language "\@test@current@abstract@language"}{Keywords for language "\@test@current@abstract@language" are mandatory for this class. You should provide them using the keywords command.}%
  %}{%
    %\csname @keywords@\@test@current@abstract@language\endcsname.%
  %}%
  %\par%
  %\@test@select@language%
%}
%########################################################################
% Initialization
%########################################################################

\def\@title@french{???\ClassError{test-thesis}{No French title given}{French title is mandatory for this class. You should provide one using the \protect\title command.}}
\def\@title@english{???\ClassError{test-thesis}{No English thesis title given}{English title is mandatory for this class. You should provide one using the \protect\title command.}}
\def\@keywords@french{???\ClassError{test-thesis}{No French keywords given}{English keywords are mandatory for this class. You should provide them using the \protect\keywords command.}}
\def\@keywords@english{???\ClassError{test-thesis}{No English keywords given}{English keywords are mandatory for this class. You should provide them using the \protect\keywords command.}}
\def\@author{???\ClassError{test-thesis}{No author given}{The author is mandatory for this class. You should provide one using the \protect\author command.}}
\def\@specialty{???\ClassError{test-thesis}{No specialty is given}{The specialty is mandatory for this class. You should provide one using the \protect\specialty command.}}
\def\@affila{???\ClassError{test-thesis}{No affiliation is given}{The affiliation is mandatory for this class. You should provide one using the \protect\affil command.}}
%\def\@affiladd{???\ClassError{test-thesis}{No affiliation is given}{The affiliation is mandatory for this class. You should provide one using the \protect\affildd command.}}
\def\@date{??/??/??\ClassError{test-thesis}{No defense date given}{The defense date is mandatory for this class. You should provide one using the \protect\date command.}}
\def\@ordernumber{\ClassWarning{test-thesis}{No order number given}{The order number was not specified. You should provide one using the \protect\order command.}}
%%%%
%% this next section (till \makeatother) makes sure that blank pages
%% are actually completely blank, cause they're not usually
\makeatletter
\def\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
	\hbox{}
	\vspace*{\fill}
	\thispagestyle{empty}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}
\makeatother
