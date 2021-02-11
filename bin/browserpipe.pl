#!/usr/bin/env perl

use strict;
use warnings;

use File::Temp qw(tempfile);
use Carp qw(croak);

sub run {
    local $SIG{CHILD} = "IGNORE";

    my $pid = fork;
    croak("Ooops.\n") if ( !defined $pid );

    if ( $pid == 0 ) {
        my ( $fh, $file ) = tempfile( "mutt.XXXXX", TMPDIR => 1, UNLINK => 1, SUFFIX => '.html' );
        while (<>) {
            print {$fh} $_;
        }
        close $fh or croak("Ooops.\n");

        system "sensible-browser " . $file;
        sleep 1;
    }

    return 0;
}

exit run();
