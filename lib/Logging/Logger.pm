use v6;

use Logging::Appender;
use Logging::SimpleAppender;

class Logger {
    # enumeration is not fully implemented in Rakudo Star. so use Int value instead.
    our Int ($DEBUG ,$INFO, $WARN, $ERROR, $FATAL) =  0 .. *;
	
    our %level_repr = ( $DEBUG => "DEBUG",
			$INFO => "INFO",
			$WARN => "WARN",
			$ERROR => "ERROR",
			$FATAL => "FATAL" );

    # provide access subroutine, so we can use Logger.DEBUG rather than Logger.$DEBUG
    method DEBUG( )  { $DEBUG }
    method INFO() { $INFO }
    method WARN() { $WARN }
    method ERROR() { $ERROR }
    method FATAL() { $FATAL }

    has Int $.level is rw = $INFO;
    has Appender @appenders;	# appender array

    method new(:$level = Logger.INFO) {
	return self.bless(self.CREATE(), :$level);
    }
    
    method simple_init(:$level = Logger.INFO) {
	my $logger = self.bless(self.CREATE(), :$level);
	my $appender = SimpleAppender.new;
	$logger.add_appender($appender);
	$logger;
    }

    method add_appender(Appender $appender) {
	push @appenders, $appender;
    }

    method log(Int $level, Str $msg) {
	if $level >= $.level {
	    .append("%level_repr{$level}: " ~ $msg) for @appenders;
	}
    }

    method debug(Str $msg) {
	self.log(Logger.DEBUG, $msg);
    }

    method info(Str $msg) {
	self.log(Logger.INFO, $msg);
    }

    method warn(Str $msg) {
	self.log(Logger.WARN, $msg);
    }

    method error(Str $msg) {
	self.log(Logger.ERROR, $msg);
    }

    method fatal(Str $msg) {
	self.log(Logger.FATAL, $msg);
    }
}

=begin pod
=head1 NAME

Logging::Logger - Logging with logging level and appender support

=head1 SYNOPSIS

    use Logging::Logger;
    use Logging::Appender;
    use Logging::SimpleAppender;

    # create logger and add appender
    my Logger $logger .= new(Logger.DEBUG);
    my Appender $stderr_appender = SimpleAppender.new;
    my Appender $file_appender = SimpleAppender.new("/path/to/logfile");
    $logger.add_appender($stderr_appender);
    $logger.add_appender($file_appender);

    # log message
    $logger.debug("Debug Message");
    $logger.warn("Warn Message");
    $logger.error("Error Message");
    

=head1 DESCRIPTION

Logging::Logger provides simple logging functionality with logging level support
and appender support. 

=head2 Logging Levels
Logging::Logger supports 5 kinds of logging levels:
=item DEBUG
=item INFO
=item WARN
=item ERROR
=item FATAL

=head2 

Logging Appender Logger support Appender that does the Logging::Appender role. A
Logging::SimpleAppender is provided to support simple log output to a file or
standard error.

=end pod


