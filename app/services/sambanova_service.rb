require "net/http"
require "json"
require "uri"

# Configuration
class ApiUtil
  def initialize(base_url, token)
    @base_url = base_url
    @token = token
  end

  # Stream-enabled POST method
  def post(payload, &block)
    url = URI(@base_url)
    pp "URL #{url}"

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Bearer #{@token}"
    request["Content-Type"] = "application/json"
    request.body = payload.to_json

    # Use a block to handle streamed responses
    http.request(request) do |response|
      if block_given?
        response.read_body do |chunk|
          block.call(chunk)
        end
      else
        {code: response.code, body: response.body}
      end
    end
  end
end

class SambanovaService
  def initialize
    @api_util = ApiUtil.new(ENV["SAMBANOVA_ENDPOINT"], ENV["SAMBANOVA_KEY"])
  end

  def make_request(query, topic, &block)
    payload = {
      stream: true,
      model: "Meta-Llama-3.1-8B-Instruct",
      messages: [
        {
          role: "assistant",
          content: "You are a #{topic} expert. Help me answer the following question"
        },
        {
          role: "assistant",
          content: query
        }
      ]
    }

    # Call the streaming POST method
    res = @api_util.post(payload) do |chunk|
      chunk = chunk.gsub("data: ", "").chomp
      unless /.*[DONE].*/.match?(chunk)
        # pp JSON.parse(chunk)["choices"][0]["delta"]["content"]
        content = JSON.parse(chunk)["choices"][0]["delta"]["content"]
        if block_given?
          block.call(content) # Pass each chunk to the provided block
        else
          chunk
        end
      end
    end
  end
end
