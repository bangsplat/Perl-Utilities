#! /usr/bin/perl

use strict;

#
# uncPath.pl
# 
# convert full UNC path/file to just the containing folder path
# as this is specific to Windows UNC paths, all slashes are expected to be backslashes
# 
# version 0.1
# created 2017-05-15
# modified 2017-05-15
# 

my $input_unc_path = @ARGV[0];
my $parent_dir;
my $leaf_name;

$parent_dir = $input_unc_path;
$parent_dir =~ s/\\([^\\]+)$//;			# delete and remember anything after the last slash
										# this is the path (without file)
$leaf_name = $1;						# this is the file name (without path)

print( $parent_dir );
