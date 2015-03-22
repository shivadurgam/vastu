class User < ActiveRecord::Base

  mount_uploader :picture, PictureUploader

    validate  :picture_size
    validates_presence_of :name, :email, :picture, :message => ": cant be blank"
	validates_length_of :name, :email, :in => 2..80
	validates_uniqueness_of :email, :message => ": This email already exists"
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }
	

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 2.megabytes
        errors.add(:picture, "should be less than 2MB")
      end
    end

end
