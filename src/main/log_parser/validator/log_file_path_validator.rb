# frozen_string_literal: true

require 'log_parser/file_utils/file_existence_checker'

module LogParser
  module Validator
    class LogFilePathValidator
      def initialize(file_existence_checker: LogParser::FileUtils::FileExistenceChecker.new)
        @file_existence_checker = file_existence_checker
      end

      def validate(log_file_path)
        validate_not_blank(log_file_path)
        validate_file_exists(log_file_path)
      end

      private

      def validate_not_blank(log_file_path)
        if log_file_path.nil? || log_file_path.empty?
          raise 'A log_file_path parameter is required. e.g. $ log-parser path/to/webserver.log'
        end
      end

      def validate_file_exists(log_file_path)
        unless file_existence_checker.check(log_file_path)
          raise "No log file found for path #{log_file_path}"
        end
      end

      attr_reader :file_existence_checker
    end
  end
end
