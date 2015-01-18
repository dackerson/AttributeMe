require 'rmagick'

class AttributeController < ApplicationController

    def upload
        img = Magick::Image::from_blob(params[:image].read)
        puts img.size
        puts img[0].format
        puts img[0].filename

        # @response.headers["Content-type"] = img.mime_type
        send_data img[0].to_blob, type: "image/#{img[0].format.downcase}"
    end

end
