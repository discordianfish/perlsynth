# $Id$

package PerlSynth;
use strict;
use warnings;

use Carp qw(croak confess);
use Audio::Wav;

use Class::Accessor 'moose-like';

has sample_rate     => (is => 'ro', isa => 'Num');
has bits_per_sample => (is => 'ro', isa => 'Num');
has channels        => (is => 'ro', isa => 'Num');
has filename        => (is => 'ro', isa => 'Str');
has pi              => (is => 'ro', isa => 'Num');

our $VERSION = '0.0.0';

sub new
{
    my $class = shift;
    my $root = shift;
    my $opt = { @_ };
    my $wav = Audio::Wav->new;

    my $self =
    {
        sample_rate     => $opt->{sample_rate} || 8000,
        bits_per_sample => $opt->{bits_per_sample} || 8,
        channels        => $opt->{channels} || 1,
        filename        => $opt->{filename} || "/tmp/$0.wav",
        pi              => 4 * atan2 1, 1,
    };
    bless $self, $class;

    $self->{_write} = $wav->write($self->filename, { bits_sample => $self->bits_per_sample, sample_rate => $self->sample_rate, channels => $self->channels });

    return $self;
}

sub osc
{
    my $self = shift;
    my $type = ucfirst shift;
    
    my $class = "PerlSynth::Osc::$type";

    eval "use $class";
    croak "could not load $class: $@"
        if ($@);

    return $class->new($self);
}

sub finish { shift->{_write}->finish }
