#!/usr/bin/perl6

my constant $file_words = "turoyo_words.list";
my constant $uletter = 'i';
my constant $əletter = 'ə';

my @words = $file_words.IO.lines;
@words .= map(*.lc);

my @uwords = @words.grep({/$uletter/});
my @əwords = @words.grep({/$əletter/});
my $set_əwords = @əwords.Set;

for @uwords -> $uword {
  my @ind = $uword.indices($uletter);
  for @ind -> $index {
    (my $əword = $uword)
            .substr-rw( $index, 1 ) = $əletter;
    say "$uword ←→ $əword"
            if $set_əwords (cont) $əword;
  }
}
