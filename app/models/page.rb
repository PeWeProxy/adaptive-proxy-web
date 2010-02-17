class Page < ActiveRecord::Base
  has_one :access_log

  def increase_time_on_page(period)
    self[:time_on_page] ||= 0
    self[:time_on_page] += period
  end
end
