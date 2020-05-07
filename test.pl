#!/usr/bin/env perl
use strict;
use warnings;
use feature qw( say );
use Data::Printer;
use AW::DB::Reader;
use Net::Works::Address;


my $reader = AW::DB::Reader->new( file => './IP_city_single_WGS84_awdb.awdb' );
my $record = $reader->record_for_address('166.111.4.100');
say np $record;
