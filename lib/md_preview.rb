require 'rack/websocket'
require 'md_preview/version'

module MdPreview
  class RackApp < Rack::WebSocket::Application
    def on_open(_env)
      puts 'client connected'
      EM.add_timer(5) do
        send_data 'This message should show-up 5 secs later'
      end

      EM.add_timer(15) do
        send_data 'This message should show-up 15 secs later'
      end

      # EM.add_periodic_timer(1) do
      #   send_data target
      #   # send_data 'yay!'
      # end
    end

    def on_message(_env, msg)
      puts "message received: #{msg}"
      EM.send_data "Message: #{msg}"
    end

    def on_close(_env)
      puts 'client disconnected'
    end

    private

    def target
      @target ||= File.open('./target.txt', 'r').readlines[0]
    end
  end
end
