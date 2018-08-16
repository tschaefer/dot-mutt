#!/usr/bin/env perl

use strict;
use warnings;

use File::Temp qw(tempfile);

sub run {
    my ($fh, $file) = tempfile("mutt.XXXXX", TMPDIR => 1, UNLINK => 1);
    while(<>) {
        print $fh $_;
    }
    close $fh;

    system("firefox", $file);
    sleep 5;

    return 0;
}

exit run();
