require 'log_parser/file_utils/file_reader'

module LogParser
  class Main
    def self.parse(log_file_path:)
      new(file_reader: LogParser::FileUtils::FileReader.new).parse(log_file_path)
    end

    def initialize(file_reader:)
      @file_reader = file_reader
    end

    def parse(log_file_path)
      log_file_path
    end

    private

    attr_reader :file_reader
  end
end
