\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rezepte}[2023/03/08 Class for my cooking and baking recipes]

\RequirePackage{kvoptions} %% also xkeyval or scrbase, see https://tex.stackexchange.com/q/38359
\DeclareBoolOption[false]{fraktur}
\ProcessKeyvalOptions*
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax
\LoadClass[version=last]{scrartcl}
\RequirePackage{microtype}
\RequirePackage{luaotfload}
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\RequirePackage{etoolbox}
\RequirePackage{newunicodechar}

%\catcode`ſ=\active % Make ſ active
%\newcommand ſ{s} % Now we can let it expand to s
%\let ſ\undefined
%\catcode`ſ=11 % Make ſ letter again

\ifdefined\directlua\else
	\errmessage{LuaTeX is required to typeset using this class}
	\csname @@end\expandafter\endcsname
\fi
\directlua
{
	fonts.handlers.otf.addfeature
	{
		name = "longssub",
		type = "substituation",
		data =
		{
			["ſ"] = {"s"}
		},
	}
}

\directlua{luaotfload.add_fallback("genericfallback", {"NotoSerif:mode=node;"})}

\edef\ResetLongSCatcode{%
  \catcode`ſ=\the\catcode`ſ\relax
}

\newfontfamily\symbolfont{Noto Serif Regular}[Scale=MatchUppercase]
\newcommand\libra{{\symbolfont\symbol{"2114}}}
\newunicodechar{^^^^2114}{\libra}

\catcode`ſ=\active
\AtBeginDocument{%

\ifrezepte@fraktur%

\setmainfont{UnifrakturMaguntia}[Ligatures={TeX,Historic}]
% StylisticSet=15 == Diaresis -> small e
% Ligatures=Historic/Rare/NoCommon
% Numbers=Uppercase/Monospaces
% CharacterVariant=19 wide emdash
%\setsansfont[ % spaced letters instead of bold text
%    BoldFont = UnifrakturMaguntia,
%    BoldFeatures = {LetterSpace=8.0, Ligatures=NoCommon, Kerning=Off}
%]{UnifrakturMaguntia}

\else%

\setmainfont{TeX Gyre Bonum}[RawFeature={fallback=genericfallback}]
\catcode`ſ=\active%
\protected\defſ{s}%

\fi%

\setsansfont{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}
\setkomafont{disposition}{\bfseries} % Hauptfont auch für Überschriften
\thispagestyle{empty}%
}%
\ResetLongSCatcode



%see either the mathspec package or the unicode-math package.
%
%\defaultfontfeatures{⟨font features⟩}
%\defaultfontfeatures[⟨font name⟩]{⟨font features⟩}
%
%To reset default font features, simply call the command with an empty argument:
%\defaultfontfeatures[\rmfamily,\sffamily]{}
%\setmainfont{texgyreadventor-regular.otf}% will no longer use standard TeX ligatures
%
%\addfontfeature{Numbers=OldStyle}...
%\addfontfeature{Numbers=Lining}...
%123
%
%BoldFeatures={⟨features⟩}
%ItalicFeatures={⟨features⟩}
%BoldItalicFeatures={⟨features⟩}
%SlantedFeatures={⟨features⟩}
%BoldSlantedFeatures={⟨features⟩}
%SwashFeatures={⟨features⟩}
%BoldSwashFeatures={⟨features⟩}
%SmallCapsFeatures={⟨features⟩}
%UprightFeatures={⟨features⟩}
%
%\defaultfontfeatures{ Scale = MatchLowercase }
%\defaultfontfeatures[\rmfamily]{ Scale = 1}
%
%\IfFontExistsTF{⟨font name⟩}{⟨true branch⟩}{⟨false branch⟩}
%
%\documentclass{article}
%\usepackage{fontspec}
%\directlua{
%fonts.handlers.otf.addfeature {
%name = "oneb",
%type = "substitution",
%data = {
%["1"] = "one.ss01",
%}
%}
%}
%\setmainfont{Vollkorn-Regular.otf}[RawFeature=+oneb]
%\begin{document}
%1234567890
%\end{document}