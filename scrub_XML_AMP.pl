#! /usr/bin/perl

my $input_file = @ARGV[0];
my $input_data;

open( INPUT, "<", $input_file ) or die $!;
read( INPUT, $input_data, ( -s INPUT ) );
close( INPUT );

print scrubAMP( $input_data );

sub unescapeAMP {
	my $mystring = $_[0];
	$mystring =~ s/&amp;/&/gms;
	return( $mystring );
}

sub escapeAMP {
	my $mystring = $_[0];
	$mystring =~ s/&/&amp;/gms;
	return( $mystring );
}

sub scrubAMP {
	return escapeAMP( unescapeAMP( $_[0] ) );
}
