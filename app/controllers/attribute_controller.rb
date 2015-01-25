require 'rmagick'

class AttributeController < ApplicationController

    def upload
        file = params[:image]
        img = Magick::Image::from_blob(file.read)[0]

        width = img.columns
        height = img.rows

        pixels = img.dispatch 0, 0, width, 500, "RGB"

        banner_img = Magick::Image.constitute width, 500, "RGB", pixels

        new_img = Magick::Image.new(width, height + 100) {
            self.format = img.format
        }

        new_img.composite!(img, 0, 0, Magick::OverCompositeOp)
        new_img.composite!(banner_img, 0, height, Magick::OverCompositeOp)

        out = new_img

        # puts out.methods
        # puts out.rows
        # puts out.columns

        # @response.headers["Content-type"] = img.mime_type
        send_data out.to_blob, type: file.content_type, filename: file.original_filename
    end

end
