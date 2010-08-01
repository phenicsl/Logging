use v6;

use Logging::Appender;

class Logger {
    our Int ($DEBUG ,$INFO, $WARN, $ERROR, $FATAL) =  0 .. *;
	
    our %level_repr = ( $DEBUG => "DEBUG",
			$INFO => "INFO",
			$WARN => "WARN",
			$ERROR => "ERROR",
			$FATAL => "FATAL" );

    method DEBUG( )  { $DEBUG }
    method INFO() { $INFO }
    method WARN() { $WARN }
    method ERROR() { $ERROR }
    method FATAL() { $FATAL }

    has Int $.level is rw = $INFO;
    has Appender @appenders;

    method new(:$level = Logger.INFO) {
	return self.bless(self.CREATE(), :$level);
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
