---
title: "Tidying up Hugo HTML output"
date: 2024-10-11T23:33:03-06:00
tags: ['hugo', 'math']
---
If you've ever peaked inside a website built with Hugo (or another static site framework) using "View Page Source" (shortcut: `CTRL-U`) then you may have noticed lots of whitespace in seemingly odd places, and inconsistent formatting to boot. What exactly is going on, and is there anything that can be done about it?

## How things got so bad
The whitespace is an unfortunate consequence of Hugo's otherwise excellent templating system. Consider the following snippet commonly used to enable math rendering in Hugo. (Side note: If you're actually trying to set that up, read up on the [official documentation](https://gohugo.io/content-management/mathematics/).)

```go-html-template
<head>
    {{ if .Param "math" }}
      {{ partialCached "math.html" . }}
    {{ end }}
</head>
```

All that whitespace surrounding the template code is going to appear in the final HTML. Not seeing it? Here it is again with the relevant whitespace shown explicitly.

```go-html-template
<head>$
····{{ if .Param "math" }}$
······{{ partialCached "math.html" . }}$
····{{ end }}$
</head>
```
Even if the condition is false, Hugo will still preserve the whitespace preceeding {{< h go-html-template >}}{{ if .Param "math" }}{{< /h >}} and following {{< h go-html-template >}}{{ end }}{{< /h >}}.

Fortunately, Hugo provides some tools to help control leftover whitespace in templates. If we add dashes to our template code, we can remove any preceeding and following whitespace from the final HTML.

```go-html-template
<head>
    {{- if .Param "math" -}}
      {{- partialCached "math.html" . -}}
    {{- end -}}
</head>
```
But this alone will hardly produce pleasant-looking output. Consider what happens when the "math.html" template is inserted inside the {{< h html >}}<head>{{< /h >}} section. We will get inconsistent formatting because our elements are at the same level of indentation, and we are nesting one inside the other.

Unfortunately, Hugo does not have an auto-indent feature to correct for this. Perhaps we could indent "math.html" accordingly, but this basically defeats the point of using a template.

Clearly, we're going to need to try something else.

## A solution that isn't
Let's get something out of the way. If you run hugo with the {{< h sh >}}--minify{{< /h >}} option, it will strip out most whitespace. But that is taking things too far. We don't want to erase all structure from our code just to hide some imperfections here and there.

Unfortunately, Hugo does not come with a {{< h sh >}}--tidy{{< /h >}} option although it has been requested.[^1]

## Prettier to the rescue
A workaround[^2][^3] is to use an external formatter like [HTML Tidy](https://html-tidy.org) or [Prettier](https://prettier.io/) to automatically format our site after it is produced by Hugo. I went with Prettier because its what I already use inside my editor.

```sh
#!/bin/sh
hugo
npx prettier "./public/**/*.html" --parser html --write
```
[^1]: https://github.com/gohugoio/hugo/issues/7190
[^2]: https://blog.elnu.com/2022/01/cleaning-up-html-with-tidy/
[^3]: https://github.com/gohugoio/hugo/issues/7190#issuecomment-2001655381
