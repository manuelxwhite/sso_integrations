class CreateSsoClients < ActiveRecord::Migration[7.0]
  def change
    create_table :sso_clients do |t|
      t.string :name, null: false
      t.string :redirect_uri, null: false
      t.string :site_url, null: false
      t.string :token_url, null: false
      t.string :authorize_url, null: false
      t.string :user_info_url, null: false
      t.string :user_info_fields, null: false
      t.string :user_info_id_field, null: false
      t.string :user_info_username_field, null: false
      t.string :user_info_email_field, null: false
      t.string :user_info_first_name_field, null: false
      t.string :user_info_last_name_field, null: false
      t.string :open_id_connect_endpoint, null: false

      t.timestamps
    end
  end
end
