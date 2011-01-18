# $Id$

package PerlSynth::Osc::Saw;
use strict;
use warnings;
use POSIX;
use base 'PerlSynth::Osc';

our $VERSION = '0.0.0';

sub calc_value
{
    my $self = shift;
    my $position = shift;
    my $freq = shift;
    my $volume = shift;

    my $pf = $position * $freq;

    return ($pf - floor($pf)) * $self->volume($volume);
}

