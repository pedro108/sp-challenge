# frozen_string_literal: true

require 'log_parser/counter/page_visits_counter'
require 'log_parser/file_utils/file_reader'
require 'log_parser/presenter/count_result_presenter'
require 'log_parser/validator/log_file_path_validator'

module LogParser
  class Main
    def self.parse(log_file_path:)
      new.parse(log_file_path)
    end

    def initialize(file_reader: LogParser::FileUtils::FileReader.new,
                   log_file_path_validator: LogParser::Validator::LogFilePathValidator.new,
                   page_visits_counter: LogParser::Counter::PageVisitsCounter.new,
                   count_result_presenter: LogParser::Presenter::CountResultPresenter.new)
      @file_reader = file_reader
      @log_file_path_validator = log_file_path_validator
      @page_visits_counter = page_visits_counter
      @count_result_presenter = count_result_presenter
    end

    def parse(log_file_path)
      log_file_path_validator.validate(log_file_path)
      count_result = count_page_visits(log_file_path)
      count_result_presenter.present(count_result)
    end

    private

    def count_page_visits(log_file_path)
      file_reader.read(log_file_path) do |line|
        page, ip = line.split(' ')
        page_visits_counter.add_visit(page: page, ip: ip)
      end

      page_visits_counter.collect
    end

    attr_reader :file_reader, :log_file_path_validator, :page_visits_counter, :count_result_presenter
  end
end
