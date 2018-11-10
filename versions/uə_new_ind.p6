my constant $file_all = "ritter_turoyo_lc.txt";
my constant $uletter = 'p';
my constant $əletter = 'f';

use Semsort;

my @words = $file_all.IO.words;
my %words;
%words{$_}++ for @words;

@words .= unique;

my @uəwords = @words.grep: 
        *.contains($uletter|$əletter);

my Array @results;

my %class = @uəwords.classify(&uə_indices);
for %class.kv -> $k, $v {
    my @val = $v<>;
    my %class = @val.classify(&to_ə);
    for %class {
        @results.push: .value 
             if .value<>.elems > 1;
    }
}

my Str @results_str; # all variants with frequences

for @results -> $result {
    my @result = $result<>;
    @result .= sort;
    @results_str.push: 
         join '←→ ', 
              @result.map(&add_frequency);
}

.say for @results_str.&semsort;


#=== Subroutines ===

sub uə_indices($word) returns Str {
    my @ind =
       ($uletter, $əletter).map(
          { | $word.indices($_) }
          ).sort;
    return join '_', @ind;
}

sub to_ə($word) returns Str {
    return $word.subst: $uletter, $əletter, :g;
}

sub add_frequency($word) {
    return $word ~ 
           ' (' ~ 
           %words{$word} 
           ~ ') '
           ;
}
