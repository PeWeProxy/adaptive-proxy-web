require 'rubygems'
require 'couch_potato'
require 'validatable'

CouchPotato::Config.database_name = "http://localhost:5984/proxy/"

#class = design name
class Example
  include CouchPotato::Persistence
  view :url, :map => "function(doc) { if(doc.type = 'page') { emit(doc.url, doc.type)} }", :include_docs => true, :type => :custom, :lists => nil
end

CouchPotato.database.view Example.url

