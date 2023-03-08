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
