---
title: "APA With R Markdown"
date: 2023-02-11T04:29:20-07:00
draft: false
---
Disclaimer: I am no R expert. I am only documenting what has worked for me.

I set up Markdown with [Papaja](https://github.com/crsh/papaja) to make writing APA-formatted documents.

# Setup
You'll need R.

`sudo pacman -S r`

Next get a LaTeX distribution. The author of Papaja recommends `tinytex`. It automatically downloads packages as you need them. Enter into an interactive R session with `R`. Note: if you run as sudo any packages you install will be available for all users. However, I had issues with this route.
[[]]
```
# install tinytex
install.packages('tinytex')
tinytex::install_tinytex()
```
For papaya:
```
# Install remotes package if necessary
if(!requireNamespace("remotes", quietly = TRUE)) install.packages("remotes")
# Install the latest development snapshot from GitHub
remotes::install_github("crsh/papaja@devel")
```

# Usage
You can use R studio to generate a template document or do it over the command line.

I would disable line numbers and make links blue (or whichever color you like).
## APA 7
Papaya uses APA 6th edition out of the box. If you want the 7th edition there is a change you can make documented in a [Github issue](https://github.com/crsh/papaja/issues/342).


```
header-includes:
  - |
    \makeatletter
    \renewcommand{\paragraph}{\@startsection{paragraph}{4}{\parindent}%
      {0\baselineskip \@plus 0.2ex \@minus 0.2ex}%
      {-1em}%
      {\normalfont\normalsize\bfseries\typesectitle}}
    
    \renewcommand{\subparagraph}[1]{\@startsection{subparagraph}{5}{1em}%
      {0\baselineskip \@plus 0.2ex \@minus 0.2ex}%
      {-\z@\relax}%
      {\normalfont\normalsize\bfseries\itshape\hspace{\parindent}{#1}\textit{\addperi}}{\relax}}
    \makeatother

csl               : "`r system.file('rmd', 'apa7.csl', package = 'papaja')`"
documentclass     : "apa7"
output            : papaja::apa6_pdf

```
Not pretty but it gets the job done.


My template document looks like this:
```
will copy paste later
```

# Limitations
This package works best for academic writing - not for college or high school students submitting assignments. The `apa7` document type does support a "stu"dent mode that enables the student manuscript type. If you change "man" to "stu" and render the document you'll find some new fields in your cover page. At the time of this writing there doesn't seem to be a way to fill these in. If your professor is picky about this stuff then you might want to find another solution (such as writing directly in latex with the apa7 latex package).

Questions? Comments? Hate mail? Send them in [mailto:max@lysle.org](max@lysle.org).
