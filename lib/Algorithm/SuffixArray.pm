package Algorithm::SuffixArray;
use strict;
use warnings;
use base qw/Class::Accessor::Lvalue::Fast/;

our $VERSION = '0.01';

use Algorithm::DivSufSort qw/divsufsort/;
use Params::Validate qw/validate_pos SCALARREF/;

__PACKAGE__->mk_accessors(qw/text array size/);

sub new {
    my ($class, $text) = validate_pos(@_, 1, { type => SCALARREF });
    my $self = $class->SUPER::new;

    $self->text  = $text;
    $self->array = divsufsort($$text);

    bless $self, $class;
}

sub search_index {
    my ($self, $q) = validate_pos(@_, 1, 1);
    my $pos = $self->bsearch($q, -1, scalar @{$self->array}) or return;

    my @ret;
    while ($q eq substr(${$self->text}, $self->array->[$pos], length $q)) {
        push @ret, $self->array->[$pos];
        $pos++;

        if (not defined $self->array->[$pos]) {
            last;
        }
    }

    return @ret;
}

sub bsearch {
    my ($self, $q, $start, $end) = validate_pos(@_, 1 , 1, 1, 1);

    if ($start+1 == $end) {
        return $end;
    }

    my $pos = int(($start + $end) / 2);
    my $str = substr(${$self->text}, $self->array->[$pos], length $q);

    (($q cmp $str) > 0)
        ? $self->bsearch($q, $pos, $end)
        : $self->bsearch($q, $start, $pos);
}

sub show {
    my $self = shift;
    for (my $i = 0; $i < @{$self->array}; $i++) {
        printf
            "sa[%2d] = %2d, substr(text, %2d) = %s\n",
            $i,
            $self->array->[$i],
            $self->array->[$i],
            substr(${$self->text}, $self->array->[$i]),
        ;
    };
}

1;
__END__

=head1 NAME

Algorithm::SuffixArray - Suffix Array

=head1 SYNOPSIS

  use Algorithm::SuffixArray;

  my $text = "abracadabra";
  my $sa = Algorithm::SuffixArray->new(\$text);

  my @pos = $sa->search_index("bra");

=head1 DESCRIPTION

=head1 SEE ALSO

L<Algorithm::DivSufSort>

=head1 AUTHOR

Naoya Ito, E<lt>naoya at bloghackers.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2008 by Naoya Ito

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.8 or,
at your option, any later version of Perl 5 you may have available.


=cut
