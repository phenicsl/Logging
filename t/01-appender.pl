use v6;

BEGIN { @*INC.push('../lib') }

use Test;
plan 5;

use Logging::Appender;
use Logging::SimpleAppender;

# loading Logging::Appender and Logging::SimpleAppender
{
    ok("OK", "Loaded Logging::Appender and Logging::SimpleAppender");
}

# format message
{
    my $appender = Mu.new;
    $appender does Appender;
    ok($appender.format_msg("First Message"), "can format message");
}

# SimpleAppender append message to default error
{    
    my Appender $simple_appender = SimpleAppender.new;
    $simple_appender.append("Second Log Message");
    ok "OK", "can append message to default error output";
}

# unexist path will die
# currently open will die if an unexist path is passed in
{
    dies_ok { my Appender $file_appender = SimpleAppender.new(logging_file => "unexist/path/test.log"); },     
        "passing an unexist path to SimpleAppender::new will die";
}

# log to test.log file
{
    my Str $logging_file = "test.log";
    my Appender $file_appender = SimpleAppender.new(logging_file => $logging_file);
    $file_appender.append("Message to file $logging_file");
    ok "OK", "can append message to $logging_file";
}

