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

## Installation

If you already have [Air](https://raku.land/zef:librasteve/Air) working, then:

 - `zef install Air::Plugin::Wordcloud`

Otherwise, follow the Air::Examples [Getting Started](https://github.com/librasteve/Air-Examples/blob/main/README.md#getting-started)

 - `cd Air-Examples`
 - `raku bin/27-wordcloud.raku`
 - point browser to `http://localhost:3000`

## Author

librasteve <librasteve@furnival.net>

## Copyright and License

Copyright 2026 Stephen Roe.

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.
