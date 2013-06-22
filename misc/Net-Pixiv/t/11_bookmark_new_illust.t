use strict;
use Test::More tests => 7;
use URI;
use Net::Pixiv::Page::BookmarkNewIllust;

my $p = Net::Pixiv::Page::BookmarkNewIllust->new;

ok $p, 'instance ok';

is $p->_moniker, 'Net::Pixiv::Page::BookmarkNewIllust', 'moniker ok';
is $p->get_url,  'http://www.pixiv.net/bookmark_new_illust.php', 'url ok';
isa_ok $p->get_scraper, 'Web::Scraper';


$p->conf->{illust_id} = 10;
ok !$p->is_limit({ link => URI->new('http://localhost?illust_id=10') }), 'check method ok';

$p->conf->{illust_id} = 11;
ok $p->is_limit({ link => URI->new('http://localhost?illust_id=10') }),  'check method ok';

$p->conf->{illust_id} = 9;
ok !$p->is_limit({ link => URI->new('http://localhost?illust_id=10') }), 'check method ok';
