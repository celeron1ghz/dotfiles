BEGIN{
    package Net::Pixiv::Page::Moge;
    use Any::Moose;
    with 'Net::Pixiv::Page';

    sub get_url{}
    sub get_scraper{}
    sub is_limit{}
}

use strict;
use Config::Pit qw/pit_get pit_set/;
use Test::More tests => 6;

my $p = Net::Pixiv::Page::Moge->new;

ok $p, 'instance created';
is $p->_moniker, 'Net::Pixiv::Page::Moge', 'moniker ok';


is_deeply $p->_load, {}, 'nothing on first load';
$p->_save({ moge => 'fuga' });


my $expected = { moge => 'fuga' };
is_deeply $p->_load,                         , $expected, 'save can work';
is_deeply pit_get('Net::Pixiv::Page::Moge'),   $expected, 'save can work';


$p->_save({});
is_deeply $p->_load, {}, 'cleanup ok';
