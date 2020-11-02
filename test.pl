#!/usr/bin/env perl
use strict;
use warnings;
use feature qw( say );
use Data::Printer;
use AW::DB::Reader;
use Net::Works::Address;
use Encode;
use JSON;
use Data::Dumper;


my $reader = AW::DB::Reader->new( file => '../IP_city_single_BD09_WGS84_ipv6_awdb.awdb' );
my $record = $reader->record_for_address('166.111.4.100');
say @$record{'areacode'};
say @$record{'continent'};
say np $record;
