[![Actions Status](https://github.com/librasteve/Air-Plugin-Wordcloud/actions/workflows/test.yml/badge.svg)](https://github.com/librasteve/Air-Plugin-Wordcloud/actions)

# Air::Plugin::Wordcloud

A plugin for the Raku [Air](https://raku.land/zef:librasteve/Air) web framework that renders interactive word clouds using [wordcloud2.js](https://github.com/timdream/wordcloud2.js).

## Synopsis

```raku
#!/usr/bin/env raku

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Wordcloud;

my %words =
    Raku    => 10,
    Air     =>  9,
    HTMX    =>  7,
    Grammar =>  8,
    "»"     =>  9,
    "«"     =>  9,
    "∞"     =>  8,
;

my $site =
site :register[Air::Plugin::Wordcloud.new, LightDark.new],
    page
        main [
            h3 'Word Cloud';
            wordcloud %words, :width(700), :height(400);
        ]
;

$site.serve;
```

## Description

`Air::Plugin::Wordcloud` wraps [wordcloud2.js](https://github.com/timdream/wordcloud2.js) as an Air component. It renders a `<canvas>` element and drives it with an inline script, injecting the CDN library link automatically via Air's plugin system.

The word list is a `Hash` of `word => weight` pairs — the weight controls the relative font size of each word in the cloud.

### Options

The following options are passed through to wordcloud2.js and can be overridden via `:options(...)`:

| Option            | Default         | Description                              |
|-------------------|-----------------|------------------------------------------|
| `gridSize`        | `8`             | Grid cell size in px — smaller = denser  |
| `weightFactor`    | `10`            | Font size multiplier                     |
| `fontFamily`      | `'sans-serif'`  | Font family                              |
| `color`           | `'random-dark'` | Word colour — `'random-dark'` or `'random-light'` |
| `rotateRatio`     | `0.5`           | Fraction of words rotated (0–1)          |
| `backgroundColor` | `'transparent'` | Canvas background                        |

Any [wordcloud2.js option](https://github.com/timdream/wordcloud2.js/blob/gh-pages/API.md) can be passed.

### Client-side re-rendering

The plugin exposes the options object as a global JS variable (via `.js-var`) so the cloud can be re-rendered client-side with modified options — useful for interactive controls:

```raku
script q:to/JS/;
    function rerenderWC() {
        var opts = Object.assign({}, _wordcloud_1);
        opts.gridSize     = 2;
        opts.weightFactor = 18;
        WordCloud(document.getElementById('/wordcloud/1'), opts);
    }
    JS
```

See [Air::Examples](https://raku.land/zef:librasteve/Air::Examples) (`bin/27-wordcloud.raku`) for a full working example including light/dark toggle and horizontal/vertical and fill-field controls.

## Installation

```
zef install Air::Plugin::Wordcloud
```

## Author

librasteve <librasteve@furnival.net>

## Copyright and License

Copyright 2026 Stephen Roe.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
