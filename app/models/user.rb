class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :name, :oauth_expires_at, :oauth_token, :provider, :uid
  def self.from_omniauth(auth)
   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"]
    user.oauth_token = auth["credentials"]["token"]
    user.oauth_expires_at = Time.at(auth["credentials"]["expires_at"])
    user.save!
  end
end
def self.create_with_omniauth(auth)
  create! do |user|
    user.provider = auth["provider"]
    user.uid = auth["uid"]
    user.name = auth["info"]["name"]
	user.email = auth["info"]["email"]
	user.email = "shekar@gmail1.com" if auth["provider"].eql?("twitter")
    user.password_confirmation = "something"
	user.password = "something"
  end

end

end