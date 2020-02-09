# frozen_string_literal: true

require 'erb'

module Ruboty
  module Redash
    module Actions
      class Show
        def initialize(message)
          @message = message
        end

        def call
          data = Ruboty::Redash::Client.new(redash_root, redash_user_apikey).fetch(query_id)
          message.reply(reply_message(binding))
        rescue => e
          message.reply(e.message)
        end

        private

        def reply_message(b = binding)
          ERB.new(format).result(b)
        end

        def format
          message[:format] || "<%= data %>"
        end

        def query_id
          message[:query_id]
        end

        def redash_user_apikey
          ENV['REDASH_USER_APIKEY']
        end

        def redash_root
          ENV['REDASH_ROOT']
        end

        attr_reader :message
      end
    end
  end
end
