#!perl -T

use Test::More tests => 4;
use File::Spec;
use File::Find::Rule;
use Image::WordCloud;

my $wc = new Image::WordCloud();

my $num_fonts = scalar(@{ $wc->{'fonts'} });

ok($num_fonts > 0,		'Found font or fonts to use with no options');
diag('Found ' . $num_fonts . ' fonts to use');

my $font_dir = File::Spec->catdir('.', 'share', 'fonts');
ok(-d $font_dir, 			"Found font directory in dist") or diag("Font directory '$font_dir' not found");

my @font_files = File::Find::Rule->new()
	->extras({ untaint => 1})
	->file()
	->name('*.ttf')
	->in($font_dir);

my $font_file = $font_files[0];
ok(-f $font_file,			"Found a font file in the font directory") or diag("Returned font file: '$font_file'");

my $wc = new Image::WordCloud(font_file => $font_file);

is($wc->{'font_file'}, $font_file, 	"Font file option is being set");