package Acme::LatestPerl;
use strict;
use warnings;
use HTTP::Tiny;
use version;

our $VERSION = '0.01';

sub latest {
    my $url = "http://perl5.git.perl.org/perl.git/tags";
    my $res = HTTP::Tiny->new->get($url);
    my @version;
    if ($res->{success}) {
        for my $part (split m{\Q</tr>\E}, $res->{content}) {
            if ($part =~ m{
                    \Q<i>\E  (?<ago>[^<]+)  \Q</i>\E
                    .*
                    \Q>\E v(?<version>5\.[\d.RC-]+)
                }xsm
            ) {
                my %match = %+;
                if ($match{version} !~ /RC/) {
                    push @version, [$match{version}, $match{ago}];
                }
            }
        }
    }
    (my $latest, ) =
        map  { $_->[1] }
        sort { $b->[0] <=> $a->[0] }
        map  { [version->parse($_->[0]), $_] }
        grep { $_->[0] =~ /^5\.(\d+)/ && $1 % 2 == 0 }
        @version
    ;
    $latest;
}

sub import {
    my $latest = latest();
    return unless $latest->[0] > version->parse($^V);
    die "\e[1;31m"
        . "Latest perl is v$latest->[0] (released $latest->[1]), "
        . "but you are using $^V.\n"
        . "You should upgrade it now!"
        . "\e[m" . "\n";
}

1;
__END__

=encoding utf-8

=head1 NAME

Acme::LatestPerl - always use the latest perl

=head1 SYNOPSIS

  > /usr/bin/perl -Ilib -MAcme::LatestPerl -e1
  Latest perl is v5.22.1 (released 10 days ago), but you are using v5.18.2.
  You should upgrade it now!
  BEGIN failed--compilation aborted.

=head1 DESCRIPTION

We should always use the latest perl.

=head1 COPYRIGHT AND LICENSE

Copyright 2015 Shoichi Kaji <skaji@cpan.org>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
