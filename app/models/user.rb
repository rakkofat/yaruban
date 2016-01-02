class User < ActiveRecord::Base
  has_many :boards

  validates :provider, presence: true
  validates :uid, presence: true
  validates :username, presence: true

  def self.find_or_create_from_omniauth(auth)
    provider = auth.provider
    uid = auth.uid

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.provider = provider
      user.uid = uid
      user.username = auth.info.name
      user.avatar_url = auth.info.image
    end
  end

end
