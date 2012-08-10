module Boss
  class Resource < ActiveRecord::Base
    include Boss::Pagination

    @@allowed_image_formats = ["image/jpeg", "image/gif", "image/png"]

    attr_accessible :resource, :extension
    attr_accessor :banner

    # Gets the styles from default, if it is a banner (to be refactored)
    has_attached_file :resource, :style => lambda { |attachment| attachment.banner ? STYLES['default'] : {}}
    validates_attachment :resource, :presence => true,
      :size => { :in => 0..5.megabytes }

    # Prevents from applying styles when it is not an image
    before_post_process :skip?
    
    before_save :add_extension

    class << self

      # Only creates the image if it the mime type is allowed.
      # This is not done in validates_attachment in order to allow any kind
      # of resource, not only images
      def create_image(image_info)
        @@allowed_image_formats.include?(image_info.content_type) ? Boss::Resource.create(:resource => image_info) : false
      end

      def create_file(file_info)
        Boss::Resource.create(:resource => file_info)
      end

      def all_images
        where("extension in (?)", ["jpeg","jpg","gif","png"])
      end

    end

    protected

     def add_extension
       self.extension = self.resource_file_name.match(/.+?\.([^.]*$|$)/)[1]
     end

      def skip?
        @@allowed_image_formats.include?(resource_content_type)
      end
  end
end
