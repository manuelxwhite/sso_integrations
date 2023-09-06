class CreateSsoAuthorizations < ActiveRecord::Migration[7.0]
  def change
    create_table :sso_authorizations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sso_client, null: false, foreign_key: true
      t.string :access_token, null: false
      t.string :refresh_token
      t.datetime :expires_at
      t.string :scope
      t.string :state

      t.timestamps
    end
  end
end
