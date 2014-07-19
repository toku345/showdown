lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'md_preview'

puts "tartget: #{ENV['TARGET_PATH']}"

map '/' do
  run Rack::File.new(File.expand_path(File.dirname(__FILE__)) + '/html/index.html')
end

map '/websocket' do
  run MdPreview::RackApp.new # backend: { debug: true }
end
