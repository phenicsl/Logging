use v6;

role Appender {
    my Int $timezone = 8 * 60 * 60;

    method append(Str $msg){ ... };

    method time_str(--> Str) {
	my $dt = DateTime.new(time);
	$dt = $dt.in-timezone($timezone);
	return ~$dt;
    }

    method format_msg(Str $msg --> Str) {
	"[{self.time_str}] " ~ $msg;
    }
}

