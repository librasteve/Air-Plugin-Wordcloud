use Air::Base;
use Air::Functional :BASE;
use Air::Component;

role Air::Plugin::Wordcloud does Component {

    # Word => weight map
    has %.words;

    # Canvas size
    has $.width  = 500;
    has $.height = 300;

    # Additional options (passed to JS)
    has %.options = (
        gridSize         => 8,
        weightFactor     => 10,
        fontFamily       => 'sans-serif',
        color            => 'random-dark',
        rotateRatio      => 0.5,
        backgroundColor  => 'transparent',
    );

    #| Positional: word => weight hash
    multi method new(%words, *%h) {
        self.bless: :%words, |%h;
    }

    method js-var {
        $.url-path.subst(:g, '/', '_').subst(:g, '-', '_')
    }

    multi method HTML {

        # Convert word => weight hash -> JS array of [word, weight] pairs
        my $list-js = [%!words.map: { [$_.key, $_.value] }].raku;

        # Convert options hash -> JS object body
        my $opts-body = "";
        for %!options.kv -> $k, $v {
            my $val = $v ~~ Str ?? "'$v'" !! $v;
            $opts-body ~= "  $k: $val,\n";
        }

        my $var = $.js-var;

        my $script = qq:to/END/;
            var $var = \{
            {$opts-body}  list: $list-js
            \};
            WordCloud(document.getElementById(\'$.url-path\'), $var);
        END

        div [
            canvas :id($.url-path), :width($.width), :height($.height);
            script $script;
        ];
    }

    method SCRIPT-LINKS {
        'https://cdn.jsdelivr.net/npm/wordcloud@1.2.2/src/wordcloud2.js'
    }

    method STYLE {
        q:to/END/;
        canvas {
            display: block;
        }
        END
    }
}

sub wordcloud(%words, *%h) is export {
    Air::Plugin::Wordcloud.new(%words, |%h);
}
