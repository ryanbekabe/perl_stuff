#!/usr/bin/perl
use strict;
use warnings;

# first, create your message
use Email::MIME;
my $message = Email::MIME->create(
  header_str => [
    From    => 'admin@mafaza.xyz',
    To      => 'bekabeipa@gmail.com',
    Subject => 'Bismillah kirim dari Perl 2!',
  ],
  attributes => {
    encoding => 'quoted-printable',
    charset  => 'ISO-8859-1',
  },
  body_str => "Apa pesan ini sampai?!\nPesan kedua 04062020.",
);

# send the message
use Email::Sender::Simple qw(sendmail);
sendmail($message);