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
    next if $_ eq '.gitignore';
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

if ($^O eq 'darwin') {
    my @macfiles;
    my $repoPath = "$REPODIR/vscode/";
    my $vscodeSettingPath   = "${HOME}/Library/Application Support/Code/";

    find(sub{
        next unless -f $_;
        push @macfiles, $File::Find::name;
    }, $repoPath);

    for my $from (@macfiles) {
        (my $base = $from) =~ s/$repoPath//;
        my $aliase_to = "$vscodeSettingPath$base";

        if (-e $aliase_to) {
            warn "exist mac alias  : $aliase_to\n";
            next;
        }

        symlink $from => $aliase_to or die "fail to make $aliase_to: $!";

        warn "create mac alias : $from -> $aliase_to\n";
    }
}
