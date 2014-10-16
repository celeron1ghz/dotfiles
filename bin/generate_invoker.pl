#!/usr/bin/env perl
use strict;
use FindBin;
use File::Spec;
use Cwd;
use Time::Piece;
use Path::Tiny;
use File::Basename;

sub generate_env_exec   {
    my $PROJECT_HOME = getcwd;
    my $ENV_EXEC     = File::Spec->catfile($PROJECT_HOME, 'cron', 'env-exec');

    #my $env  = $ENV{PERLBREW_PATH};
    my $env  = `which perl`; chomp $env; $env = dirname($env);
    my $path = sprintf "local/bin:%s:\$PATH", $env;
    my $user = `whoami`; chomp $user;

    my $ENV_EXEC_CONTENT = <<ENV_EXEC;
#!/bin/sh
set -e
export USER=$user
export HOME=/home/\$USER
cd \$(dirname "\$0")
cd ..

export PATH="$path"
export PERL5LIB="lib:local/lib/perl5"
export PLACK_ENV=production
exec "\$@"
ENV_EXEC

    open my $fh, '>', $ENV_EXEC or die "$ENV_EXEC: $!";
    print $fh $ENV_EXEC_CONTENT;
    close $fh;

    chmod 0755, $ENV_EXEC;
}

generate_env_exec();
