# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_user_registration_with_proxy_session',
  :secret      => '842cc0902e2cc6990af1dca9dc21d27d7bcccfd932d958967791c62c0f49b75745a8e04483646192962b744d685e849049409d41efefe3fcd281feb318ffe9e8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
