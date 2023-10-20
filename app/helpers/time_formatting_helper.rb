# frozen_string_literal: true

# Module TimeFormattingHelper
module TimeFormattingHelper
  def formatted_duration(duration)
    return '0' if duration.blank? || duration.zero?

    hours = duration / 3600
    minutes = (duration % 3600) / 60
    seconds = duration % 60

    formatted_time = []

    if hours.positive?
      formatted_time << "#{hours}h"
      formatted_time << "#{minutes}m" if minutes.positive?
    elsif minutes.positive?
      formatted_time << "#{minutes}m"
      formatted_time << "#{seconds}s" if seconds.positive?
    elsif seconds.positive?
      formatted_time << "#{seconds}s"
    end

    formatted_time.join
  end
end
