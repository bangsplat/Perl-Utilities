#! /usr/bin/perl

use Time::localtime;
use strict;

# yesterday.pl
# return yesterday's date in ISO 8601 Date format (YYYY-MM-DD)
# http://en.wikipedia.org/wiki/ISO_8601
#
# to avoid issues around daylight savings time changes,
# we get the current time (seconds since the epoch),
# then figure out how many hours since noon yesterday,
# then subtract that many seconds and figure out that date

print ISO_date_format( yesterday() ) . "\n";

sub ISO_date_format {
	my $tm = shift @_;
	my ( $day, $month, $year ) = ( $tm->mday, sprintf( '%02d', ( $tm->mon + 1 ) ), sprintf( '%02d', ( $tm->year + 1900 ) ) );
	return "$year-$month-$day";
}

sub yesterday {
	my $curr_time = time();														# time() returns the number of seconds since the Unix epoch
	my $curr_dt = localtime( $curr_time );										# convert into a more usable form
	my $yesterday_time = $curr_time - ( ( $curr_dt->hour() + 12 ) * 3600 );		# get time for yesterday noon
	return( localtime( $yesterday_time ) );										# format into YYYY-MM-DD
}
