require 'nokogiri'
require 'open-uri'

namespace :profile_scraper do
  desc "Scrape hunter profiles"
  task scrape: :environment do
    Hunter.where('last_scanned < ?', Time.now - 2.hours).each do |hunter|
      hunter.update_records
    end
  end
end
