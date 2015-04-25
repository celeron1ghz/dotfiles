#!/usr/bin/perl
use strict;
use File::Find;
use File::Basename;
use FindBin;

my $HOME    = $ENV{HOME};
my $REPODIR = $FindBin::Bin;
my @files;

find(sub{
    next if $_ eq '.';
    next if $_ eq '..';
    next if $_ eq '.git';
    next unless /^\./;
    push @files, $File::Find::name;
}, $REPODIR);

for my $file (@files)   {
    my $aliase_to = $ENV{HOME} . '/' . basename($file);

    if (-l $aliase_to)  {
        warn "exist alias  : $aliase_to\n";
        next;
    }

    if (-e $aliase_to)  {
        warn "exist file   : $aliase_to\n";
        next;
    }

    symlink $file => $aliase_to or die "fail to make $aliase_to: $!";
        warn "create alias : $file -> $aliase_to\n";
}

__END__
my %alias = (
    "$PWD/tmux/mytheme.sh" => "$HOME/tmux-powerline/themes/mytheme.sh"
);
