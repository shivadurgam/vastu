class Pic < ActiveRecord::Base

	belongs_to :user
	mount_uploader :picture, PictureUploader
	validate  :picture_size

    validates_presence_of :picture, :message => ": Please upload a picture"



	private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 2.megabytes
        errors.add(:picture, "should be less than 2MB")
      end
    end
end
