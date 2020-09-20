# frozen_string_literal: true

module LogParser
  module FileUtils
    class FileExistenceChecker
      def check(file_path)
        File.exist?(file_path)
      end
    end
  end
end
