class CustomHttp
  attr_reader :conn

  def initialize(url = nil, options = {}, &block)
    @conn = Faraday.new(url, options, &block)
  end

  METHODS_WITH_QUERY = ['get', 'head', 'delete', 'trace']
  METHODS_WITH_BODY = ['post', 'put', 'patch']

  METHODS_WITH_QUERY.each do |method|
    # GET, HEAD, DELETE, TRACE methods definition
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(url = nil, params = nil, headers = nil) # GET, HEAD, DELETE, TRACE methods definition
          conn.run_request(:#{method}, url, nil, headers) do |request| #
            request.params.update(params) if params #
            yield request if block_given? #
          end #
        end #
    RUBY
  end

  METHODS_WITH_BODY.each do |method|
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{method}(url = nil, body = nil, headers = nil, &block) # POST, PUT, PATCH methods definition
          conn.run_request(:#{method}, url, body, headers, &block) #
        end #
    RUBY
  end
end
