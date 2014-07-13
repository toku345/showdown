lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'md_preview'

map '/' do
  run Rack::File.new(File.expand_path(File.dirname(__FILE__)) + '/html')
end

map '/websocket' do
  run MdPreview::RackApp.new # backend: { debug: true }
end
