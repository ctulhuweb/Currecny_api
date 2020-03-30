class AuthorizeApiRequest
  include Callable

  AUTH_TOKEN = "E76dyVeBAiFuudXTYVt4zQXB"
  
  def initialize(headers = {})
    @headers = headers
  end

  def call
    http_auth_header == AUTH_TOKEN
  end

  def http_auth_header
    if @headers['Authorization'].present?
      return @headers['Authorization'].split(' ').last
    end
  end
end