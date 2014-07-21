#!/usr/bin/env perl
package VPS::Setup::Template::Supervisor;
use strict;

sub executable { 0 }

sub output_path {
    my($self,$param) = @_;
    $param->{parent}->basedir->subdir("supervisor")->file(sprintf "%s.supervisor.ini", $param->{conf}->{id});
}

sub templates   {
    my($self,$param) = @_;

<<EOT;
[program:$param->{conf}->{id}]
command=@{[ $param->{parent}->basedir ]}/runner/$param->{conf}->{id}.runner.sh
directory=$param->{dist_dir}
numprocs=1
autostart=true
autorestart=true
redirect_stderr=true
stdout_logfile=@{[ $param->{parent}->basedir ]}/log/$param->{conf}->{id}.log
stdout_logfile_maxbytes=1MB
stdout_logfile_backups=10
EOT
}

package VPS::Setup::Template::RunnerShellFile;
use strict;

sub executable { 1 }

sub output_path {
    my($self,$param) = @_;
    $param->{parent}->basedir->subdir("runner")->file(sprintf "%s.runner.ini", $param->{conf}->{id});
}

sub templates   {
    my($self,$param) = @_;

<<EOT;
#!/usr/bin/env bash
cd $param->{dist_dir}
exec carton exec -- \\
    plackup \\
        -Ilib \\
        -s Starlet \\
        -E production \\
        --host 127.0.0.1 \\
        --port $param->{conf}->{port}
EOT
}

package VPS::Setup::Template::Nginx;
use strict;

sub executable { 0 }

sub output_path {
    my($self,$param) = @_;
    $param->{parent}->basedir->subdir("nginx")->file(sprintf "%s.nginx.conf", $param->{conf}->{id});
}

sub templates   {
    my($self,$param) = @_;

<<EOT;
server {
    listen       80;
    server_name  $param->{conf}->{id}.camelon.info;

    location / {
        proxy_pass http://localhost:$param->{conf}->{port};
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header Host \$host;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOT
}

package VPS::Setup;
use Mouse;
use Path::Class;
use YAML;

has basedir => ( is => 'ro', isa => 'Path::Class::Dir', default => sub { dir($ENV{HOME}) } );

my @assets = (
    'VPS::Setup::Template::Supervisor',
    'VPS::Setup::Template::RunnerShellFile',
    'VPS::Setup::Template::Nginx',
);

sub run {
    my $self = shift;
    my @target_dir =
        grep { $_->basename =~ /^p5-/ }
        grep { $_->isa("Path::Class::Dir") }
            $self->basedir->children;

    for my $dist (@target_dir)  {
        my $rcfile = $dist->file(".vpsrc");

        if (-e $rcfile) {
            my $data = YAML::LoadFile($rcfile);

            my $id = $data->{id}   or die "id not specified in $rcfile";
            my $port = $data->{port} or die "port not specified in $rcfile";

            warn "processing $dist (id=$id,port=$port)";

            for my $clazz (@assets) {
                my $param = {
                    dist_dir => $dist,
                    parent => $self,
                    conf => $data,
                };

                my $path = $clazz->output_path($param);
                my $template = $clazz->templates($param);

                if (-e $path)   {
                    warn "  EXIST  $path";
                }
                else    {
                    warn "  CREATE $path";
                    my $file = file($path);
                    $file->parent->mkpath;

                    my $fh = $file->openw or die "$file: $!";
                    print $fh $template;
                    close $fh;

                    if ($clazz->executable) {
                        chmod 0755, $file;
                    }
                }
            }
        }

    }
}


package main;
use strict;

VPS::Setup->new->run;

