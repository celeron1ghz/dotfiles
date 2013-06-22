BEGIN{
    package Net::Pixiv::Page::Moge;
    use Any::Moose;
    with 'Net::Pixiv::MultiPage';
    with 'Net::Pixiv::Page';

    sub get_url{}
    sub get_scraper{}
    sub is_limit{}
}

use strict;
use Config::Pit qw/pit_get pit_set/;
use Test::More tests => 8;

my $p = Net::Pixiv::Page::Moge->new;
my $expected = { moge => 'fuga' };

is $p->_moniker, 'Net::Pixiv::Page::Moge', 'moniker ok';


# raw function tests...
is_deeply $p->_load, {}, 'nothing value on first load';


$p->_save($expected);
is_deeply $p->_load,                         $expected, 'save can work';
is_deeply pit_get('Net::Pixiv::Page::Moge'), $expected, 'save can work';


# public interface tests...
$p = Net::Pixiv::Page::Moge->new;
is_deeply $p->conf, $expected, 'load config ok';


$p->conf({});
$p = Net::Pixiv::Page::Moge->new;
is_deeply $p->conf, $expected, 'save not running';


$expected = { piyo => 'moga' };
$p->conf($expected);
$p->save_config;
$p = Net::Pixiv::Page::Moge->new;
is_deeply $p->conf, $expected, 'save can work';


$p->conf({});
$p->save_config;
$p = Net::Pixiv::Page::Moge->new;
is_deeply $p->conf, {}, 'cleanup ok';
