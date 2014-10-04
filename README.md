# Test Text File Parser

Parses a tab-delimited text file and outputs a hash containing the max character length for a given attribute.

Tested and working in ruby 2.0.0, rubinius 2.2.10, jruby 1.7.16

## Dependencies

Celluloid

## Usage:

~$ git clone https://github.com/MilesRoberts/test_text_file_parser.git
~$ cd test\_text\_file\_parser/
~/test\_text\_file\_parser$ bundle
~/test\_text\_file\_parser$ ruby text\_file\_parser.rb PATH\_TO\_TEXT\_FILE

## Caveats

Not completely optimized for production use. It's theoretically possible that backpressure from worker threads could lead to inaccurate results being returned by script if workers get backed up. The computation being performed by workers is so trivial that this seems unlikely, but it seemed worth noting.

Works just fine in MRI but will probably be faster in jruby/rubinius if run on a multi-core machine.