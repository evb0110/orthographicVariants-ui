#!/usr/bin/perl6

my constant $file_all = "ritter_turoyo_lc.txt";
my constant $uletter = 'ṣ';
my constant $əletter = 'š';

use Semsort;

my $words = $file_all.IO.words.Bag;

my Str @uəwords = $words.keys.grep:
        *.contains( $uletter | $əletter );

my %class = @uəwords.classify( &u_to_ə );

my Str @results = %class
          .grep( *.value > 1 )
          .map( *.value )
          .map({
	      .sort
	      .map( &add_frequency )
	      .join( ' ←→ ' )
          });

.say for @results.&semsort;


#=== Subroutines ===

sub u_to_ə( $word --> Str ) {
    return $word.subst: $uletter, $əletter, :g;
}

sub add_frequency( $word --> Str ) {
    return "$word ($words{$word})";
}
