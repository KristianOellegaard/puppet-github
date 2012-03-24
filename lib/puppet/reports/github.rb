require 'puppet'
require 'json'
require 'yaml'

Puppet::Reports.register_report(:github) do

  config_file = File.join(File.dirname(Puppet.settings[:config]), "github.yaml")
  raise(Puppet::ParseError, "Github report config file #{config_file} not readable") unless File.exist?(config_file)
  config = YAML.load_file(config_file)
  GITHUB_USER = config[:github_user]
  GITHUB_REPO = config[:github_repo]
  GITHUB_PASS = config[:github_pass]

  def process
    Puppet.debug "Parsed with Github Issues report. Status of this run is #{self.status}"
    if self.status == "failed"
      Puppet.debug "Sending status for #{self.host} to Github issues."
      details = Array.new
      self.logs.each do |log|
        details << log
      end
      begin
        timeout(8) do
          Puppet.debug 'Creating request to github'
          uri = URI.parse(URI.encode("https://api.github.com/repos/#{GITHUB_REPO}/issues"))
          req = Net::HTTP::Post.new(uri.request_uri)
          req.basic_auth GITHUB_USER, GITHUB_PASS
          req.body = {
            "title" => "Puppet run failed on #{host} at #{Time.now.asctime}",
            "body" => details,
          }.to_json
          Puppet.debug "Sending request to github (#{uri})"
          http = Net::HTTP.new(uri.host, uri.port)
          http.use_ssl = true
          res = http.start {|http| http.request(req) }
          Puppet.debug "Received response (#{res.code}) from github"
        end
      rescue Timeout::Error
        Puppet.error "Timed out while attempting to create a GitHub issue, retrying ..."
        max_attempts -= 1
        retry if max_attempts > 0
      end
    end
  end
end