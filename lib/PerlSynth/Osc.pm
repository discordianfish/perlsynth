# $Id$

package PerlSynth::Osc;
use strict;
use warnings;

use constant DEBUG => 0;
use Carp qw(croak confess);

our $VERSION = '0.0.0';

sub new
{
    my $class = shift;
    my $synth = shift;

    my $self = { _synth => $synth };

    bless $self, $class;
    return $self;
}

sub volume { return (2 ** (shift)->{_synth}->bits_per_sample)/2 * shift }

sub write { shift->{_synth}->{_write}->write(@_) };

sub tone
{
    my $self = shift;
    my $freq = shift;
    my $duration = shift || 1;
    my $volume = shift || 1;

    my $synth = $self->{_synth};


    my $samples = $duration * $synth->sample_rate;

    for my $sample (0 .. $samples)
    {
        my $position = $sample / $synth->sample_rate; # between 0 and 1
        my $v;

        if (ref $volume eq 'ARRAY')
        {
            my ($lfo, $lfo_freq) = @$volume;
            $v = $lfo->calc_value($position, $lfo_freq, 1);
        } else
        {
            $v = $volume;
        }


        my $value = $self->calc_value($position, $freq, $v);
        warn "f($position) = $value @ $v"
            if DEBUG;

        $self->write($value);
    }
}


sub calc_value { croak 'you should not call this method directly, it should be implemented by osc' }
