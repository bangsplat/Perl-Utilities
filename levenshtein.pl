#!/usr/bin/perl -w

use strict;
use warnings;
use List::Util qw( min );

# levenshtein.pl
# Levenshtein Distance
# 
# based on a post on Perl Monks by spurperl
# http://www.perlmonks.org/?node=Levenshtein%20distance%3A%20calculating%20similarity%20of%20strings
# 
# Calculate the Levenshtein Distance (aka edit distance) of two strings
# this show the minimum number of edits are needed to change one string into another
# this is effectively an inverse of similarity, useful for "fuzzy" text matches
# 
# Created 2016-08-12
# Modified 2016-08-15
# Version 1.0.1
#
# revision history
# 
# Version 1.0
# 	first working version
# Version 1.0.1
# 	converting from using hash for matrix to a an array

## make this useful from the command line
## require two parameters

# if the number of arguments is not exactly 2, quit with the syntax
# $#ARGV is a special variable that contains the last subscript of the last element in @ARGV
# 	@ARGV is zero-based, so $#ARGV == 1 means two arguments passed (annoying, I know)
# $0 is a special variable that contains the program name
if ( $#ARGV != 1 ) { die "Usage: $0 <string1> <string2>\n"; }

## split @ARGV into two variables
my ( $s1, $s2 ) = @ARGV;

print "The Levenshtein Distance between $s1 and $s2 is: " . levenshtein($s1, $s2) . "\n";


# levenshtein()
#
# return the Levenshtein Distance (aka edit distance) between two strings
#
# the Levenshtein Distance is the minimum number of edits required to transform 
# one string into another
# it was proposed by Vladimir Levenshtein in 1965
sub levenshtein
{
	my $cost;	# "substitution cost" for character comparisons
	my @matrix;	# matrix for calculating distance
	
    # $s1 and $s2 are the two strings
    # $len1 and $len2 are their respective lengths
    my ( $s1, $s2 ) = @_;
    my $len1 = length( $s1 );
    my $len2 = length( $s2 );
	
	# split the two strings into arrays for character-by-character access
    my @ar1 = split( //, $s1 );
    my @ar2 = split( //, $s2 );
	
    # If one of the strings is empty, the distance is the length of the other string
    if ( $len1 eq 0 ) { return( $len2 ); }
    if ( $len2 eq 0 ) { return( $len1 ); }
	
	# initialize the distance matrix
	# 
	# basically, everything starts at 0
	# but the leftmost column and top row are numbered 0..$len1/$len2
    #
    # the first row/column values are essentially the distance from a empty string
    # so they are starting point, and the values change from there
    # 
    # start by everything but the first row/column to 0
	for ( my $i = 1; $i <= $len1; $i++ ) {
		for ( my $j = 1; $j <= $len2; $j++ ) {
			$matrix[$i][$j] = 0;
		}
	}
	# now set the values of the first row and column sequentially, starting with 0
	for ( my $i = 0; $i <= $len1; $i++ ) { $matrix[$i][0] = $i; }
	for ( my $j = 0; $j <= $len2; $j++ ) { $matrix[0][$j] = $j; }
	
	# step through the cells of the matrix and do the comparisons
    for ( my $i = 1; $i <= $len1; ++$i ) {
        for ( my $j = 1; $j <= $len2; ++$j ) {
        	# for each character combination, compare the two
        	# if they are the same, there is 0 substitution cost
        	# otherwise, set cost to 1
            if ( $ar1[$i-1] eq $ar2[$j-1] ) { $cost = 0; } else { $cost = 1; }
			
			# each cell gets a value that is the minimum of:
            # 	the cell immediately above plus 1
            # 	the cell immediately to the left plus 1
            # 	the cell diagonally above and to the left + the cost
            $matrix[$i][$j] = min( $matrix[$i-1][$j] + 1,
                                	$matrix[$i][$j-1] + 1,
                                	$matrix[$i-1][$j-1] + $cost );
        }
    }
	
	# the values are a cumulative distance for the two strings
	# the final value is the bottom right cell
    return( $matrix[$len1][$len2] );
}
