# frozen_string_literal: true

require 'fakefs_helper'
require 'log_parser/main'

RSpec.describe LogParser::Main do
  include FakeFS::SpecHelpers

  context 'when the file is parsed successfully' do
    let(:content) { "/help_page/1 126.318.035.038\n/contact 184.123.665.067\n/home 184.123.665.067\n/about/2 444.701.448.104\n/help_page/1 929.398.951.889\n/index 444.701.448.104\n/help_page/1 722.247.931.582\n/about 061.945.150.735\n/help_page/1 646.865.545.408\n/home 235.313.352.950\n/contact 184.123.665.067\n/help_page/1 543.910.244.929\n/home 316.433.849.805\n/about/2 444.701.448.104\n/contact 543.910.244.929\n/about 126.318.035.038\n/about/2 836.973.694.403\n/index 316.433.849.805\n/index 802.683.925.780\n/help_page/1 929.398.951.889" }

    it 'returns a sorted table with the page views count' do
      FakeFS.with_fresh do
        file_path = 'logfile.log'
        File.write(file_path, content, mode: 'w')

        parsed_log = LogParser::Main.parse(log_file_path: file_path)

        expect(parsed_log[0].to_s).to eql(
                                        "+--------------+--------+\n"\
          "| Page         | Visits |\n"\
          "+--------------+--------+\n"\
          "| /help_page/1 | 6      |\n"\
          "| /index       | 3      |\n"\
          "| /about/2     | 3      |\n"\
          "| /home        | 3      |\n"\
          "| /contact     | 3      |\n"\
          "| /about       | 2      |\n"\
          "+--------------+--------+"
        )
      end
    end

    it 'returns a sorted table with the unique views count' do
      FakeFS.with_fresh do
        file_path = 'logfile.log'
        File.write(file_path, content, mode: 'w')

        parsed_log = LogParser::Main.parse(log_file_path: file_path)

        expect(parsed_log[1].to_s).to eql(
          "+--------------+--------------+\n"\
          "| Page         | Unique Views |\n"\
          "+--------------+--------------+\n"\
          "| /help_page/1 | 5            |\n"\
          "| /index       | 3            |\n"\
          "| /home        | 3            |\n"\
          "| /about       | 2            |\n"\
          "| /about/2     | 2            |\n"\
          "| /contact     | 2            |\n"\
          "+--------------+--------------+"
        )
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
