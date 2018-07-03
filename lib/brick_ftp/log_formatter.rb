# frozen_string_literal: true

module BrickFTP
  class LogFormatter < Logger::Formatter
    FORMAT = "severity:%{severity}\tpid:%{pid}\ttime:%{time}\tmessage:%{message}\n"

    def call(severity, time, _program_name, message)
      params = {
        severity: severity,
        pid: Process.pid,
        time: format_datetime(time),
        message: msg2str(message),
      }
      FORMAT % params
    end
  end
end
