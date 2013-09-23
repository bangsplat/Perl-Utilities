#! /usr/bin/perl

use Time::localtime;
use strict;

# yesterday.pl
# return yesterday's date in ISO 8601 Date format (YYYY-MM-DD)
# we're doing this by subtracting one day's worth of seconds from the current time
# this is a little risky around daylight savings time changes
# but it should work 99.9% of the time

print ISO_date_format( yesterday() ) . "\n";

sub ISO_date_format {
	my $tm = shift @_;
	my ( $day, $month, $year ) = ( $tm->mday, sprintf( '%02d', ( $tm->mon + 1 ) ), sprintf( '%02d', ( $tm->year + 1900 ) ) );
	return "$year-$month-$day";
}

sub yesterday {
	return( localtime( time() - ( 24 * 60 * 60 ) ) );
}
