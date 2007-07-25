# Author Chris "BinGOs" Williams
#
# This module may be used, modified, and distributed under the same
# terms as Perl itself. Please see the license that came with your Perl
# distribution for details.
#

package POE::Filter::ParseWords;

use strict;
use vars qw($VERSION);
use base qw(POE::Filter);
use Text::ParseWords;

$VERSION = '0.02';

sub new {
  my $class = shift;
  my %opts = @_;
  $opts{lc $_} = delete $opts{$_} for keys %opts;
  $opts{keep} = 0 unless $opts{keep};
  $opts{delim} = '\s+' unless $opts{delim};
  $opts{BUFFER} = [];
  bless \%opts, $class;
}

sub get {
  my ($self, $raw) = @_;
  my $events = [];
  push @$events, [ parse_line( $self->{delim}, $self->{keep}, $_ ) ] for @$raw;
  return $events;
}

sub get_one_start {
  my ($self, $raw) = @_;
  push @{ $self->{BUFFER} }, $_ for @$raw;
}

sub get_one {
  my $self = shift;
  my $events = [];
  my $event = shift @{ $self->{BUFFER} };
  push @$events, [ parse_line( $self->{delim}, $self->{keep}, $event ) ] if defined $event;
  return $events;
}

sub put {
  warn "PUT is unimplemented\n";
  return;
}

1;
__END__

=head1 NAME

POE::Filter::ParseWords - A POE-based parser to parse text into an array of tokens.

=head1 SYNOPSIS

    use POE::Filter::ParseWords;

    my $filter = POE::Filter::ParseWords->new();
    my $arrayref = $filter->get( [ $line ] );

=head1 DESCRIPTION

POE::Filter::ParseWords provides a convenient way to parse text into an array of tokens. It is
a wrapper for the module L<Text::ParseWords>.

A more comprehensive demonstration of the use to which this module can be
put to is in the examples/ directory of this distribution.

=head1 CONSTRUCTOR

=over

=item new

Creates a new POE::Filter::ParseWords object. Takes two optional arguments:

  'delim', specify a delimiter, default is '\s+';
  'keep', specify whether other characters are kept or not, default is false;

=back

=head1 METHODS

=over

=item get

=item get_one_start

=item get_one

Takes an arrayref which is contains lines of text. Returns an arrayref of lists of
tokenised output.

=item put

This is not implemented.

=back

=head1 AUTHOR

Chris "BinGOs" Williams

=head1 SEE ALSO

L<POE>

L<Text::ParseWords>

L<POE::Filter>

L<POE::Filter::Line>

L<POE::Filter::Stackable>

=cut
