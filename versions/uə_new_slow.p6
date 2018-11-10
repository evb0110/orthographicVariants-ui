my constant $file_all = "ritter_turoyo_lc.txt";
my constant $uletter = 'u';
my constant $əletter = 'o';

use Semsort;

my @words = $file_all.IO.words;
@words .= map(*.lc);
my %words;
%words{$_}++ for @words;
@words .= unique;
@words .= &semsort;

my @uwords = @words.grep: *.contains($uletter);
my @əwords = @words.grep: *.contains($əletter);
my Array %əlength;
for @əwords {
    %əlength{.chars}.push($_); 
}


my $format = "%s (%s) ←→ %s (%s)\n";

for @uwords -> $uword {
    for %əlength{$uword.chars}.Array -> $əword {
	printf $format,
	       $uword,
	       %words{$uword},
	       $əword,
	       %words{$əword}
	    if equiv($uword, $əword);
    }
}

sub equiv ($word1, $word2) {
    my $w1 = $word1.subst: $uletter, $əletter, :g;
    my $w2 = $word2.subst: $uletter, $əletter, :g;
    my $diff = $word1 ne $word2;
    return ($w1 eq $w2) && $diff;
}
