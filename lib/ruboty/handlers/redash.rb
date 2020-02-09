# frozen_string_literal: true

require 'ruboty'

module Ruboty
  module Handlers
    class Redash < Base
      on(/redash show (?<query_id>\d+)(?<format> .*)?\z/, name: 'show', description: 'get data from Redash')

      def show(message)
        Ruboty::Redash::Actions::Show.new(message).call
      end
    end
  end
end
