package PDL::NDBin::Action::Count;
{
  $PDL::NDBin::Action::Count::VERSION = '0.008'; # TRIAL
}
# ABSTRACT: Action for PDL::NDBin that counts elements


use strict;
use warnings;
use PDL::Lite;		# do not import any functions into this namespace
use PDL::NDBin::Actions_PP;


sub new
{
	my $class = shift;
	my $m = shift;
	return bless { m => $m }, $class;
}


sub process
{
	my $self = shift;
	my $iter = shift;
	$self->{out} = PDL->zeroes( PDL::long, $self->{m} ) unless defined $self->{out};
	PDL::NDBin::Actions_PP::_icount_loop( $iter->data, $iter->idx, $self->{out}, $self->{m} );
	# as the plugin processes all bins at once, every variable
	# needs to be visited only once
	$iter->var_active( 0 );
	return $self;
}


sub result
{
	my $self = shift;
	return $self->{out};
}

1;

__END__

=pod

=head1 NAME

PDL::NDBin::Action::Count - Action for PDL::NDBin that counts elements

=head1 VERSION

version 0.008

=head1 DESCRIPTION

This class implements an action for PDL::NDBin.

=head1 METHODS

=head2 new()

	my $instance = PDL::NDBin::Action::Count->new( $N );

Construct an instance for this action. Requires the number of bins $N as input.

=head2 process()

	$instance->process( $iter );

Run the action with the given iterator $iter. This action will compute all bins
during the first call and will subsequently deactivate the variable.

=head2 result()

	my $result = $instance->result;

Return the result of the computation.

=head1 AUTHOR

Edward Baudrez <ebaudrez@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2013 by Edward Baudrez.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
