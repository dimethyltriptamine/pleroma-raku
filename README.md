[![Actions Status](https://github.com/dimethyltriptamine/pleroma-raku/workflows/test/badge.svg)](https://github.com/dimethyltriptamine/pleroma-raku/actions)

# Pleroma for raku

A class for Raku which allows you to interact with Pleroma's API

## Synopsis

~~~raku
my $pl = Pleroma::Pleroma.new($instance,$client_id,$client_secret,$access_token);
$pl.post("Hello from Raku!");
$pl.follow("qorg@pl.qorg11.net");
~~~



