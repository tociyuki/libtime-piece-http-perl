use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Time::Piece::HTTP',
    AUTHOR              => 'MIZUTANI Tociyuki <tociyuki@gmail.com>',
    VERSION_FROM        => 'lib/Time/Piece/HTTP.pm',
    ABSTRACT_FROM       => 'lib/Time/Piece/HTTP.pm',
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::Base' => 0,
        'Time::Piece' => 1.20,
        'Time::Local' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
);
