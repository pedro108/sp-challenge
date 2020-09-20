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

      private

      attr_reader :unique_ips
    end
  end
end
