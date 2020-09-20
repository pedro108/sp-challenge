# frozen_string_literal: true

module LogParser
  module FileUtils
    class FileReader
      def read(file_path)
        File.open(file_path, 'r').each_line do |line|
          yield line.gsub("\n", '')
        end
      end
    end
  end
end
