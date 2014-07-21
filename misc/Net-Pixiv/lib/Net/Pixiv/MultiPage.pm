package Net::Pixiv::MultiPage;
use Any::Moose 'Role';

requires 'is_limit';

sub scrape  {
    my($self,$c,$args) = @_;
    my $sc   = $self->get_scraper;
    my $url  = URI->new($self->get_url($args));
    my @illusts;

    OUTER: for ( my $cnt = 1 ;; $cnt++ )   {
        my $orig = { $url->query_form };
        $orig->{p} = $cnt;
        $url->query_form(%$orig);

        warn "fetching $url ...";

        my $res = $c->ua->get($url);
        my $ret = $sc->scrape($res);

        my(undef,$illusts) = each %$ret;

        $illusts = [ grep { keys %$_ } @$illusts ]; # remove empty hash

        last unless $illusts;
        last unless @$illusts;

        push @illusts, grep { !$self->is_limit($_) } @$illusts;
    }

    return @illusts;
}

1;
__END__

=head1 NAME

Net::Pixiv::MultiPage -

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