require 'faraday'
require 'logger'

require 'zodiac/middleware/cache'

module Zodiac
  module Service
    module Fetcher
      def self.new(logger = Logger.new($stderr))
        opts = {
            headers: {
            'User-Agent' => "#{File.basename(`git rev-parse --show-toplevel`.strip)}/#{`git rev-parse --short HEAD`.strip}"
          },
        }
        Faraday.new(opts) do |c|
          c.use Zodiac::Middleware::Cache
          c.adapter Faraday.default_adapter
        end
      end
    end
  end
end
