# frozen_string_literal: true

require 'log_parser'

RSpec.describe LogParser do
  it 'returns the received log file path' do
    file_path = 'path/to/log/file'

    parsed_file_path = LogParser.parse(log_file_path: file_path)

    expect(parsed_file_path).to eql(file_path)
  end
end
