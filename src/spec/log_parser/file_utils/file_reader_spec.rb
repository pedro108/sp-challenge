# frozen_string_literal: true

require 'pp'
require 'fakefs/safe'
require 'fakefs/spec_helpers'
require 'log_parser/file_utils/file_reader'

RSpec.describe LogParser::FileUtils::FileReader do
  include FakeFS::SpecHelpers
  subject { LogParser::FileUtils::FileReader.new }

  describe '#read' do
    context 'when the file_utils is read successfully' do
      it 'executes the given block for each line read on the file_utils' do
        FakeFS.with_fresh do
          file_path = 'logfile.log'
          content = "/help_page/1 126.318.035.038\n/contact 184.123.665.067"
          File.write(file_path, content, mode: 'w')

          expected_lines = StringIO.new
          subject.read(file_path) do |line|
            expected_lines.write("Line read: #{line}.")
          end

          expect(expected_lines.string).to eql("Line read: /help_page/1 126.318.035.038.Line read: /contact 184.123.665.067.")
        end
      end
    end

    context 'when a file_utils is not found for the given file_utils path' do
      it 'raises an error' do
        FakeFS.with_fresh do
          file_path = 'logfile.log'

          expect { subject.read(file_path) }.to raise_error(Errno::ENOENT)
        end
      end
    end
  end
end
