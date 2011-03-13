package Net::Pixiv::MultiPage;
use Any::Moose 'Role';

requires 'is_limit';

sub scrape  {
    my($self,$type,$args) = @_;
    my $page = $self->pages->{$type} or die "No such page '$type'";
    my $sc   = $page->get_scraper;
    my $url  = URI->new($page->get_url($args));

    my @illusts;

    OUTER: for ( my $cnt = 1 ;; $cnt++ )   {
        my $orig = { $url->query_form };
        $orig->{p} = $cnt;
        $url->query_form(%$orig);

        warn "fetching $url ...";

        my $res = $self->ua->get($url);
        my $ret = $sc->scrape($res);

        my(undef,$illusts) = each %$ret;

        $illusts = [ grep { keys %$_ } @$illusts ]; # remove empty hash

        last unless $illusts;
        last unless @$illusts;

        push @illusts, grep { !$page->is_limit($_) } @$illusts;
    }

    return @illusts;
}

1;
__END__

=head1 NAME

Net::Pixiv::NultiPage -

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
