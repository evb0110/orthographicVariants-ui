#!/usr/bin/perl6

my constant $file_all = "ritter_turoyo_lc.txt";
my constant $aletter = 'a';
my constant $oletter = 'o';

use Semsort;

my $words = $file_all.IO.words.Bag;

my Str @awords = $words.keys.grep:
        * ~~ /  $aletter $  /;

for @awords -> $aword {
  my $oword = a_to_o($aword);
  if $oword (elem) $words {
    say "$aword ←→ $oword";
  }
}

sub a_to_o($aword) {
  my $oword = $aword.subst( / $aletter $ /, $oletter );
  return $oword;
}
