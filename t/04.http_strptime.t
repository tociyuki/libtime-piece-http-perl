use strict;
use warnings;
use Test::Base;
use Time::Piece::HTTP;

plan tests => 1 * blocks;
filters {
    input => [qw(eval test_http_strptime)],
    expected => [qw(eval)],
};

run_is 'input' => 'expected';

sub test_http_strptime {
    return gmtime->http_strptime(@_)->http_strftime;
}

#done_testing;

__END__

=== Sunday
--- input
'Sun, 02 Jan 2011 12:34:56 GMT'
--- expected
'Sun, 02 Jan 2011 12:34:56 GMT'

=== Monday
--- input
'Mon, 03 Jan 2011 12:34:56 GMT'
--- expected
'Mon, 03 Jan 2011 12:34:56 GMT'

=== Tuesday
--- input
'Tue, 04 Jan 2011 12:34:56 GMT'
--- expected
'Tue, 04 Jan 2011 12:34:56 GMT'

=== Wednesday
--- input
'Wed, 05 Jan 2011 12:34:56 GMT'
--- expected
'Wed, 05 Jan 2011 12:34:56 GMT'

=== Thursday
--- input
'Thu, 06 Jan 2011 12:34:56 GMT'
--- expected
'Thu, 06 Jan 2011 12:34:56 GMT'

=== Friday
--- input
'Fri, 07 Jan 2011 12:34:56 GMT'
--- expected
'Fri, 07 Jan 2011 12:34:56 GMT'

=== Saturday
--- input
'Sat, 08 Jan 2011 12:34:56 GMT'
--- expected
'Sat, 08 Jan 2011 12:34:56 GMT'

=== January
--- input
'Sat, 01 Jan 2011 12:34:56 GMT'
--- expected
'Sat, 01 Jan 2011 12:34:56 GMT'

=== February
--- input
'Tue, 01 Feb 2011 12:34:56 GMT'
--- expected
'Tue, 01 Feb 2011 12:34:56 GMT'

=== March
--- input
'Tue, 01 Mar 2011 12:34:56 GMT'
--- expected
'Tue, 01 Mar 2011 12:34:56 GMT'

=== April
--- input
'Fri, 01 Apr 2011 12:34:56 GMT'
--- expected
'Fri, 01 Apr 2011 12:34:56 GMT'

=== May
--- input
'Sun, 01 May 2011 12:34:56 GMT'
--- expected
'Sun, 01 May 2011 12:34:56 GMT'

=== June
--- input
'Wed, 01 Jun 2011 12:34:56 GMT'
--- expected
'Wed, 01 Jun 2011 12:34:56 GMT'

=== July
--- input
'Fri, 01 Jul 2011 12:34:56 GMT'
--- expected
'Fri, 01 Jul 2011 12:34:56 GMT'

=== August
--- input
'Mon, 01 Aug 2011 12:34:56 GMT'
--- expected
'Mon, 01 Aug 2011 12:34:56 GMT'

=== September
--- input
'Thu, 01 Sep 2011 12:34:56 GMT'
--- expected
'Thu, 01 Sep 2011 12:34:56 GMT'

=== October
--- input
'Sat, 01 Oct 2011 12:34:56 GMT'
--- expected
'Sat, 01 Oct 2011 12:34:56 GMT'

=== November
--- input
'Tue, 01 Nov 2011 12:34:56 GMT'
--- expected
'Tue, 01 Nov 2011 12:34:56 GMT'

=== December
--- input
'Thu, 01 Dec 2011 12:34:56 GMT'
--- expected
'Thu, 01 Dec 2011 12:34:56 GMT'

=== HTTP standard
--- input
'Sat, 01 Jan 2011 12:34:56 GMT'
--- expected
'Sat, 01 Jan 2011 12:34:56 GMT'

=== RFC850
--- input
'Tuesday, 01-Feb-11 12:34:56 GMT'
--- expected
'Tue, 01 Feb 2011 12:34:56 GMT'

=== Netscape Cookie
--- input
'Tue, 01-Mar-2011 12:34:56 GMT'
--- expected
'Tue, 01 Mar 2011 12:34:56 GMT'

=== ctime
--- input
'Fri Apr 01 12:34:56 GMT 2011'
--- expected
'Fri, 01 Apr 2011 12:34:56 GMT'

=== asctime
--- input
'Sun May 01 12:34:56 2011'
--- expected
'Sun, 01 May 2011 12:34:56 GMT'

=== HTTP Standard without weekday
--- input
'01 Jun 2011 12:34:56 GMT'
--- expected
'Wed, 01 Jun 2011 12:34:56 GMT'

=== RFC850 without weekday
--- input
'01-Jul-11 12:34:56 GMT'
--- expected
'Fri, 01 Jul 2011 12:34:56 GMT'

=== Netscape Cookie without weekday
--- input
'01-Aug-2011 12:34:56 GMT'
--- expected
'Mon, 01 Aug 2011 12:34:56 GMT'

=== ctime without weekday
--- input
'Sep 01 12:34:56 GMT 2011'
--- expected
'Thu, 01 Sep 2011 12:34:56 GMT'

=== asctime without weekday
--- input
'Oct 01 12:34:56 2011'
--- expected
'Sat, 01 Oct 2011 12:34:56 GMT'

=== ISO 8601
--- input
'2011-11-01T12:34:56Z'
--- expected
'Tue, 01 Nov 2011 12:34:56 GMT'

=== common log format
--- input
'01/Dec/2011:12:34:56 +0000'
--- expected
'Thu, 01 Dec 2011 12:34:56 GMT'

