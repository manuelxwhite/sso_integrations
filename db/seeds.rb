# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Sso::Client.create(
    name: "google",
    redirect_uri: "http://localhost:3000/users/auth/google_oauth2/callback",
    site_url: "https://accounts.google.com",
    token_url: "https://oauth2.googleapis.com/token",
    authorize_url: "https://accounts.google.com/o/oauth2/auth",
    user_info_url: "https://openidconnect.googleapis.com/v1/userinfo",
    user_info_fields: "id, email, name, given_name, family_name",
    user_info_id_field: "id",
    user_info_username_field: "email",
    user_info_email_field: "email",
    user_info_first_name_field: "given_name",
    user_info_last_name_field: "family_name",
    open_id_connect_endpoint: "https://accounts.google.com/.well-known/openid-configuration"
)

Sso::Client.create(
    name: "okta",
    redirect_uri: "http://localhost:3000/users/auth/okta/callback",
    site_url: "https://dev-123456.okta.com",
    token_url: "https://dev-123456.okta.com/oauth2/default/v1/token",
    authorize_url: "https://dev-123456.okta.com/oauth2/default/v1/authorize",
    user_info_url: "https://dev-123456.okta.com/oauth2/default/v1/userinfo",
    user_info_fields: "sub, email, name, given_name, family_name",
    user_info_id_field: "sub",
    user_info_username_field: "email",
    user_info_email_field: "email",
    user_info_first_name_field: "given_name",
    user_info_last_name_field: "family_name",
    open_id_connect_endpoint: "https://dev-123456.okta.com/.well-known/openid-configuration"
)
