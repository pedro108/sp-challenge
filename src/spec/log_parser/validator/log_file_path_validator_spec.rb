# frozen_string_literal: true

require 'log_parser/file_utils/file_existence_checker'
require 'log_parser/validator/log_file_path_validator'

RSpec.describe LogParser::Validator::LogFilePathValidator do
  let(:file_existence_checker) { instance_double(LogParser::FileUtils::FileExistenceChecker) }
  subject { described_class.new(file_existence_checker: file_existence_checker) }

  describe '#validate' do
    context 'when the provided log_file_path is valid' do
      it 'do not raise an error' do
        log_file_path = 'path/to/logfile.log'
        allow(file_existence_checker).to receive(:check).with(log_file_path).and_return(true)

        expect { subject.validate(log_file_path) }.to_not raise_error
      end
    end

    context 'when the provided log_file_path is nil' do
      it 'raises a log_file_path required error' do
        expect do
          subject.validate(nil)
        end.to raise_error(
          RuntimeError,
          'A log_file_path parameter is required. e.g. $ log-parser path/to/webserver.log'
        )
      end
    end

    context 'when the provided log_file_path is empty' do
      it 'raises a log_file_path required error' do
        expect do
          subject.validate('')
        end.to raise_error(
          RuntimeError,
          'A log_file_path parameter is required. e.g. $ log-parser path/to/webserver.log'
        )
      end
    end

    context 'when the provided log_file_path points to an inexistent file' do
      it 'raises a log file not found error' do
        log_file_path = 'path/to/logfile.log'
        allow(file_existence_checker).to receive(:check).with(log_file_path).and_return(false)

        expect do
          subject.validate(log_file_path)
        end.to raise_error("No log file found for path #{log_file_path}")
      end
    end
  end
end
