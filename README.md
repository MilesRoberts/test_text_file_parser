# Test Text File Parser

Parses a tab-delimited text file and outputs a hash containing the max character length for a given attribute. Attribute names are taken from the first line of the file.

Tested and working in ruby 2.0, ruby 2.1, rubinius 2.2.10, and jruby 1.7.16

## Dependencies

Celluloid

## Usage:

    ~$ git clone https://github.com/MilesRoberts/test_text_file_parser.git
    ~$ cd test_text_file_parser/
    ~/test_text_file_parser$ bundle
    ~/test_text_file_parser$ ruby text_file_parser.rb PATH_TO_TEXT_FILE

## Caveats

Not completely optimized for production use. It's theoretically possible that backpressure from worker threads could lead to inaccurate results being returned by the script if workers get backed up. The computation being performed by the worker threads is so trivial that this seems unlikely, but it seemed worth noting.

Works just fine in MRI but will probably be faster with the real file in jruby/rubinius if run on a multi-core machine.