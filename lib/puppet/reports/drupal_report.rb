require 'puppet'
require 'puppet/network/http_pool'
require "net/http"
require "uri"

Puppet::Reports.register_report(:drupal_report) do
	desc "Drupal custom report handlers"
	def process

		self.logs.each do |log|
			
			myMessage = URI.escape(log.message)

			path = "http://#{self.host}/puppet/post/#{self.host}/#{log.level}/#{myMessage}"

			uri = URI.parse(path)
			response = Net::HTTP.get_response(uri)
		end
	end
end