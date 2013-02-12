package PDL::NDBin::Action::CodeRef;
{
  $PDL::NDBin::Action::CodeRef::VERSION = '0.008'; # TRIAL
}
# ABSTRACT: Action for PDL::NDBin that calls user sub


use strict;
use warnings;
use PDL::Lite;		# do not import any functions into this namespace


sub new
{
	my $class = shift;
	my $m = shift;
	my $coderef = shift;
	return bless { m => $m, coderef => $coderef }, $class;
}


sub process
{
	my $self = shift;
	my $iter = shift;
	$self->{out} = PDL->zeroes( $iter->data->type, $self->{m} )->setbadif( 1 ) unless defined $self->{out};
	my $value = $self->{coderef}->( $iter );
	if( defined $value ) { $self->{out}->set( $iter->bin, $value ) }
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

PDL::NDBin::Action::CodeRef - Action for PDL::NDBin that calls user sub

=head1 VERSION

version 0.008

=head1 DESCRIPTION

This class implements a special action for PDL::NDBin that is actually a
wrapper around a user-defined function. This class exists just to fit
user-defined subroutines in the same framework as the other actions, which are
defined by classes (so that the user doesn't have to define a full-blown class
just to implement an action).

=head1 METHODS

=head2 new()

	my $instance = PDL::NDBin::Action::CodeRef->new( $N, $coderef );

Construct an instance for this action. Requires two parameters:

=over 4

=item $N

The number of bins.

=item $coderef

A reference to an anonymous or named subroutine that implements the real action.

=back

=head2 process()

	$instance->process( $iter );

Run the action with the given iterator $iter. This action cannot assume that
all bins can be computed at once, and will not deactivate the variable. This
means that process() will need to be called for every bin.

Note that process() does not trap exceptions. The user-supplied subroutine
should be wrapped in an I<eval> block if the rest of the code should be
protected from exceptions raised inside the subroutine.

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
