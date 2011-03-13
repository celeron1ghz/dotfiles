package Net::Pixiv::Page::BookmarkNewIllust;
use Any::Moose;
use Web::Scraper;

with 'Net::Pixiv::MultiPage';
with 'Net::Pixiv::Page';

sub get_url { 'http://www.pixiv.net/bookmark_new_illust.php' }

sub get_scraper {
    scraper {
        process 'div.search_a2_result ul li', 'illusts[]' => scraper {
            process 'a',    'link' => '@href';
            process 'img',  'title' => '@alt';
            process 'img',  'image' => '@src';
        }
    };
}

sub is_limit    {
    my($self,$illust) = @_;
    my %param   = $illust->{link}->query_form;
    my $current = $param{illust_id};
    my $saved   = $self->conf->{illust_id};
    return $saved > $current;
}

1;
__END__

=head1 NAME

Net::Pixiv::Page::BookmarkNewIllust -

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
