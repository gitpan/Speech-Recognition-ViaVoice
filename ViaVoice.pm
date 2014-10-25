package Speech::Recognition::ViaVoice;

use 5.006;
use strict;
use warnings;

require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Speech::Recognition::ViaVoice ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	connectEngine defineVocab startListening recognize getWord getScore stopListening disconnectEngine
);
our $VERSION = '0.01';

bootstrap Speech::Recognition::ViaVoice $VERSION;

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

Speech::Recognition::ViaVoice - Perl wrappers for IBM's ViaVoice speech recognition library.

=head1 SYNOPSIS

use Speech::Recognition::ViaVoice;

$| = 1;

if (0 == connectEngine) {

    if ( 0 == defineVocab('myTestVocab', ['hello','world','quit']) ) {
        print 'please say "hello", "world", or "quit" at each prompt...', "\n";

        while (0 == startListening) {
            print "speak> ";
            if (0 == recognize) {
                my ($s, $score) = (getWord, getScore);
                if (defined($s)) {
                    printf "%s, score=%d\n", $s, $score;
                    if ($s eq 'quit') {
                        exit 0;
                    }
                } else {
                    printf "not recognized!\n";
                }
            }
            stopListening;
        }
    }

    disconnectEngine;
}

=head1 DESCRIPTION

This module provides very basic use of IBM's ViaVoice library in perl.
It allows its user to pass a list of speech commands for recognition
in a perl list, connect to the engine, and request recognized spoken
words.  The most notable feature missing from the current version is
the ability to select different ViaVoice users.  I plan to add this
functionality shortly, but for now you must use the default user.

Consult the ViaVoice documentation for ViaVoice setup.  I think for
most, you mostly just need to run vvstartuserguru, which requires a
java runtime environment to run.  Results will be better if you take
the time to do a little training to your own voice in this utility.

You can use this perl module for reconition of words from IBM's vocab
dictionary for your chosen locale without further preparation.  To
recognize words not available in the dictionary or to recognize
phrases, you need to create a file with phonetic spellings for use by
the provided script pronunciations.pl (installed in /usr/local/bin by
default).  This utility reads a text file whose name is supplied as
its sole argument.  The file should contain lines with two fields
separated by a tab character:

	Deborah --- TAB -->D EH B OW R AX
	Deborah --- TAB -->D EH B AXR R AX
	Axl Rose -- TAB -->AE K S AX L  R OW Z

The text on the left is the word or phrase to be recognized, and the
text on the right is a phonetic spelling of the format specified in
the ViaVoice docs (section 3 of /usr/doc/ViaVoice/bpreadme.txt in my
installation).  As in the example, a word or phrase might have more
than one common pronunciation.  You can provide all of them, one on
each line.

pronunciations.pl will most likely require super user privileges to
write its output to files in the ViaVoice lib directory:

	/usr/lib/ViaVoice/vocabs/langs/En_US/pools/


=head1 INSTALLATION

To install this module, first change the line in Makefile.PL that looks
like the following to reflect your locale:

    'DEFINE'		=> '-DLOCALE=\"En_US\"',

Then, type the following:

   perl Makefile.PL
   make
   make test
   make install

Note: "make test" will prompt you to say a word and attempt to recognize
it.  It will fail unless you have IBM ViaVoice setup and your microphone
connected and ready to go.

=head1 DEPENDENCIES

This module requires IBM's ViaVoice to run.

=head1 COPYRIGHT AND LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Richard Kilgore, rkilgore@kilgoreSolutions.com

=head1 SEE ALSO

L<perl>.

=cut
