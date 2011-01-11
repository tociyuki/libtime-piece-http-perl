package Time::Piece::HTTP;
use strict;
use warnings;
use Time::Piece ();

use version; our $VERSION = '0.001';
# $Id$
# $Version$

sub import {
    shift; unshift @_, 'Time::Piece';
    goto &Time::Piece::import;
}

package Time::Piece;
use Carp;
use Time::Local;

# don't use strftime, since it is not always that '%a' and '%b' become
# english week and month name respectively under some LC_TIME locales.
# don't use $t->weekname or $t->monname, since they could be changed
# by user.

my @WEEK_NAME = qw(Sun Mon Tue Wed Thu Fri Sat);
my @MONTH_NAME = qw(Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec);
my %MONTH = map { $MONTH_NAME[$_] => $_ } 0 .. 11;

sub http_strftime {
    my($self) = @_;
    my $t = $self;
    if ($self->[$self->c_islocal]) {
        $t = $self->gmtime($self - $self->tzoffset);
    }
    return sprintf '%s, %02d %s %04d %s GMT', $WEEK_NAME[$t->_wday],
        $t->mday, $MONTH_NAME[$t->_mon], $t->year, $t->hms;
}

sub http_cookie_expires {
    my($self) = @_;
    my $t = $self;
    if ($self->[$self->c_islocal]) {
        $t = $self->gmtime($self - $self->tzoffset);
    }
    return sprintf '%s, %02d-%s-%04d %s GMT', $WEEK_NAME[$t->_wday],
        $t->mday, $MONTH_NAME[$t->_mon], $t->year, $t->hms;
}

sub http_strptime {
    my($self, $string) = @_;
    return if ! $string;
    if ($string =~ m{
        \b
        (?: (?:(?:Fri|Mon)(?:day)?|S(?:at(?:urday)?|un(?:day)?)
            |  T(?:ue(?:sday)?|hu(?:rsday)?)|Wed(?:nesday)?
            ),? \x20
        )?
        (?: \x20?
            ([0-9][0-9]?) [\x20/-]
            (A(?:pr|ug)|Dec|Feb|J(?:an|u[nl])|Ma[ry]|Sep|Oct|Nov) [\x20/-]
            ([0-9]{2}(?:[0-9]{2})?) [\x20:]
            ([0-9]{2}):([0-9]{2}):([0-9]{2})
            (?:\x20(?:[A-Z]{3}|[+-][0-9]{4}))?
        |   (A(?:pr|ug)|Dec|Feb|J(?:an|u[nl])|Ma[ry]|Sep|Oct|Nov) \x20\x20?
            ([0-9][0-9]?) \x20
            ([0-9]{2}):([0-9]{2}):([0-9]{2}) \x20
            (?:(?:[A-Z]{3}|[+-][0-9]{4}) \x20)?
            ([0-9]{4})
        |   ([0-9]{4})-([0-9]{2})-([0-9]{2})
            [T\x20]
            ([0-9]{2}):([0-9]{2}):([0-9]{2})
            (?:Z|[+-][0-9]{2}:?[0-9]{2})?
        )\b
    }omsx) {
        my @value = $2 ? ($6, $5, $4, $1, $MONTH{$2}, $3)
                     : $7 ? ($11, $10, $9, $8, $MONTH{$7}, $12)
                     : ($18, $17, $16, $15, $14 - 1, $13);
        if ($value[5] < 100) {
            $value[5] += 100 * (int $self->gmtime->year / 100);
        }
        return $self->gmtime(timegm(@value));
    }
    croak 'Error parsing time';
}

1;

__END__

=pod

=head1 NAME

Time::Piece::HTTP - Excludes HTTP-specific methods to Time::Piece.

=head1 VERSION

0.001

=head1 SYNOPSIS

    use Time::Piece::HTTP;
    
    my $time = localtime;
    my $time = gmtime;
    my $time = gmtime->http_strptime($env->{HTTP_IF_MODIFIED_SINCE});
    print $time->http_strftime;
    print $time->http_cookie_expires;

=head1 DESCRIPTION

This module adds a few HTTP-specific methods to Time::Piece package.
You might use this instead of Time::Piece itself.
The methods in this module corresponds to L<HTTP::Date>'s one. 

=head1 METHODS

=over

=item C< http_strftime >

Returns a date-time string for HTTP standard headers.
The given receiver may has a localtime rather than a gmtime.
If the receiver has a localtime, an autogenerated gmtime
instance from it will be used. 

The format is fixed in '%a, %d %b %Y %H:%M:%S GMT' under LC_TIME=C.

This method corresponds to L<HTTP::Date>'s C<time2str> function.

=item C< http_cookie_expires >

Returns a date-time string for HTTP Set-Cookie headers
The given receiver may has a localtime rather than a gmtime.
If the receiver has a localtime, an autogenerated gmtime
instance from it will be used. 

The format is fixed in '%a, %d-%b-%Y %H:%M:%S GMT' under LC_TIME=C.

=item C< http_strptime($string) >

Given a datetime value in HTTP header, such as Last-Modified-Since,
this constructor returns a new C<< Time::Piece->gmtime >> instance.
If the value is lost, it will return undef.
All of the zone informations in the given string are ignored.

The method is able to parse the following formats:

    "Mon, 10 Jan 2011 13:23:28 GMT"     -- HTTP Standard
    "Monday, 10-Jan-11 13:23:28 GMT"    -- RFC850
    "Mon, 10-Jan-2011 13:23:28 GMT"     -- Netscape Cookie
    "Mon Jan 10 13:23:28 GMT 2011"      -- ctime(3)
    "Mon Jan 10 13:23:28 2011"          -- ANSI C asctime()

    "10 Jan 2011 13:23:28 GMT"          -- HTTP Standard without weekday
    "10-Jan-11 13:23:28 GMT"            -- RFC850 without weekday
    "10-Jan-2011 13:23:28 GMT"          -- Netscape Cookie without weekday
    "Jan 10 13:23:28 GMT 2011"          -- ctime(3) without weekday
    "Jan 10 13:23:28 2011"              -- ANSI C asctime() without weekday

    "2011-01-10T13:23:28Z"              -- ISO 8601
    "10/Jan/2011:13:23:28 +0000"        -- common log format

This method corresponds to L<HTTP::Date>'s C<str2time> function.

=back

=head1 DEPENDENCIES

L<Time::Piece>, L<Time::Local>

=head1 SEE ALSO

L<HTTP::Date>, L<Time::Piece>, L<Time::Piece::MySQL>

=head1 AUTHOR

MIZUTANI Tociyuki  C<< <tociyuki@gmail.com> >>

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2010, MIZUTANI Tociyuki C<< <tociyuki@gmail.com> >>.
All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=cut
