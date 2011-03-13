package Net::Pixiv;
use Any::Moose;
use LWP::UserAgent;
use HTTP::Request::Common;
use String::CamelCase;
use Module::Pluggable search_path => ['Net::Pixiv::Page'], require => 1;
use URI;

our $VERSION = '0.01';

has ua =>
    is      => 'ro',
    isa     => 'LWP::UserAgent',
    default => sub {
        return LWP::UserAgent->new( cookie_jar => {} );
    };

has pages =>
    is      => 'ro',
    isa     => 'HashRef',
    default => sub {
        my $self = shift;
        return { map { String::CamelCase::decamelize( (split '::' => $_)[-1] ) => $_->new } $self->plugins }
    };

sub login      {
    my($self,$user) = @_;
    my $req  = POST 'http://www.pixiv.net/login.php', [
        mode     => 'login',
        pixiv_id => $user->{pixiv_id},
        pass     => $user->{password},
    ];

    # error handling will be here...
    my $res = $self->ua->request($req);
}

sub scrape  {
    my($self,$type,$args) = @_;
    my $page = $self->pages->{$type} or die "No such page '$type'";
    $page->scrape($self,$args);
}

1;

__END__

=head1 NAME

Net::Pixiv - Interface for Pixiv

=head1 SYNOPSIS

  use Net::Pixiv;

=head1 DESCRIPTION

Net::Pixiv is

=head1 METHOD

=over

=item * method_name()

=back

=head1 AUTHOR

agile E<lt>celeron1ghz@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
