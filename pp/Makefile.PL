use strict;
use warnings;
use PDL::Core::Dev;
use ExtUtils::MakeMaker;

my $package = [ "actions.pd", 'Actions_PP', 'PDL::NDBin::Actions_PP' ];
my %args = (
	pdlpp_stdargs( $package ),
	VERSION => '0.016',
);
WriteMakefile( %args );
sub MY::postamble { pdlpp_postamble( $package ) }
