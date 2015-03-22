class User < ActiveRecord::Base
  has_many :pics
  attr_accessor :password

  before_save :encrypt_password
  
  validates_presence_of :name, :email, :password, :message => ": cant be blank"
	validates_length_of :name, :email, :password, :in => 2..80
	validates_uniqueness_of :email, :message => ": This email already exists"
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }
  validates_format_of :password, :with =>  /\A[A-Z]+[a-zA-Z0-9@#$\s]+\z/, :message => ": Should start with a Capital letter"
  validates :password, :confirmation => true

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

class << self 

  def authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end

  def authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
end



  private

  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end	

 

end
