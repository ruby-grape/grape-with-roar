module Acme
  class App
    def initialize
      @filenames = ['', '.html', 'index.html', '/index.html']
      @rack_static = ::Rack::Static.new(
        ->(_env) { [404, {}, []] },
        root: File.expand_path('../public', __dir__),
        urls: ['/']
      )
    end

    def self.instance
      @instance ||= Rack::Builder.new do
        use Rack::Cors do
          allow do
            origins '*'
            resource '*', headers: :any, methods: :get
          end
        end

        run Acme::App.new
      end.to_app
    end

    def call(env)
      response = hal_redirect(env) || api_or_static_response(env)

      case response[0]
      when 404, 500
        content = @rack_static.call(env.merge('PATH_INFO' => "/errors/#{response[0]}.html"))
        [response[0], content[1], content[2]]
      else
        response
      end
    end

    private

    def hal_redirect(env)
      # Strip unexpanded URI templates so HAL links remain clickable in a browser.
      match = %r{\A([/\w]*)(?:%7B|\{)?.*(?:%7D|\})\z}.match(Rack::Request.new(env).fullpath)
      return unless match

      [302, { 'location' => match[1], 'content-type' => 'text/plain' }, []]
    end

    def api_or_static_response(env)
      response = Acme::Api::RootEndpoint.call(env)
      return response unless (response[1]['x-cascade'] || response[1]['X-Cascade']) == 'pass'

      @filenames.each do |path|
        static = @rack_static.call(env.merge('PATH_INFO' => env['PATH_INFO'] + path))
        return static if static[0] != 404
      end
      response
    end
  end
end
