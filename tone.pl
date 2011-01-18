#!/usr/bin/env perl
use strict;
use warnings;

use lib 'lib';
use PerlSynth;

my $synth = PerlSynth->new;

my $i;
while ($i++ < 10)
{
    my $freq = rand(4000);
    my $duration = rand(3);
    my $lfo_freq = rand(1);

    my $osc = $synth->osc('saw');
    my $lfo = $synth->osc('sin');

    $osc->tone($freq, $duration, [ $lfo => $lfo_freq ]);
}
$synth->finish;
