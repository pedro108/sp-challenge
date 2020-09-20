# frozen_string_literal: true

require 'fakefs_helper'
require 'log_parser/file_utils/file_existence_checker'

RSpec.describe LogParser::FileUtils::FileExistenceChecker do
  include FakeFS::SpecHelpers
  subject { described_class.new }

  describe '#check' do
    it 'returns true when a file exists for the given file_path' do
      FakeFS.with_fresh do
        file_path = 'logfile.log'
        File.write(file_path, '', mode: 'w')

        expect(subject.check(file_path)).to be true
      end
    end

    it 'returns false when a file does not exists for the given file_path' do
      file_path = 'non_existent_file.log'

      expect(subject.check(file_path)).to be false
    end
  end
end
