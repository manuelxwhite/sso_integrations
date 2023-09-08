FactoryBot.define do
    factory :sso_client, class: 'Sso::Client' do
        name { 'google_oauth2' }
        redirect_uri { 'http://localhost:3000' }
        site_url { 'http://localhost:3000' }
        token_url { 'http://localhost:3000' }
        authorize_url { 'http://localhost:3000' }
        user_info_url { 'http://localhost:3000' }
        user_info_fields { 'id,username,email,first_name,last_name' }
        user_info_id_field { 'id' }
        user_info_username_field { 'username' }
        user_info_email_field { 'email' }
        user_info_first_name_field { 'first_name' }
        user_info_last_name_field { 'last_name' }
        open_id_connect_endpoint { 'http://localhost:3000' }
    end
end