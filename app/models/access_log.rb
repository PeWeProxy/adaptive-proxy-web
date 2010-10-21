class AccessLog < ActiveRecord::Base
  belongs_to :page

  named_scope :by_checksum, lambda { |checksum, userid| { :select => "access_logs.*", :joins => "INNER JOIN pages ON pages.id = access_logs.page_id", :conditions => [ "pages.checksum = ? AND userid = ?", checksum, userid ], :order => 'timestamp DESC', :limit => 1 } }

  def increase_time_on_page(period)
    self[:time_on_page] ||= 0
    self[:time_on_page] += period.to_i
  end
  
  def increase_scroll_count(scrolls)
    self[:scroll_count] ||= 0
    self[:scroll_count] += scrolls.to_i
  end
  
  def increase_copy_count(copies)
    self[:copy_count] ||= 0
    self[:copy_count] += copies.to_i
  end
end
