class StoredApuid < ActiveRecord::Base
  def self.clean_database
    StoredApuid.delete_all(['valid_until < ?', Date.today])
  end
end
