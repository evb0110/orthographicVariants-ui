my constant $file_all = "ritter_turoyo_lc.txt";
my constant $uletter = 'p';
my constant $əletter = 'f';

my @words = $file_all.IO.words;
my %words;
%words{$_}++ for @words;

my @words_uniq = @words.unique.sort;
my Set $words_uniq = @words_uniq.Set;

for @words_uniq -> $word {
  my $nword = 'n' ~ $word;
  say "$word ←→ $nword" 
        if $nword (elem) $words_uniq;
}
