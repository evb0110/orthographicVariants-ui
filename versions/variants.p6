my constant $uletter = 'u';
my constant $əletter = 'ə';

sub var ($uword) returns List {
    my @ind = $uword.indices($uletter); 
    return @ind.combinations(1..*).List;
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

my $word = 'butakuru';
say mut($word);
