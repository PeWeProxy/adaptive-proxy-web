class Page
  include CouchPotato::Persistence

  property :checksum, :type => String
  property :content_length, :type => Fixnum
  property :pages_terms, :type => Array
  property :type, :type => String
  property :url, :type => String

  view :by_id, :map => "function(doc) {if(doc.type == 'PAGE') {emit(doc._id, doc);}}", :include_docs => true, :type => :custom
  view :url, :map => "function(doc) {if(doc.type = 'PAGE') {emit(doc.url, doc);}}", :include_docs => true, :type => :custom
=begin
  has_one :access_log
  has_one :wi_feedback

  def increase_time_on_page(period)
    self[:time_on_page] ||= 0
    self[:time_on_page] += period
  end
=end
end