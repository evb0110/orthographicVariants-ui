#!/usr/bin/perl6

my constant $file_all = "ritter_turoyo_lc.txt";
my constant $uletter = 'b';
my constant $əletter = 'p';
my constant $mincomb = 2; # minimal quantity
                          # of changed letters

use Semsort;

my $words = $file_all.IO.words.Bag;

my @uwords = $words.keys.grep: *.contains($uletter);

my $format = "%s (%s) ←→ %s (%s)";

my Str @results;

for @uwords -> $uword {
    for mut($uword) -> $əword {
    push @results,
        sprintf $format,
           $uword,
           $words{$uword},
           $əword,
           $words{$əword}
      if $words{$əword}
           ;
    }
}

.say for @results.&semsort;


#===== Subroutines =====

sub var( $uword --> List) {
    my @ind = $uword.indices($uletter);
    return @ind.combinations($mincomb..*).List;
}

sub mut( $uword --> List) {
    my @nwords;
    for var( $uword ) -> @ind {
        my $nword = $uword;
        for @ind -> $ind {
            $nword.substr-rw($ind, 1) = $əletter;
        }
        @nwords.push($nword);
    }
    return [@nwords];
}
