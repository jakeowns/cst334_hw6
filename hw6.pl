#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);
my (@u_burst, @burst);
sub calc_wait {
	my $jobs = shift;
	for (0 .. $#{$jobs}) {
		if($_ == 0) {
			$jobs->[$_]{wait} = 0;
		} else {
			$jobs->[$_]{wait} = $jobs->[$_-1]{burst} + $jobs->[$_-1]{wait};
		}
	}
}
sub print_jobs {
	my $jobs = shift;
	my $sum = 0;
	for(@{$jobs}) {
		$sum += $_->{wait};
		say $_->{name} . ' burst-time: ' . $_->{burst} . 's wait-time: ' . $_->{wait} . 's';
	}
	say "Average waiting is: " . $sum/@{$jobs};
}
# init burst
for(glob("/home/cst334/HW6/Job[0-9]*")){
	my $wait = undef;
	my $s_time = time();
	system($_ . " >/dev/null 2>&1");
	s{.*/}{};
	push @u_burst, { 
		'name' => $_,
		'burst' => (time() - $s_time)
	};
}
# calc wait
say "Before:";
calc_wait(\@u_burst);
print_jobs(\@u_burst);
# sort and calc wait
say "After:";
@burst = sort { $a->{burst} <=> $b->{burst} } @u_burst;  # sort ascending order
calc_wait(\@burst);
print_jobs(\@burst);
__END__
