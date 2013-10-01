#! /usr/bin/perl

use Time::localtime;
use strict;

# today.pl
# outputs today's date in ISO 8601 date format
# http://en.wikipedia.org/wiki/ISO_8601

print ISO_date_format( today() ) . "\n";

sub today {
	return( localtime() );
}

sub ISO_date_format {
	my $tm = shift @_;
	my ( $day, $month, $year ) = ( sprintf( '%02d', $tm->mday ), sprintf( '%02d', ( $tm->mon + 1 ) ), sprintf( '%02d', ( $tm->year + 1900 ) ) );
	return "$year-$month-$day";
}
