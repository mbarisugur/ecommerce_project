module Log
  module FileLogger
    def log_file
      logger = Logger.new("log/log_#{controller_name}.log")
      log = {
        parameters: params,
        current_user: current_user,
        date_time = DateTime.now,
        method: action_name,
        controller: controller_name,
        remote_ip: request.remote_ip,
        ip: request.ip,
        request: request.original_url,
        request_fullpath: request.full_path
      }
    end
  end
end