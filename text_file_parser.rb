##
# AUTHOR: Miles Roberts
# Copyright 2014
#
# Parses a tab-delimited text file and outputs a hash containing the max
# character length for a given attribute.
#
# Usage:
# ~$ ruby text_file_parser.rb PATH_TO_TEXT_FILE
#

require 'celluloid'

module TextFileParser
  class Worker
    include Celluloid
    attr_reader :max, :id
  
    def initialize
      @max = 0
      @id  = ""
    end
  
    def check_record(id, value)
      if value.to_s.length > @max
        @id  = id
        @max = value.to_s.length
      end
    end
  end

  class RecordParser
    include Celluloid
    
    def initialize(input_file)
      @file    = File.open(input_file, "r")
      @columns = set_up_columns
      @workers = set_up_workers
    end
    
    def parse_file
      until @file.eof?
        line = @file.gets.chomp.split("\t")
        id   = line.first
        @columns.each do |c| 
          Actor[c].async.check_record(id, line[@columns.index(c)])
        end
      end
      maximums = @columns.map { |c| [c, [Actor[c].max, Actor[c].id]] }
      return Hash[maximums]
    end
    
    private
    
    def set_up_columns
      @file.gets.chomp.split("\t")
    end
    
    def set_up_workers
      @columns.each { |column| Worker.supervise_as column }
    end
  end
end

if __FILE__ == $0
  begin
    file   = ARGV.first
    parser = TextFileParser::RecordParser.new(file)
    puts parser.parse_file
  rescue Exception => e
    puts e
    puts e.backtrace.join("\n")
  end
end
