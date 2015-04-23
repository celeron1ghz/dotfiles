#!/usr/bin/perl
use strict;
use File::Find;

my $HOME = $ENV{HOME};
my $PWD  = $ENV{PWD};

## aliasing dotfiles
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

## aliasing normal files
my %alias = (
    "$PWD/tmux/mytheme.sh" => "$HOME/tmux-powerline/themes/mytheme.sh"
);

while ( my($from,$target) = each %alias )   {
    if (-l $target) {
        warn "symlink $target already exist";
        next;
    }

    symlink $from => $target or die "fail to make $target: $!";
    print "aliased $from -> $target\n";
}
