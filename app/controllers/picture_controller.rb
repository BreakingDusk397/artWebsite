class PictureController < ApplicationController


    private
        def picture_params
            params.require(:photo).permit(:title, :description, :date, :location, :album_id, :image)
        end    
end
