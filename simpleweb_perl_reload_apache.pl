#!/usr/bin/perl
# <?php
# shell_exec("curl http://51.79.159.38:8080/subdomain");
# ?>
{
package MyWebServer;
use HTTP::Server::Simple::CGI;
use base qw(HTTP::Server::Simple::CGI);
my %dispatch = (
    '/hello' => \&resp_hello,
    '/subdomain' => \&resp_subdomain,
     # ...
);
sub handle_request {
    my $self = shift;
    my $cgi  = shift;
    my $path = $cgi->path_info();
    my $handler = $dispatch{$path};
    if (ref($handler) eq "CODE") {
        print "HTTP/1.0 200 OK\r\n";
        $handler->($cgi);
    } else {
        print "HTTP/1.0 404 Not found\r\n";
        print $cgi->header,
              $cgi->start_html('Not found'),
              $cgi->h1('Not found'),
              $cgi->end_html;
    }
}
sub resp_hello {
    my $cgi  = shift;   # CGI.pm object
    return if !ref $cgi;
     
    my $who = $cgi->param('name');
     
    print $cgi->header,
          $cgi->start_html("Hello"),
          $cgi->h1("Hello $who!"),
          $cgi->end_html;
	  #`systemctl reload apache2`;
}
sub resp_subdomain {
    my $cgi  = shift;
    return if !ref $cgi;

    my $who = $cgi->param('name');

    print $cgi->header,
          $cgi->start_html("Bismillah"),
          $cgi->h1("Hello $who!\n Reload Apache!"),
          $cgi->end_html;
          `systemctl reload apache2`;
}
}
# start the server on port 8080
my $pid = MyWebServer->new(8080)->background();
print "Use 'kill $pid' to stop server.\n";