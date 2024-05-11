require 'date'

module Logger
  LOG_FILE = 'app.logs'

  def log_info(message)
    log('info', message)
  end

  def log_warning(message)
    log('warning', message)
  end

  def log_error(message)
    log('error', message)
  end

  private

  def log(log_type, message)
    timestamp = DateTime.now.strftime('%Y-%m-%dT%H:%M:%S%:z')
    log_entry = "#{timestamp} -- #{log_type} -- #{message}\n"
    File.open(LOG_FILE, 'a') { |file| file.write(log_entry) }
  end
end
