module Rack
  class Redact
    def initialize(app, redacted)
      @app = app
      @redacted = redacted
    end

    def redact_expr
      @redacted.join("|")
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      response = @app.call(env)
      return response unless redact?(env)
      response_body = []
      response[2].each { |body|
        # Use pretty <span> tags when dealing with html
        body.gsub!(/>([^<]*)</) do |inner|
          inner.gsub(/#{redact_expr}/i) { |m|
            "<span style=\"background-color:#000;color:#000;\">#{"*" * m.size}</span>"
          }
        end

        # Use regular stars inside html tags or anywhere else that we don't want a <span>
        body.gsub!(/#{redact_expr}/) do |m|
          "*" * m.size
        end
        response_body << body
      }

      response[2] = response_body
      response
    end

    # Preserve the original behavior (always redact), unless the session
    # variable to redact is explicitly set to false
    def redact?(env)
      env['rack.session'].nil? || env['rack.session'][:redact]
    end
  end
end
