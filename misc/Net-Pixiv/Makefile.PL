use inc::Module::Install;
name 'Net-Pixiv';
all_from 'lib/Net/Pixiv.pm';

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_include;
auto_install;
WriteAll;
