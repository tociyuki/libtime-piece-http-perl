use strict;
use warnings;
use Test::Base;
use Time::Piece::HTTP;
use Time::Local;

plan tests => 1 * blocks;
filters {
    input => [qw(eval test_http_strftime)],
    expected => [qw(eval)],
};

run_is 'input' => 'expected';

sub test_http_strftime {
    return gmtime(timegm(@_))->http_strftime;
}

#done_testing;

__END__

=== Sunday
--- input
56, 34, 12, 2, 0, 2011
--- expected
'Sun, 02 Jan 2011 12:34:56 GMT'

=== Monday
--- input
56, 34, 12, 3, 0, 2011
--- expected
'Mon, 03 Jan 2011 12:34:56 GMT'

=== Tuesday
--- input
56, 34, 12, 4, 0, 2011
--- expected
'Tue, 04 Jan 2011 12:34:56 GMT'

=== Wednesday
--- input
56, 34, 12, 5, 0, 2011
--- expected
'Wed, 05 Jan 2011 12:34:56 GMT'

=== Thursday
--- input
56, 34, 12, 6, 0, 2011
--- expected
'Thu, 06 Jan 2011 12:34:56 GMT'

=== Friday
--- input
56, 34, 12, 7, 0, 2011
--- expected
'Fri, 07 Jan 2011 12:34:56 GMT'

=== Saturday
--- input
56, 34, 12, 8, 0, 2011
--- expected
'Sat, 08 Jan 2011 12:34:56 GMT'

=== January
--- input
56, 34, 12, 1, 0, 2011
--- expected
'Sat, 01 Jan 2011 12:34:56 GMT'

=== February
--- input
56, 34, 12, 1, 1, 2011
--- expected
'Tue, 01 Feb 2011 12:34:56 GMT'

=== March
--- input
56, 34, 12, 1, 2, 2011
--- expected
'Tue, 01 Mar 2011 12:34:56 GMT'

=== April
--- input
56, 34, 12, 1, 3, 2011
--- expected
'Fri, 01 Apr 2011 12:34:56 GMT'

=== May
--- input
56, 34, 12, 1, 4, 2011
--- expected
'Sun, 01 May 2011 12:34:56 GMT'

=== June
--- input
56, 34, 12, 1, 5, 2011
--- expected
'Wed, 01 Jun 2011 12:34:56 GMT'

=== July
--- input
56, 34, 12, 1, 6, 2011
--- expected
'Fri, 01 Jul 2011 12:34:56 GMT'

=== August
--- input
56, 34, 12, 1, 7, 2011
--- expected
'Mon, 01 Aug 2011 12:34:56 GMT'

=== September
--- input
56, 34, 12, 1, 8, 2011
--- expected
'Thu, 01 Sep 2011 12:34:56 GMT'

=== October
--- input
56, 34, 12, 1, 9, 2011
--- expected
'Sat, 01 Oct 2011 12:34:56 GMT'

=== November
--- input
56, 34, 12, 1, 10, 2011
--- expected
'Tue, 01 Nov 2011 12:34:56 GMT'

=== December
--- input
56, 34, 12, 1, 11, 2011
--- expected
'Thu, 01 Dec 2011 12:34:56 GMT'

