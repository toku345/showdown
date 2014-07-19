require 'rack/websocket'
require 'md_preview/version'
require 'redcarpet'

module MdPreview
  # MdWatcher
  module MdWatcher
    def setup_render
      @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
    end

    def parsed_html
      @markdown.render(File.open(@target_path).read)
    end

    def file_changed?
      @old_file_mtime ||= File.stat(@target_path).mtime

      if File.stat(@target_path).mtime > @old_file_mtime
        puts 'detect file change'
        @old_file_mtime = File.stat(@target_path).mtime
        true
      else
        false
      end
    end
  end

  # RackApp
  class RackApp < Rack::WebSocket::Application
    include MdWatcher

    def initialize
      setup_render
      @target_path = ENV['TARGET_PATH']
    end

    def on_open(_env)
      puts 'client connected'

      send_data parsed_html

      EM.add_periodic_timer(0.5) do
        send_data parsed_html if file_changed?
      end
    end

    def on_message(_env, msg)
      puts "message received: #{msg}"
      EM.send_data "Message: #{msg}"
    end

    def on_close(_env)
      puts 'client disconnected'
    end
  end
end
