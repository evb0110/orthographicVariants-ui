#!/usr/bin/perl6

my constant $file_all = "ritter_turoyo_lc.txt";
my constant $uletter = 'd';
my constant $əletter = 'ḏ';

my @words = $file_all.IO.words;
my %words;
%words{$_}++ for @words;

my @words_uniq = @words.unique.sort;

my @uwords = @words_uniq.grep: *.contains($uletter);
my $format = "%s (%s) ←→ %s (%s)\n";

for @uwords -> $uword {
  my @ind = $uword.indices($uletter);

  for @ind -> $index {
    (my $əword = $uword)
            .substr-rw( $index, 1 ) = $əletter
            ;

    printf $format,
           $uword,
           %words{$uword},
           $əword,
           %words{$əword}
                 if %words{$əword}
           ;
  }
}
