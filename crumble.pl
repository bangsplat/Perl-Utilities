#! /usr/bin/perl

use strict;

#
# crumble()
#
# chomp() does not clear carriage returns from a string
# this can be a bit of a pain when working with Windows text files on Mac/Linux
# 
# crumble() works like chomp() only it converts any carriage returns
# (or carriage return/linefeed combinations) into linefeeds
# 
# if I come up with another similar routine, I will call it crush()
# so you would get code like this:
# 	crush crumble chomp $text
# 
# the critical part here is the subroutine
# the rest is for demonstration purposes
# 

my $input_file = @ARGV[0];
my $input_data;

open( INPUT, "<", $input_file ) or die $!;
read( INPUT, $input_data, ( -s INPUT ) );
close( INPUT );

crumble $input_data;

print $input_data;


# crumble()
# turn all line endings into Linux line endings
sub crumble {
	return if ref($/);					# return if a reference is passed
	for (@_) { $_ =~ s/\r[\n]/\n/gm }	# turn all \r (old Mac) and \r\n (Windows) line endings int \n (Linux)
	return;								#	this works on the variables in place, the same way chomp() does
}
