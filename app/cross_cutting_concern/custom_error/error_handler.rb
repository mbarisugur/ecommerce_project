module Error
  module ErrorHandler
    extend ActiveSupport:Concern

    include Log::FileLogger

    included do
      rescue_from Exception, with: :error_handler
      rescue_from ActiveRecord::RecordNotFound, with: :error_handler_not_found
      rescure_from ActionController::RoutingError, with: :error_handler_not_found
    end

    def error_handler(exception)
      log_error_to_file(exception)
    end

    def error_handler_not_found
      log_error_to_file(exception)
    end

  end
end