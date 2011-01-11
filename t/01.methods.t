use strict;
use warnings;
use Test::Base tests => 2;
use Time::Piece::HTTP;

{
    my $time = gmtime;
    can_ok $time, qw(
        c_islocal tzoffset _wday mday _mon year hms gmtime
        http_strftime http_cookie_expires http_strptime
    );
}

{
    my $time = localtime;
    can_ok $time, qw(
        c_islocal tzoffset _wday mday _mon year hms gmtime
        http_strftime http_cookie_expires http_strptime
    );
}

#done_testing;

