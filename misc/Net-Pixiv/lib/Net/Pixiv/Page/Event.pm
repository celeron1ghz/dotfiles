package Net::Pixiv::Page::Event;
use Any::Moose;
use Web::Scraper;

with 'Net::Pixiv::Page';

sub get_url {
    my($self,$args) = @_;
    "http://www.pixiv.net/event_member.php?event_id=$args->{event_id}&mode=circle&type=book";
}

sub get_scraper {
    scraper {
        process 'div.thumb.thumbFull ul li', 'illusts[]' => scraper {
            process 'a',    'link' => '@href';
            process 'img',  'title' => '@alt';
            process 'img',  'image' => '@src';
        }
    };
}

has '+conf' => ( is => 'ro', isa => 'HashRef', default => sub { +{} } );
sub is_limit    {0}
sub save_config { }

1;
__END__

=head1 NAME

Net::Pixiv::Page::Event -

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
