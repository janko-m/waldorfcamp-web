configure :development do
  disable :logging

  class CustomLogger
    def initialize(app)
      @app = app
    end

    def call(env)
      before_call = Time.now
      result = @app.call(env)
      delta = Time.now - before_call
      env['rack.errors'].puts "%s %s %.4fs" % [env['REQUEST_METHOD'], env['PATH_INFO'], delta]
      result
    end
  end

  use CustomLogger
end
