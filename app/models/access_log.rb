class AccessLog
  include CouchPotato::Persistence

  property :page_id, :type => String
  property :referer, :type => String
  property :timestamp, :type => Date
  property :userid, :type => String

  property :url, :type => String
  property :keywords, :type => String

  view :all_by_user, :include_docs => false, :type => :custom, :map => <<js
function(doc) {
  if(doc.type == 'ACCESS_LOG') {
    emit(doc.userid, {page_id: doc.page_id, referer: doc.referer, timestamp: doc.timestamp});
  }
}
js

  view :by_id, :include_docs => true, :type => :custom, :map => <<js
function(doc) {
  if(doc.type == 'ACCESS_LOG') {
    emit(doc._id, null);
  }
}
js

end