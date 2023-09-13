# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def create_or_update_sso_client(client_params)
  client = Sso::Client.find_or_initialize_by(name: client_params[:name])
  client.update(client_params)
end

create_or_update_sso_client(
  name: 'google_oauth2',
  redirect_uri: 'http://localhost:3000/users/auth/google_oauth2/callback',
  site_url: 'https://accounts.google.com',
  token_url: 'https://oauth2.googleapis.com/token',
  authorize_url: 'https://accounts.google.com/o/oauth2/auth',
  user_info_url: 'https://openidconnect.googleapis.com/v1/userinfo',
  user_info_fields: 'id,email,name,first_name,last_name',
  user_info_id_field: 'id',
  user_info_username_field: 'email',
  user_info_email_field: 'email',
  user_info_first_name_field: 'first_name',
  user_info_last_name_field: 'last_name',
  open_id_connect_endpoint: 'https://accounts.google.com/.well-known/openid-configuration'
)

create_or_update_sso_client(
  name: 'facebook',
  redirect_uri: 'http://localhost:3000/users/auth/facebook/callback',
  site_url: 'https://www.facebook.com',
  token_url: 'https://graph.facebook.com/oauth/access_token',
  authorize_url: 'https://www.facebook.com/v11.0/dialog/oauth',
  user_info_url: 'https://graph.facebook.com/me?fields=id,email,name,first_name,last_name',
  user_info_fields: 'id,email,name,first_name,last_name',
  user_info_id_field: 'id',
  user_info_username_field: 'email',
  user_info_email_field: 'email',
  user_info_first_name_field: 'first_name',
  user_info_last_name_field: 'last_name',
  open_id_connect_endpoint: 'https://www.facebook.com/.well-known/openid-configuration'
)

create_or_update_sso_client(
  name: 'okta',
  redirect_uri: 'http://localhost:3000/users/auth/okta/callback',
  site_url: 'https://okta-dev-29807662.okta.com',
  token_url: 'https://okta-dev-29807662.okta.com/oauth2/default/v1/token',
  authorize_url: 'https://okta-dev-29807662.okta.com/oauth2/default/v1/authorize',
  user_info_url: 'https://okta-dev-29807662.okta.com/oauth2/default/v1/userinfo',
  user_info_fields: 'sub,email,name,preferred_username,given_name,family_name',
  user_info_id_field: 'sub',
  user_info_username_field: 'preferred_username',
  user_info_email_field: 'email',
  user_info_first_name_field: 'given_name',
  user_info_last_name_field: 'family_name',
  open_id_connect_endpoint: 'https://okta-dev-29807662.okta.com/oauth2/default/.well-known/openid-configuration'
)


User.find_or_create_by(email: 'admin@admin.com') do |user|
  user.password = 'password'
  user.username = 'admin'
  user.first_name = 'Adam'
  user.last_name = 'West'
  user.admin = true
end