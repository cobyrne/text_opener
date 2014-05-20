require 'text_opener'
require 'webmock'
require 'webmock/rspec'

describe TextOpener do
  it "launchy's an html file with the text info" do
    nsa = TextOpener::NSA.new.tap(&:intercept)
    account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
    client = Twilio::REST::Client.new account_sid, auth_token
    from_number = "3334445555"
    to_number = "5554443333"
    message_body = "Your code is 123456"
    file_contents = ''

    allow(Launchy).to receive(:open) do |file_path|
      file_contents = File.read(file_path)
    end

    client.account.messages.create({
      from: from_number,
      to: to_number,
      body: message_body
    })

    expect(Launchy).to have_received(:open)
    expect(file_contents).to include(to_number)
    expect(file_contents).to include(from_number)
    expect(file_contents).to include(message_body)
    nsa.restore
  end

  it "doesn't do anything until you install it" do
    message_request = WebMock.stub_request(:post, /.*api.twilio.com.*/).to_return({status: 200, body: {sid: ''}.to_json })

    account_sid = 'ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
    auth_token = 'yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy'
    client = Twilio::REST::Client.new account_sid, auth_token
    from_number = "3334445555"
    to_number = "5554443333"
    message_body = "Your code is 123456"
    client.account.messages.create({
      from: from_number,
      to: to_number,
      body: message_body
    })

    expect(message_request).to have_been_requested
  end
end
