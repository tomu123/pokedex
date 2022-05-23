class User < ApplicationRecord
  # Add support to softdelete users
  include SoftDelete
  enum user_role: { trainer: 'trainer', admin: 'admin', doctor: 'doctor' }, _suffix: 'role', _default: 'trainer'
  has_many :captured_pokemons
  has_many :pokemons, through: :captured_pokemons
  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all # or :destroy if you need callbacks
  has_one :third_party_user, dependent: :destroy
  has_one_attached :image
end
