require 'net/http'
require 'json'

class ChatController < ApplicationController
  def respond
    user_message = params[:message]

    # Call GPT-Neo API on Render
    uri = URI('https://gpt-neo-api.onrender.com/chat')
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri.path, { 'Content-Type' => 'application/json' })
    request.body = { message: user_message }.to_json

    response = http.request(request)
    ai_response = JSON.parse(response.body)['response']

    render json: { response: ai_response }
  rescue StandardError => e
    render json: { error: e.message }, status: 500
  end
end
