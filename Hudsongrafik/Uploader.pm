package Hudsongrafik::Uploader;

use strict;
use warnings;

use Apache2::RequestRec ();
use Apache2::RequestIO ();
use Apache2::Request ();
use Apache2::Upload ();

use Apache2::Const -compile => qw(OK);

sub handler {
    my $r = shift;
    my $req = Apache2::Request->new($r,
      POST_MAX => 10 * 1024 * 1024,
      DISABLE_UPLOADS => 0
    );

    $req->content_type('text/plain');
    print "test!\n";

    # scoop the files
    my %files = {};
    foreach my $upload ($req->upload()) {
        my %file = {};

        $file{'filename'} = $req->upload($upload)->filename;
        $file{'size'}     = $req->upload($upload)->size;
        $file{`content`}  = '';
        $req->upload($upload)->slurp($file{`content`});

        $r->print("You sent me a file named $file{'filename'}, $file{'size'} bytes on field: $upload");
        $files{$file{'filename'}} = %file;

        my $openFail = 0;
        open(OUT, '>/var/www/html/main/hudsonGrafik/data') || do {
            $r->print("failed to open outfile: " . $!);
            $openFail = 1;
        }
        if ($openFail == 0){
            print OUT $file{'content'} . "\n";
            close(OUT);
        }
    }

    ## LOH 2/15/21 @ 2327
    ## handle whatever files sent by name
    ## just blindly post at this thing :-)

    return Apache2::Const::OK;
}
1;
