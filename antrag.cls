%%
%% IDENTIFICATION
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{lp-antrag}[2020-10-15 Klasse zur Setzung von Aenderungsantraegen]

%%
%% OPTIONS
%%

\RequirePackage{kvoptions}      % Allows Key-Value Options

\SetupKeyvalOptions{
    family=LP,
    prefix=LP@
}

% use option pair draft/final
\DeclareBoolOption{draft}
\DeclareComplementaryOption{final}{draft}

\DeclareStringOption[10pt]{vindent}

\DeclareBoolOption{multilineSections}
\DeclareStringOption[Artikel]{multilineSectionPrefix}

\DeclareStringOption[12]{DIV}
\DeclareStringOption[half]{parskip}
\DeclareStringOption[11pt]{fontsize}

% pass all other options to the document class
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{scrartcl}}

% process all options
\ProcessKeyvalOptions*

\PassOptionsToClass{DIV=\LP@DIV}{scrartcl}
\PassOptionsToClass{parskip=\LP@parskip}{scrartcl}
\PassOptionsToClass{fontsize=\LP@fontsize}{scrartcl}

%%
%% LOADING PACKAGES
%%

% load the class "scrartcl" from the KoMa-Script bundle
\LoadClass[%
    a4paper
    ]{scrartcl}
% Set additional options of the KOMA-Script class.
% "parskip=half" sets inter-paragraph spacing to half a line (without indentation).
% "DIV=n" divides the page into n stripes (horizontally and vertically).


%\RequirePackage[T1]{fontenc}    % Font-Encoding
\RequirePackage{lmodern}        % LModern font
\RequirePackage{amsmath}        % Standard Mathebefehle
\RequirePackage[ngerman]{babel} % deutsche Lokalisierung
\RequirePackage{graphicx}       % Einbindung von Bildern
\RequirePackage{microtype}      % improved micro-typography: character protrusion and font expansion are enabled by default.

\RequirePackage{multicol}       % erlaubt das "Verbinden" von Zellen einer Tabelle über meherere Spalten
\RequirePackage{multirow}       % erlaubt das "Verbinden" von Zellen einer Tabelle über meherere Zeilen
\RequirePackage{booktabs}       % erlaubt das Setzen von ansprechenderen Tabellen
\RequirePackage{tabularx}       % bessere Tabellen-Umgebung - genutzt für das Unterschriftenfeld

\RequirePackage{lineno}         % Nummerierung der Zeilen
\RequirePackage{csquotes}       % bessere Anführungszeichen
\RequirePackage{eurosym}        % Euro-Zeichen setzen
% \RequirePackage[normalem]{ulem} % Durchstreichen von Text-Passagen
\RequirePackage{soul}
\RequirePackage{soulutf8}
\RequirePackage[%               % Text-Färbung:
    dvipsnames%                 %     Gibt mehr Farben einen Namen
]{xcolor}
\RequirePackage[%               % bessere Aufzählungen
    shortlabels%                %     erlaubt Kurzschreibweise der Labels an Aufzählungen
]{enumitem}
%\RequirePackage[%               % Setzen von Einheiten
%    binary-units=true%          %     fügt Binäreinheiten hinzu
%]{siunitx}
\RequirePackage{pdfpages}       % erlaubt das Einbinden von Seiten anderer PDF-Dateien

\RequirePackage{blindtext}         % erlaubt Blindtext

\PassOptionsToPackage{hyphens}{url}
% Pass option "hyphens" to the package url which is loaded internally in hyperref to allow url breaking after a hyphen.

\RequirePackage[%
%    pdfauthor={Liste Poppelsdorf},
%	pdftitle={}
]{hyperref}                    % Verlinkung (sowohl im Dokument als auch Hyperlinks)

\ifLP@draft
    % Entwurfs-Wasserzeichen
    \RequirePackage{draftwatermark}
    \SetWatermarkText{Entwurf}

    % Use draft mode of KoMa class
    \KOMAoptions{draft}
\fi

% Hier eingebunden, da die KOMAoption "draft" überschrieben werden muss
\RequirePackage[%               % Kopf- und Fußzeilen.
    draft=false%                % Verhindert das Anzeigen von "Entwurfs-Informationen"
]{scrlayer-scrpage}


%%
%% LAYOUT OPTIONS
%%

\hypersetup{%
	colorlinks=true,%
	linkcolor=orange,%
	citecolor=olive,%
	urlcolor=cyan%
}
% Configure further options of the "hyperref" package: colored links.

% Use larger sections
\RedeclareSectionCommand[
	font=\LARGE
]{section}


% use this style for the header and footer
\pagestyle{scrheadings}

\setlist[enumerate, 1]{
	label = \arabic*.
}

\setlist[itemize, 1]{
  nosep,
  label = »
}
\setlist[itemize, 2]{
  nosep,
  label = ›
}
% Global configuration for itemize environments.
% The symbol is » for the first level and › for the second level.

\setlist[description, 2]{
  font = {\normalfont\itshape},
  leftmargin = *
}
% Global configuration for nested description environments.


\newlist{legalenum}{enumerate}{5}
\setlist[legalenum, 1]{
  label = {(\arabic*)}
}
\setlist[legalenum, 2]{
  label= {\arabic*.}
}
\setlist[legalenum, 3]{
  label= {\alph*.}
}

%%
%% FONT
%%

% use French spacing
\bbl@frenchspacing

\RequirePackage{unicode-math}

\setmainfont[
    Ligatures=TeX,
%    Numbers=OldStyle,
    Contextuals=Alternate
]{Libertinus Serif}

\setsansfont[
    Ligatures=TeX,
%    Numbers=OldStyle,
    Contextuals=Alternate
]{Libertinus Sans}

\setmonofont[Scale=MatchLowercase]{Inconsolatazi4}

\setmathfont{Libertinus Math}

\newfontfamily\verbatimfamily%
%{Inconsolatazi4}[Scale=MatchLowercase]
{Libertinus Sans}[
    Ligatures=TeX,
    Contextuals=Alternate
]

%%
%% CUSTOM MACROS
%%

\renewcommand*\url[1]{\href{https://#1}{\nolinkurl{#1}}}
% The original command does not work when #1 does not begin with "www".

\newcommand*\mail[1]{\href{mailto:#1}{\nolinkurl{#1}}}


%%
%% NEW COMMANDS
%%

%Einrückung der Satzungstexte
\newlength{\vindent}
\setlength{\vindent}{\LP@vindent}

% Use this layout for changes passages
\newcommand\markchange[1]{%
    \uline{#1}%
}

% If not in draft mode: use this layout for new passages
\newcommand\marknew[1]{%
% no highlighting
    #1%
}

\ifLP@draft
    % in case of draft mode: use this layout for new passages instead
    \renewcommand\marknew[1]{%
        \textcolor{red}{#1}
    }
\fi

% Verbatim text - used to display e.g. legal text
\newenvironment{vtext}{
	\verbatimfamily\itshape
	\begin{addmargin}[\vindent]{0pt}
}{
	\end{addmargin}
}

% Layout der Überschrift eines Paragraphen
\newcommand\parheading[1]{
    {\large\textbf{#1}}
}

% Verbatim Paragraphen
\newenvironment{vpar}[1]{
    \begin{vtext}
    \parheading{\S~#1}\par
}{
    \end{vtext}
}

% Verbatim Aufzählung -> nutzt die LegalEnum
\newenvironment{venum}[1]{
    \begin{vtext}
    \begin{legalenum}[start=#1]
}{
    \end{legalenum}
    \end{vtext}
}

% Sections:

% Wir geben im Titel keinen Autor an.
% Allerdings geht die Klasse scrartcl zwingend von einem Autor aus und fügt
% unnötigen whitespace ein, auch wenn das Autorfeld leer angegeben wird.
% Daher wird hier der Befehl \@maketitle umdefiniert:
% Es wird die bisherige Implementation des Befehls reinkopiert,
% mit der Änderung, dass das Autorfeld ignoriert wird, wenn es leer ist,
% und dann kein überzähliger Whitespace eingefügt wird.
\def\@maketitle{%
  \global \@topnum =\z@ \setparsizes {\z@ }{\z@ }{\z@ \@plus 1fil}\par@updaterelative
  \ifx \@titlehead \@empty
  \else \begin {minipage}[t]{\textwidth } \usekomafont {titlehead}{\@titlehead \par }\end {minipage}\par
  \fi
  \null
  \vskip 2em
  \begin {center}
    \ifx \@subject \@empty
    \else {\usekomafont {subject}{\@subject \par}}\vskip 1.5em
    \fi
    {\usekomafont {title}{\huge \@title \par }}%
    \vskip .5em {
      \ifx \@subtitle \@empty
      \else \usekomafont {subtitle}\@subtitle \par 
      \fi }%
% The following part is changed. The code inside the \else is the code that was used before.
% --------------------------------
    \ifx \@author \@empty
    \else
      \vskip 1em {
        \usekomafont {author}{
          \lineskip .5em%
          \begin {tabular}[t]{c}
            \@author
          \end {tabular}\par }}%
    \fi%
% --------------------------------
    \vskip 1em{%
      \usekomafont {date}{\@date \par }}%
    \vskip \z@ \@plus 1em {\usekomafont {publishers}{\@publishers \par }}%
    \ifx \@dedication \@empty
    \else \vskip 2em {\usekomafont {dedication}{\@dedication \par }}
    \fi
  \end {center}\par \vskip 2em%
}

\newcommand\sectionCenter{%
    \addtokomafont{section}{\centering}
}
\newcommand\sectionLeft{%
    \addtokomafont{section}{\raggedright}
}
\newcommand\sectionRight{%
    \addtokomafont{section}{\raggedleft}
}

\ifLP@multilineSections
	\sectionCenter
    \renewcommand\sectionformat{\LP@multilineSectionPrefix~\thesection}
    \renewcommand\sectionlinesformat[4]{%
       \@hangfrom{\hskip #2#3}\\{#4}%
    }
\fi

\newcommand\signature[2]{
	\begin{tabularx}{\linewidth}{X}
		#1\\
		\scriptsize #2
	\end{tabularx}{\parfillskip=0pt\par}\par
}	%hack to fix overfull hboxes
