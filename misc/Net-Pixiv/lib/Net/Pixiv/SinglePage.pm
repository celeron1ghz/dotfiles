package Net::Pixiv::SinglePage;
use Any::Moose 'Role';

sub scrape  {
    my($self,$c,$args) = @_; 
    my $sc   = $self->get_scraper;
    my $url  = URI->new($self->get_url($args));

    warn "fetching $url ...";

    my $res = $c->ua->get($url);
    my $ret = $sc->scrape($res);

    return $ret;
}

1;
__END__

=head1 NAME

Net::Pixiv::SinglePage -

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
