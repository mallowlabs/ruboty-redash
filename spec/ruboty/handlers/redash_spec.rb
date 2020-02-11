# frozen_string_literal: true

RSpec.describe Ruboty::Handlers::Redash do
  let(:action) { double(:action) }
  let(:robot) { Ruboty::Robot.new }

  describe '#show' do
    it 'call action' do
      expect(Ruboty::Redash::Actions::Show).to receive(:new).and_return(action)
      expect(action).to receive(:call)
      robot.receive(body: "ruboty redash show 9 Today's KPI is <%= data['rows'][-1]['kpi'] =>")
    end
  end
end
