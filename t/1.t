# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test::More tests => 4;
BEGIN { use_ok('POE::Filter::ParseWords') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

my $test = '"This is just a test" "line" "so there"';

my $filter = POE::Filter::ParseWords->new();

isa_ok( $filter, 'POE::Filter' );
isa_ok( $filter, 'POE::Filter::ParseWords' );

my $results = $filter->get( [ $test ] );

foreach my $result ( @$results ) {
  ok( ( $result->[0] eq 'This is just a test' and $result->[1] eq 'line' and $result->[2] eq 'so there' ) , 'Test Get' );
}
