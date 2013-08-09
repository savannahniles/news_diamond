class User < ActiveRecord::Base
    has_many :relationships, dependent: :destroy
    has_many :feeds, through: :relationships

	before_save { self.email = email.downcase }
    before_create :create_remember_token

	validates :first_name, presence: true, length: { maximum: 20 }
	validates :last_name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

    has_secure_password
    validates :password, length: { minimum: 6 }

    def User.new_remember_token
    	SecureRandom.urlsafe_base64
  	end

    def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    def following?(feed)
        relationships.find_by(feed_id: feed.id)
    end

    def follow!(feed)
        relationships.create!(feed_id: feed.id)
    end

    def unfollow!(feed)
      relationships.find_by(feed_id: feed.id).destroy!
    end

    private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
