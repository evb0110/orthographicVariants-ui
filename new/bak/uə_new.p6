my constant $file_all = "ritter_turoyo_lc.txt";
my constant $uletter = 'u';
my constant $əletter = 'o';
my constant $mincomb = 2; # minimal quantity 
                          # of changed letters

use Semsort;

my @words = $file_all.IO.words;

my %words;
%words{$_}++ for @words;

@words .= unique;
@words .= &semsort;

my @uwords = @words.grep: *.contains($uletter);
my @əwords = @words.grep: *.contains($əletter);

my $format = "%s (%s) ←→ %s (%s)\n";

for @uwords -> $uword {
    for mut($uword) -> $əword {
    printf $format,
           $uword,
           %words{$uword},
           $əword,
           %words{$əword}
                 if %words{$əword}
           ;
    }
}

sub var ($uword) returns List {
    my @ind = $uword.indices($uletter); 
    return @ind.combinations($mincomb..*).List;
}

sub mut ($uword) returns List {
    my @nwords;
    for var($uword) -> @ind {
        my $nword = $uword;
        for @ind -> $ind {
            $nword.substr-rw($ind, 1) = $əletter;
        }
        @nwords.push($nword);
    } 
    return [@nwords];
}
