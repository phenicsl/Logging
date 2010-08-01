use v6;

BEGIN { @*INC.push('../lib'); }

use Logging::Logger;
use Logging::SimpleAppender;
use Logging::Appender;

say "load ok";
# logger routine test
{
    my Logger $logger .= new(level => Logger.DEBUG);
    my SimpleAppender $simple_appender .= new;
    my SimpleAppender $file_appender .= new(logging_file => "test.log");
    $logger.add_appender($simple_appender);
    $logger.add_appender($file_appender);
    $logger.debug("DEBUG message");
    $logger.info("INFO message");
    $logger.warn("WARN message");
    $logger.error("ERROR message");
    $logger.fatal("FATAL message");
}

# logger logging level test
{
    my Logger $logger .= new;
    $logger.level = Logger.ERROR;
    my SimpleAppender $simple_appender .= new;
    $logger.add_appender($simple_appender);
    $logger.info("INFO message, should not appear");
    $logger.error("ERROR message");
    $logger.fatal("FATAL message");
}
