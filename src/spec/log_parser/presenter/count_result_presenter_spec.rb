# frozen_string_literal: true

require 'log_parser/presenter/count_result_presenter'

RSpec.describe LogParser::Presenter::CountResultPresenter do
  let(:count_result) do
    [
      {
        page: '/home',
        page_visits: 100,
        unique_visits: 20,
        average_visits: 4
      },
      {
        page: '/about',
        page_visits: 90,
        unique_visits: 25,
        average_visits: 4
      },
      {
        page: '/me',
        page_visits: 95,
        unique_visits: 22,
        average_visits: 4
      }
    ]
  end
  subject { described_class.new }

  describe '#present' do
    context 'page visits table presentation' do
      it 'returns a terminal table for the count result page visits, with a descending order' do
        present_result = subject.present(count_result)
        page_visits_table = present_result[0]

        expect(page_visits_table.to_s).to eql(
          "+--------+--------+\n"\
          "| Page   | Visits |\n"\
          "+--------+--------+\n"\
          "| /home  | 100    |\n"\
          "| /me    | 95     |\n"\
          "| /about | 90     |\n"\
          '+--------+--------+'
        )
      end
    end

    it 'returns a terminal table for the count result unique visits, with a descending order' do
      present_result = subject.present(count_result)
      page_visits_table = present_result[1]

      expect(page_visits_table.to_s).to eql(
        "+--------+--------------+\n"\
        "| Page   | Unique Views |\n"\
        "+--------+--------------+\n"\
        "| /about | 25           |\n"\
        "| /me    | 22           |\n"\
        "| /home  | 20           |\n"\
        '+--------+--------------+'
      )
    end

    it 'returns a terminal table for the count result average visits, with a descending order' do
      present_result = subject.present(count_result)
      page_visits_table = present_result[2]

      expect(page_visits_table.to_s).to eql(
        "+--------+---------------+\n"\
        "| Page   | Average Views |\n"\
        "+--------+---------------+\n"\
        "| /about | 4             |\n"\
        "| /me    | 4             |\n"\
        "| /home  | 4             |\n"\
        '+--------+---------------+'
      )
    end
  end
end
