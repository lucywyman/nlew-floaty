#!/usr/bin/env ruby

require 'json'
require 'open3'

args = JSON.parse(STDIN.read)

platform = args['platform']
count = args.fetch('count', 1)

stdout, stderr, status = Open3.capture3('floaty', 'get', "#{platform}=#{count}", '--json')

if status != 0
  result = {_error: {msg: "Failed to execute floaty: #{stderr}", kind: "execution-error", details: {exitcode: status.exitstatus}}}
  puts result.to_json
  exit 1
end

nodes = Array(JSON.parse(stdout)[platform])

result = {nodes: nodes}
puts result.to_json
exit 0
