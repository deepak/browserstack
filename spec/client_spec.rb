require 'spec_helper'

describe "Client" do
  let(:username) { "kannan.deepak@gmail.com" }
  let(:password) { "<password>" }
  let(:client) { Browserstack::Client.new(username, password) } 
  
  it "can read the schema" do
    expect(client.schema).to eq({})
  end

  it "can get a list of browsers" do
    expect(client.browsers).not_to be_empty
  end
  
  it "can create a worker", :wip do
    os = "Snow Leopard"
    browser = "chrome"
    expect(client.create_worker(os: os, browser: browser)).to eq({})
  end
end
