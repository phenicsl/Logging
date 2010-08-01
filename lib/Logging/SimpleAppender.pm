use v6;

use Logging::Appender;

class SimpleAppender does Appender {
    has $.dst is rw;

    method new($self: Str :$logging_file) {
	my $dst = $*ERR;

	if $logging_file {
	    $dst = open $logging_file, :a;
	    die "Unable to open logging file $logging_file for write" unless $dst;
	}

	return self.bless(self.CREATE(), :dst($dst));
    }

    method append(Str $msg) {
    	my $formatted = self.Appender::format_msg($msg);
        $.dst.say($formatted);
    }
}
