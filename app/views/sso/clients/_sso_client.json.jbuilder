json.extract! sso_client, :id, :name, :redirect_uri, :site_url, :token_url, :authorize_url, :user_info_url, :user_info_fields, :user_info_id_field, :user_info_username_field, :user_info_email_field, :user_info_first_name_field, :user_info_last_name_field, :open_id_connect_endpoint, :created_at, :updated_at
json.url sso_client_url(sso_client, format: :json)
