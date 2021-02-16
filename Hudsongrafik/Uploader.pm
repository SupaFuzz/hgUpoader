package Hudsongrafik::Uploader;

use strict;
use warnings;

use Apache2::RequestRec ();
use Apache2::RequestIO ();
use Apache2::Request;
use Apache2::Upload;

use Apache2::Const -compile => qw(OK);

sub handler {
    my $r = shift;

    $r->content_type('text/plain');
    print "test!\n";

    foreach my $upload ($r->upload) {
     my $filename  = $upload->filename;
     my $size    = $upload->size;

     $r->print("You sent me a file named $filename, $size bytes<br>");
     
    }
    return Apache2::Const::OK;
}
1;
