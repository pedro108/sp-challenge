# frozen_string_literal: true

require 'set'

module LogParser
  module Counter
    class PageVisits
      attr_reader :visits

      def initialize
        @visits = 0
        @unique_ips = Set.new
      end

      def add_visit(ip)
        @visits += 1
        @unique_ips << ip
      end

      def unique_visits
        @unique_ips.length
      end

      def average_visits
        return 0 if unique_visits.eql? 0

        visits / unique_visits
      end

      private

      attr_reader :unique_ips
    end
  end
end
