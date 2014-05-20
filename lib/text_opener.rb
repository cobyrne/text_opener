require "text_opener/version"
require 'json'
require 'securerandom'
require 'tmpdir'
require 'launchy'
require 'erb'
require 'twilio-ruby'

module TextOpener
  def self.install
    NSA.new.tap(&:intercept)
  end

  class InterceptingMessage < Twilio::REST::Message; end
  class InterceptingMessages < Twilio::REST::Messages
    def create(params)
      tmp_dir = Dir.mktmpdir
      file_path = File.join(tmp_dir, "#{SecureRandom.uuid}.html")
      File.open(file_path, "w") do |file|
        template = ERB.new(<<-TEMPLATE)
          <html>
            <head><title>SMS to #{params[:to]}</title></head>
            <body>
              <dl>
              <dt>To:</dt><dd>#{params[:to]}</dd>
              <dt>From:</dt><dd>#{params[:from]}</dd>
              </dl>
              <p>#{params[:body]}</p>
            </body>
          </html>
        TEMPLATE
        file.write(template.result(binding))
      end
      Launchy.open(file_path)
    end
  end

  class NSA
    def intercept
      @original_messages = Twilio::REST::Messages
      Twilio::REST.send(:remove_const, :Messages)
      Twilio::REST.send(:const_set, :Messages, TextOpener::InterceptingMessages)
    end

    def restore
      Twilio::REST.send(:remove_const, :Messages)
      Twilio::REST.send(:const_set, :Messages, @original_messages)
    end
  end
end
