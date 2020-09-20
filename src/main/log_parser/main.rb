require 'log_parser/file_utils/file_reader'
require 'log_parser/validator/log_file_path_validator'

module LogParser
  class Main
    def self.parse(log_file_path:)
      new.parse(log_file_path)
    end

    def initialize(file_reader: LogParser::FileUtils::FileReader.new,
                   log_file_path_validator: LogParser::Validator::LogFilePathValidator.new
    )
      @file_reader = file_reader
      @log_file_path_validator = log_file_path_validator
    end

    def parse(log_file_path)
      log_file_path_validator.validate(log_file_path)
      log_file_path
    end

    private

    attr_reader :file_reader, :log_file_path_validator
  end
end
