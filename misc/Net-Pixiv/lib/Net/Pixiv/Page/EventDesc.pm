package Net::Pixiv::Page::EventDesc;
use Any::Moose;
use Web::Scraper;

with 'Net::Pixiv::SinglePage';
with 'Net::Pixiv::Page';

sub get_url {
    my($self,$args) = @_;
    "http://www.pixiv.net/member_event.php?id=$args->{user_id}&event_id=$args->{event_id}"
}

sub get_scraper {
    scraper {
        process 'table.ws_table', 'illusts[]' => scraper {
            process 'td.td1', 'link[]'  => 'TEXT';
            process 'td.td2', 'title[]' => 'TEXT';
        }
    };
}

has '+conf' => ( is => 'ro', isa => 'HashRef', default => sub { +{} } );
sub save_config { }

1;
__END__

=head1 NAME

Net::Pixiv::Page::EventDesc -

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
