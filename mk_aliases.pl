#!/usr/bin/perl
use strict;
use File::Find;

my $HOME = $ENV{HOME};
my $PWD  = $ENV{PWD};

find(sub{
	next if $_ eq '.';
	next if $_ eq '..';
	next if $_ eq '.git';
	next unless /^\./;

	my $from   = "$PWD/$_";
	my $target = "$HOME/$_";

    unless ( -e $target )   {
	    symlink $from => $target or die "fail to make $target: $!";

	    print "aliased $from -> $target\n";
    }
}, '.');
