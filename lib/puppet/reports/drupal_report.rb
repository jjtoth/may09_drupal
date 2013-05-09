require 'puppet'
require 'puppet/network/http_pool'

Puppet::Reports.register_report(:drupal_report) do
	desc "Drupal custom report handlers"
	def process

		connection = Puppet::Network::HttpPool.http_instance(Puppet[:server],80)

		self.logs.each do |log|

			path = "/puppet/post/#{self.host}/#{log.level}/#{log.message}"

puts "drupal reports " << path

#		connection.request_get(path,{"Accept" => options[:accept]}).body
			connection.request_get(path).body
		end
	end
end