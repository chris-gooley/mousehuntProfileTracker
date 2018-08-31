class ProfileIdValidator < ActiveModel::Validator
  def validate(record)
    options[:fields].each do |field|
      test_id = record.send(field)
      doc = Nokogiri::HTML(open("https://www.mousehuntgame.com/profile.php?snuid=#{test_id}"))
      error = doc.css('#tabbarpage').search("[text()*='Uh oh! A Glitchpaw']")
      if error.length > 0
        record.errors[field.to_sym] << "ID isn't valid"
      end
    end
  end
end
