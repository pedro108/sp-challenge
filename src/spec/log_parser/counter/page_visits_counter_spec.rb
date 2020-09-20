# frozen_string_literal: true

require 'log_parser/counter/page_visits_counter'

RSpec.describe LogParser::Counter::PageVisitsCounter do
  subject { described_class.new }

  describe '#add_visit' do
    context 'when a new page is visited' do
      it 'creates a new entry for it with 1 visit and 1 unique visit' do
        subject.add_visit(page: '/home', ip: '127.0.0.1')
        subject.add_visit(page: '/about', ip: '127.0.0.1')

        expect(subject.collect).to eql([
                                         { page: '/home', page_visits: 1, unique_visits: 1 },
                                         { page: '/about', page_visits: 1, unique_visits: 1 }
                                       ])
      end
    end

    context 'when a page is visited by the same ip' do
      it 'increments the page entry visit counter but not the unique visit counter' do
        subject.add_visit(page: '/home', ip: '127.0.0.1')
        subject.add_visit(page: '/home', ip: '127.0.0.1')

        expect(subject.collect).to eql([{ page: '/home', page_visits: 2, unique_visits: 1 }])
      end
    end

    context 'when a page is visited by another ip' do
      it 'increments the page entry visit counter and unique visit counter' do
        subject.add_visit(page: '/home', ip: '127.0.0.1')
        subject.add_visit(page: '/home', ip: '192.168.0.1')

        expect(subject.collect).to eql([{ page: '/home', page_visits: 2, unique_visits: 2 }])
      end
    end
  end

  describe '#collect' do
    it 'resets the counter results' do
      subject.add_visit(page: '/home', ip: '127.0.0.1')
      subject.collect
      subject.add_visit(page: '/about', ip: '127.0.0.1')

      expect(subject.collect).to eql([{ page: '/about', page_visits: 1, unique_visits: 1 }])
    end
  end
end
