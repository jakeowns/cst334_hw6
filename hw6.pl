#!/usr/bin/perl
use strict;
use warnings;
my @jobsLocation = glob("/home/cst334/HW6/Job[0-9]*");
my @burst;
# get burst time
for(@jobsLocation){
	push @burst, `/usr/bin/time -f "%e" $_ | grep -v "Running"`;
}
map { $_ }, 0 .. $#burst
# print burst time
for(@burst) {
	print $_ . '\n';
}
