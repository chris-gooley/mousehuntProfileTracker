class ProfileRecord < ApplicationRecord
  belongs_to :hunter

  default_scope { order(created_at: :asc) }

  def created_js_time
    created_at.to_i * 1000
  end

  def location_image
    if File.exists?("#{Rails.root}/public/location_images/#{location.downcase.gsub(/[\s'"]/i,'')}.jpg")
      "#{location.downcase.gsub(/[\s'"]/i,'')}"
    else
      "unknown"
    end

  end

end
