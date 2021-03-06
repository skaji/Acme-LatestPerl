# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.042.
use strict;
use warnings;

use 5.008005;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "always use the latest perl",
  "AUTHOR" => "Shoichi Kaji <skaji\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Acme-LatestPerl",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008005",
  "NAME" => "Acme::LatestPerl",
  "PREREQ_PM" => {
    "HTTP::Tiny" => 0,
    "version" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => "0.98"
  },
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "HTTP::Tiny" => 0,
  "Test::More" => "0.98",
  "version" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
