# $Id$

package PerlSynth::Osc::Sin;
use strict;
use warnings;

use base 'PerlSynth::Osc';

our $VERSION = '0.0.0';

sub calc_value
{
    my $self = shift;
    my $position = shift;
    my $freq = shift;
    my $volume = shift;
    return sin($position * $freq) * $self->volume($volume);
}

