class WiFeedback < ActiveRecord::Base
  
  belongs_to :page
  
  named_scope :by_checksum, lambda { |checksum, userid| { :select => "wi_feedbacks.id,wi_feedbacks.positive_feedback,wi_feedbacks.negative_feedback", :include => :page, :conditions => ["pages.checksum = ? AND userid = ?", checksum, userid], :order => 'timestamp DESC', :limit => 1}}
  
  def increase_positive_feedback()
    self[:positive_feedback] ||= 0
    self[:positive_feedback] += 1
  end
  
  def increase_negative_feedback()
    self[:negative_feedback] ||= 0
    self[:negative_feedback] += 1
  end
  
end