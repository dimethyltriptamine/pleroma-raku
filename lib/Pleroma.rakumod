#!/usr/bin/rakudo

use JsonC;
use WWW;

unit module Pleroma;

class Pleroma {
	has $.instance;
	has $.client_id;
	has $.client_secret;
	has $.access_token;
	has %.headers;
	
	# Constructor

	method new(Str $instance, Str $client_id, Str $client_secret, Str $access_token) {
		self.bless(:$instance, :$client_id, :$client_secret, :$access_token);
	}
	
	# Method to post a status with a given visibility
	
	method post(Str $status, Str $visibility) {
		my %headers = (Authorization => "Bearer: " ~ self.access_token);
		my $json_str = post("$!instance/api/v1/statuses",%headers, status => $status,
						visibility => $visibility);
		if $json_str {
			return from-json($json_str);
		} else {
			return False;
		}
		
	}
	
	# One should never forget how much fedi searches suck.
	
	method search(Str $type, Str $query, Int $limit) {
		my $json_str = get("$!instance/api/v2/search?q=$query&limit=$limit&type=$type");
		if $json_str {
			return from-json($json_str);
		} else {
			return False;
		}
	}
	
	# User should never call this method
	# (Or at least I don't think there's a good reason to call it)
	
	method get_user_id(Str $user) {
		my $json_str = get("$!instance/api/v1/accounts/$user",
					    Authorization => "Bearer: " ~ self.access_token);
		if $json_str {
			return from-json($json_str){"id"};
		} else {
			return False;
		}
	}

	# Follows a given user
	
	method follow(Str $user) {
		my Str $user_id = self.get_user_id($user);
		my $json_str = post("$!instance/api/v1/accounts/$user_id/follow",
						%(Authorization => "Bearer: " ~ self.access_token));
		if $json_str {
			return True;
		} else {
			return False;
		}		
	}

	# Unfollows a given user
	
	method unfollow(Str $user) {
		my Str $user_id = self.get_user_id($user);
		my $json_str = post("$!instance/api/v1/accounts/$user_id/unfollow",
						%(Authorization => "Bearer: " ~ self.access_token));
		if $json_str {
			return True
		} else {
			return False;
		}		
	}

	# Verifies whether the app works or not
	
	method verify() {
		my $json_str = get("$!instance/api/v1/apps/verify_credentials",Authorization => "Bearer: $!access_token");
		if $json_str {
			return True;
		} else {
			return False;
		}
	}
}
