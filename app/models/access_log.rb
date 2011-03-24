class AccessLog
  include CouchPotato::Persistence

  property :copy_count, :type => Fixnum
  property :ip, :type => String
  property :page_id, :type => String
  property :referer, :type => String
  property :scroll_count, :type => Fixnum
  property :time_on_page, :type => Fixnum
  property :timestamp, :type => Date
  property :type, :type => String
  property :userid, :type => String

  property :keywords, :type => String

  view :all_by_user, :map => "function(doc) {if(doc.type == 'ACCESS_LOG' && doc.referer) {emit(doc.userid, doc);}}", :include_docs => true, :type => :custom
  view :by_id, :map => "function(doc) {if(doc.type == 'ACCESS_LOG' && doc.referer) {emit(doc._id, doc);}}",  :include_docs => true, :type => :custom

=begin
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
=end
end