require 'net/http'
require 'uri'

git_binary = ENV['TM_GIT'] || "/usr/bin/env git"
github_config_get = "#{git_binary} config --global --get github"

@login = ENV['GITHUB_USER']  || `#{github_config_get}.user`.chomp
@token = ENV['GITHUB_TOKEN'] || `#{github_config_get}.token`.chomp

@continue = true

if @login.nil? || @login == ''
  print "\nError: your github login is not set. See https://github.com/ivanvc/gists-tmbundle for configuration instructions.\n"
  @continue = false
end
if @token.nil? || @token == ''
  print "\nError: your github token is not set.  See https://github.com/ivanvc/gists-tmbundle for configuration instructions.\n"
  @continue = false
end

@contents = ENV['TM_SELECTED_TEXT'] || `/usr/bin/env cat "#{ENV['TM_FILEPATH']}"`
@name     = ENV['TM_FILENAME']      || 'Uploaded from TextMate'

if @contents.nil? || @contents.strip == ''
  puts "Error: no content to upload"
  @continue = false
end
