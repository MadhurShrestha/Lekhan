class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
   validates_uniqueness_of :username

  has_many :notebooks, dependent: :destroy
  has_many :pages, through: :notebooks
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]

  has_paper_trail
  attr_writer :login

  def avatar_thumbnail
    return 'namaskar.jpg' unless avatar.attached?

    begin
      avatar.variant(resize_to_limit: [95,95]).processed
    rescue ActiveStorage::FileNotFoundError
      "namaskar.jpg"
    end
  end

  def login
    @login || self.username || self .email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # def validate_username
  #   if User.where(email: username).exists?
  #     errors.add(:username, :invalid)
  #   end
  # end

  private
    def add_default_avatar
      unless avatar.attached?
        avatar.attach(
          io: File.open(
            Rails.root.join(
              'app','assets','images','namaskar.jpg'
              ),
            ),
          filename: 'namaskar.jpg',
          content_type: 'image/jpg'
          )
      end
    end
end
