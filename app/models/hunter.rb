class Hunter < ApplicationRecord
  has_secure_password
  has_many :profile_records, dependent: :destroy

  validates :email, :profile_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true
  validates_with ProfileIdValidator, fields: [:profile_id]

  before_validation :strip_whitespace
  after_create :update_records

  def team_members
    Hunter.where({ team: team }).order(:name)
  end

  def update_records
    # This should be put else where (ie a rake task)
    record = profile_records.build

    doc = Nokogiri::HTML(open("https://www.mousehuntgame.com/profile.php?snuid=#{profile_id}"))

    camp_info = doc.css(".campLeft")

    # Breeds Info
    common_breeds_str, event_breeds_str = camp_info.css('.breedscaught').first.inner_html.split('<br>')

    common_breeds = common_breeds_str.match(/^Breeds\sCaught:\s(\d{1,3})\s\/\s(\d{1,3})$/)
    event_breeds  = event_breeds_str.match(/^Event\sBreeds\sCaught:\s(\d{1,3})\s\/\s(\d{1,3})$/)

    record.breeds_caught = common_breeds[1]
    record.breeds_total  = common_breeds[2]

    record.event_breeds_caught = event_breeds[1]
    record.event_breeds_total = event_breeds[2]

    # Run through the rest of the data
    camp_info.css('span.label').each do |label|
      param_name = label.text.strip.gsub(/[\s:"']/,'').underscore
      case param_name
      when "team"
        self.update_attribute(:team, label.next.text) if team != label.next.text
      when "hunting_since"
        self.update_attribute(:started_hunting, label.next.text) if started_hunting.blank?
      when "hunters_title"
        m = label.next.text.match(/^(.*)\s(?=\()\((\d+)%\)$/)
        record.title = m[1]
        record.title_progress = m[2]
      when "weapon"
        record.trap = label.next.text
      when "total_luck"
        record.trap_luck = label.next.text.to_i
      when "bait"
        if b = label.next.text.strip.match(/^(\d+)\spieces\sof\s(.+)$/)
          record.bait_name = b[2]
          record.bait_amount = b[1]
        else
          record.bait_name = 'None'
          record.bait_amount = 0
        end

      when "points", "gold", "horn_calls", "trap_power", "total_luck"
        record.send("#{param_name}=", label.next.text.gsub(',','').to_i)
      else
        record.send("#{param_name}=", label.next.text)
      end
    end
    record.save
    self.update_attribute(:last_scanned, Time.now)
  end

  def strip_whitespace
    self.name = self.name.strip unless self.name.nil?
    self.email = self.email.downcase.strip unless self.email.nil?
  end
end
