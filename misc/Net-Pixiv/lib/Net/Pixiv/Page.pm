package Net::Pixiv::Page;
use Any::Moose 'Role';
use Config::Pit;

sub _moniker {
    my $self  = shift;
    my $moniker = ref $self || $self;
}

sub _load   {
    my $self = shift;
    return Config::Pit::pit_get($self->_moniker);
}

sub _save   {
    my($self,$conf) = @_;
    return Config::Pit::pit_set($self->_moniker, data => $conf);
}

has conf =>
    is      => 'rw',
    isa     => 'HashRef',
    default => sub {
        my $self = shift;
        return $self->_load;
    };

sub save_config {
    my $self = shift;
    $self->_save($self->conf);
}

requires 'get_url';
requires 'get_scraper';
requires 'is_limit';

1;
__END__

=head1 NAME

Net::Pixiv::Page -

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
