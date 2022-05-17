class ThirdPartyUser < ApplicationRecord
  enum provider: { google: 'google', facebook: 'facebook' }, _suffix: 'provider'
  belongs_to :user
end
