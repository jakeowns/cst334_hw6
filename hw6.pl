#!/usr/bin/perl
use strict;
use warnings;
use feature qw(say);

# Global Variables
my (@u_burst, @burst);

# calc_wait()
sub calc_wait {
	my $jobs = shift; #Get first arg
	for (0 .. $#{$jobs}) { #Start from 0 and end with array $jobs length
		if($_ == 0) {
			$jobs->[$_]{wait} = 0; #First job wait time is always 0
		} else {
      #Current job wait time is the previous job's wait time + burst time
			$jobs->[$_]{wait} = $jobs->[$_-1]{burst} + $jobs->[$_-1]{wait}; 
		}
	}
}

# print_jobs()
sub print_jobs {
	my $jobs = shift; #Get first arg
	my $sum = 0;
	for(@{$jobs}) {
		$sum += $_->{wait}; #Add all the wait time together
    #Output the list of jobs with burst time and wait time
		say $_->{name} . ' burst-time: ' . $_->{burst} . 's wait-time: ' . $_->{wait} . 's';
	}
	say "Average waiting is: " . $sum/@{$jobs} . "s"; #Output average wait time
}

# init burst
for(glob("/home/cst334/HW6/Job[0-9]*")){
	my $wait = undef;
	my $s_time = time(); #Current Time
	system($_ . " >/dev/null 2>&1"); #Run the script
	s{.*/}{}; #Greedy substitute remove directory till ends with Job#
	push @u_burst, { 
		'name' => $_, #Assign array key with "Job#"
		'burst' => (time() - $s_time) #Get Burst Time from (end time - start time)
	};
}

# calc wait
say "Before:";
calc_wait(\@u_burst);
print_jobs(\@u_burst);

# sort and calc wait
say "After:";
@burst = sort { $a->{burst} <=> $b->{burst} } @u_burst;  #Sort ascending order
calc_wait(\@burst);
print_jobs(\@burst);
__END__
