# benchmark PDL::NDBin with GMT

use strict;
use warnings;
use blib;				# prefer development version of PDL::NDBin
use Benchmark qw( cmpthese timethese );
use Getopt::Long::Descriptive;
use PDL::NDBin::App;

my( $opt, $usage ) = describe_options(
	'%c %o input_file [ input_file... ]',
	[ 'bins|b=i',       'how many bins to use along every dimension' ],
	#[ 'functions|f=s',  'comma-separated list of functions to benchmark' ],
	[ 'iterations|i=i', 'how many iterations to perform (for better accuracy)' ],
	#[ 'multi|m',        'engage multi-mode to process multiple files' ],
	#[ 'old-flattening', 'use the old (pure-Perl) way of flattening' ],
	[ 'output|o',       'do output actual return value from functions' ],
	#[ 'preload|p=s',    'comma-separated list of data fields to preload before running the benchmark' ],
	[],
	[ 'help', 'show this help screen' ],
);
print( $usage->text ), exit if $opt->help;

my %output;
my $results = timethese( $opt->iterations,
			 { ... } );
print "\nRelative performance:\n";
cmpthese( $results );
print "\n";
