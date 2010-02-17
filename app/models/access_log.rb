class AccessLog < ActiveRecord::Base
  belongs_to :page

  named_scope :by_checksum, lambda { |checksum, userid| { :include => :page, :conditions => [ "pages.checksum = ? AND userid = ?", checksum, userid ], :order => 'timestamp DESC', :limit => 1 } }

  def increase_time_on_page(period)
    self[:time_on_page] ||= 0
    self[:time_on_page] += period.to_i
  end
end
