#!/usr/bin/env perl
use strict;
use warnings;
use FindBin::libs;

use Perl6::Say;
use Algorithm::SuffixArray;

my $text = shift or die "usage: $0 <text> [query]";
my $sa = Algorithm::SuffixArray->new(\$text);

$sa->show;

if (my $q = shift) {
    if (my @pos = $sa->search_index($q)) {
        say sprintf "%d substring(s) found:", scalar @pos;
        say sprintf "postion: %d", $_ for @pos;
    }
}
