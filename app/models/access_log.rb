class AccessLog
  include CouchPotato::Persistence

  property :page, :type => String
  #property :page_rev => String
  property :referrer, :type => String
  property :timestamp, :type => String
  property :user_id, :type => String
  property :ip, :type => String

  view :by_user_and_timestamp, :include_docs => true, :type => :custom, :map => <<-js
  function(doc) {
    if (doc.type == 'access') {
      emit([doc.user_id, doc.timestamp], null);
    }
  }
  js


end
