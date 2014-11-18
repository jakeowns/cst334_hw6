#!/usr/bin/perl
use strict;
use warnings;
use List::Util qw(sum);
my (@u_burst, @burst, $s_time, @sum, @wait_time);
# get burst time
for(glob("/home/cst334/HW6/Job[0-9]*")){
	$s_time = time();
	system($_ . " >/dev/null 2>&1");
	push @u_burst, (time() - $s_time);
}
print "Burst times: " . join(' ', @u_burst) . "\n";
# sort ascending order
@burst = sort { $a <=> $b } @u_burst;
print "Burst times sorted: " . join(' ', @burst) . "\n";
unshift @burst, 0;
@wait_time = map {
	if($_ == 0) {
		$burst[$_];
	} else {
		$burst[$_] += $burst[$_-1];
	}
} 0 .. $#burst;
# print wait time
print "Wait times: " . join(' ', @wait_time) . "\n";
# print avg wait
@sum = @wait_time;
pop @sum;
print "Average: " . sum(@sum)/$#wait_time . "\n";
