#!/usr/bin/rakudo

use Test;
use Pleroma;

my $pl = Pleroma::Pleroma.new("https://pl.qorg11.net",
						"DFmf6sLm6K6wVRMsb4PohQUCtH5Kzim59lXRQV-HH0s",
						"HvG8iJEB8dlPqWtn84QvMePS2lA7ETc-M_CwTDOWgk0",
						"GaX9NTVOyR_XSLxiCzuejvnS1f3x5MumRAEsy1UBUrs"
					    );

isnt $pl.post("hello","direct"), False, "Posting a status.";
isnt $pl.search("statuses","cofe",1), False, "Making a search.";
isnt $pl.follow("lain@lain.com"), False, "Following an user";
# sorry lain
isnt $pl.unfollow("lain@lain.com"), False, "Unfollowing an user.";
								    
done-testing;
