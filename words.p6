my $all = $*IN.slurp;

my @words = $all.words;

$_ ~~ s:g/ <[!?\—,.;:"\- 0 .. 9]> // for @words;

my @uwords = @words.unique;
.say for @uwords;
