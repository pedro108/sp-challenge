# frozen_string_literal: true

require 'log_parser/main'

RSpec.describe LogParser::Main do
  it 'returns the received log file_utils path' do
    file_path = 'path/to/log/file_utils'

    parsed_file_path = LogParser::Main.parse(log_file_path: file_path)

    expect(parsed_file_path).to eql(file_path)
  end
end
