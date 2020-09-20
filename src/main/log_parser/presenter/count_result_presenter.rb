# frozen_string_literal: true

require 'terminal-table'

module LogParser
  module Presenter
    class CountResultPresenter
      def present(count_result)
        [
          present_for(count_result, %w[Page Visits], :page_visits),
          present_for(count_result, ['Page', 'Unique Views'], :unique_visits)
        ]
      end

      private

      def present_for(count_result, headings, counter_field)
        Terminal::Table.new(
          headings: headings,
          rows: count_result.sort_by { |r| r[counter_field] }.reverse!.map { |r| [r[:page], r[counter_field]] }
        )
      end
    end
  end
end
