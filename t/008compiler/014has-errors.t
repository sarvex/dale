#!/usr/bin/perl

use warnings;
use strict;
$ENV{"DALE_TEST_ARGS"} ||= "";
my $test_dir = $ENV{"DALE_TEST_DIR"} || ".";
$ENV{PATH} .= ":.";

use Data::Dumper;
use Test::More tests => 3;

my @res = `dalec $ENV{"DALE_TEST_ARGS"} $test_dir/t/src/has-errors.dt -o has-errors  `;
is(@res, 0, 'No compilation errors');

@res = `./has-errors`;
is($?, 0, 'Program executed successfully');

chomp for @res;

is_deeply(\@res, [
'Function does-not-exist does not exist',
'Function + int int exists',
'Function with special characters does not exist',
'Function further down the tree does not exist',
], 'Got expected results');

`rm has-errors`;

1;
