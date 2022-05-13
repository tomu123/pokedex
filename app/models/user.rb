class User < ApplicationRecord
  enum user_role: { trainer: 'trainer', admin: 'admin', doctor: 'doctor' }, _suffix: 'role', _default: 'trainer'
  has_many :captured_pokemons
  has_many :pokemons, through: :captured_pokemons
end
