class RequestTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    started = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    status, headers, body = @app.call(env)

    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started
    headers["Server-Timing"] = "app;dur=#{(elapsed * 1000).round(1)}"

    [status, headers, body]
  end
end