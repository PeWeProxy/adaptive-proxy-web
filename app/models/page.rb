class Page
  include CouchPotato::Persistence

  property :pages_terms, :type => Array
  property :url, :type => String

  view :by_id, :include_docs => false, :type => :custom, :map => <<js
function(doc) {
  if(doc.type == 'PAGE') {
    emit(doc._id, {pages_terms: doc.pages_terms, url: doc.url});
  }
}
js

end