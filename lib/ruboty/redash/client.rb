# frozen_string_literal: true

require 'faraday'
require 'json'

module Ruboty
  module Redash
    class Client
      def initialize(root, user_apikey)
        @root = root
        @user_apikey = user_apikey
        @client = build
      end

      def fetch(query_id)
        result_id = latest_query_data_id(query_id)
        query_result_data(result_id)
      end

      private

      def query_result_data(result_id)
        json = query_result(result_id)
        json['query_result']['data']
      end

      def query_result(result_id)
        res = client.get("/api/query_results/#{result_id}")
        parse_json(res)
      end

      def latest_query_data_id(query_id)
        json = query(query_id)
        json['latest_query_data_id']
      end

      def query(query_id)
        res = client.get("/api/queries/#{query_id}")
        parse_json(res)
      end

      def parse_json(response)
        unless response.success?
          warn response.body
          throw 'fetch error'
        end
        JSON.parse(response.body)
      end

      def build
        Faraday.new(url: root, proxy: ENV['REDASH_HTTP_PROXY_URL']) do |builder|
          builder.authorization('Key', user_apikey) if user_apikey
          builder.adapter Faraday.default_adapter
        end
      end

      attr_reader :root, :user_apikey, :client
    end
  end
end
