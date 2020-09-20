# frozen_string_literal: true

require 'fakefs_helper'
require 'log_parser/main'

RSpec.describe LogParser::Main do
  include FakeFS::SpecHelpers

  context 'when the file is parsed successfully' do
    it 'returns the received log file_utils path' do
      FakeFS.with_fresh do
        file_path = 'logfile.log'
        content = "/help_page/1 126.318.035.038\n/contact 184.123.665.067"
        File.write(file_path, content, mode: 'w')

        parsed_file_path = LogParser::Main.parse(log_file_path: file_path)

        expect(parsed_file_path).to eql(file_path)
      end
    end
  end

  context 'when no log_file_path parameter is passed' do
    it 'raises an error with a log_file_path parameter is required message' do
      expect {
        LogParser::Main.parse(log_file_path: nil)
      }.to raise_error(RuntimeError, 'A log_file_path parameter is required. e.g. $ log-parser path/to/webserver.log')
    end
  end

  context 'when the file pointed by given log_file_path parameter does not exist' do
    it 'raises an error with a log_file not found message' do
      FakeFS.with_fresh do
        expect {
          LogParser::Main.parse(log_file_path: 'path/to/non_existent_file.log')
        }.to raise_error(RuntimeError, 'No log file found for path path/to/non_existent_file.log')
      end
    end
  end
end
