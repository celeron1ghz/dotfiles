use strict;
use FindBin;
use File::Spec;
use Cwd;
use Time::Piece;
use Path::Tiny;

sub generate_env_exec   {
    my $PROJECT_HOME = Cwd::realpath($FindBin::Bin);
    my $ENV_EXEC     = File::Spec->catfile($PROJECT_HOME, 'cron', 'env-exec');

    my $perlenv = "$ENV{HOME}/.perlbrew/init";
    my %init_value;
    {
        local $/;
        open my $fh, $perlenv or die "$!: $perlenv";
        my $content = <$fh>;
        close $fh;
        %init_value = $content =~ /export (\w+)="(.*?)"/g;
    }

    my $path = sprintf "local/bin:%s:\$PATH", $init_value{PERLBREW_PATH};
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

    my $file = path($ENV_EXEC);
    $file->spew($ENV_EXEC_CONTENT);
    $file->chmod(0755);
}
