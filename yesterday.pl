#! /usr/bin/perl

use Time::localtime;
use strict;

# yesterday.pl

print ISO_date_format( yesterday() ) . "\n";

sub ISO_date_format {
	my $tm = shift @_;
	my ( $day, $month, $year ) = ( $tm->mday, sprintf( '%02d', ( $tm->mon + 1 ) ), sprintf( '%02d', ( $tm->year + 1900 ) ) );
	return "$year-$month-$day";
}

sub today {
	return( localtime() );
}

sub yesterday {
	return( localtime( time() - ( 24 * 60 * 60 ) ) );
}
