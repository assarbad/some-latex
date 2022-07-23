\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{rezepte}[2021/12/19 Class for my cooking and baking recipes]

\LoadClass[version=last]{scrartcl}
\RequirePackage{microtype}
\RequirePackage{luaotfload}
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\RequirePackage{etoolbox}

\providetoggle{fraktur}

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

\catcode`ſ=\active
\AtBeginDocument{%
\iftoggle{fraktur}%
{%
\setmainfont{UnifrakturMaguntia}[Ligatures={TeX,Historic}]
}%
{%
\setmainfont{TeX Gyre Bonum}[RawFeature={fallback=genericfallback}]
\catcode`ſ=\active%
\protected\defſ{s}%
}%
\setsansfont{TeX Gyre Heros}
\setmonofont{TeX Gyre Cursor}
\setkomafont{disposition}{\bfseries} % Hauptfont auch für Überschriften
\thispagestyle{empty}%
}%
\ResetLongSCatcode
