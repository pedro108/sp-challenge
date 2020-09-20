# frozen_string_literal: true

require 'log_parser/counter/page_visits'

module LogParser
  module Counter
    class PageVisitsCounter
      def initialize
        @result = {}
      end

      def add_visit(page:, ip:)
        create_result_for(page) unless result_exists_for(page)
        page_result = result[page]

        page_result.add_visit(ip)
      end

      def collect
        collected_result = collect_result
        @result = {}

        collected_result
      end

      private

      def create_result_for(page)
        result[page] = PageVisits.new
      end

      def result_exists_for(page)
        !result[page].nil?
      end

      def collect_result
        result.keys.reduce([]) do |acc, page|
          acc.concat([{
                       page: page,
                       page_visits: result[page].visits,
                       unique_visits: result[page].unique_visits
                     }])
        end
      end

      attr_reader :result
    end
  end
end
