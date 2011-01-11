use strict;
use warnings;
use Test::Base tests => 2;
use Time::Piece::HTTP;

my $time = time;

my $g = gmtime($time);
my $c = localtime($time);

is $g->http_strftime, $c->http_strftime, 'http_strftime';
is $g->http_cookie_expires, $c->http_cookie_expires, 'http_cookie_expires';

#done_testing;

