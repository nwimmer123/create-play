class User < ActiveRecord::Base
  has_secure_password

  has_many :games

  def self.confirm(params)
    @user = User.find_by({email: params[:email]})
    @user.try(:authenticate, params[:password])
  end

  def is_authorized?
    current_user == @user
  end

  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
  validates :email, format: {with: /@/}

end
