package Hudsongrafik::Uploader;

use strict;
use warnings;

use Apache2::RequestRec ();
use Apache2::RequestIO ();
use Apache2::Request;

use Apache2::Const -compile => qw(OK);

sub handler {
    my $r = Apache2::Request->new(
      shift,
      POST_MAX => 10 * 1024 * 1024, # in bytes, so 10M
      DISABLE_UPLOADS => 0
    );

    $r->content_type('text/plain');
    print "mod_perl 2.0 rocks!\n";

    foreach my $upload ($r->upload) {
      my $filename  = $upload->filename;
      my $filehandle = $upload->fh;
      my $size    = $upload->size;

      $r->print("You sent me a file named $filename, $size bytes<br>");
    }

    return Apache2::Const::OK;
}
1;
