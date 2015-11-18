require 'minitest/autorun'
# require 'minitest/rg'
require 'oga'
require 'open-uri'
require 'yaml'
require 'json'
require 'vcr'
require 'webmock/minitest'
require './lib/taiwan_tours/lonelyplanet_scrap'
require './spec/support/vcr_setup'

tours_from_file = YAML.load(File.read('./spec/tours.yml'))

VCR.use_cassette('taiwan_tours') do
  obj = LonelyPlanetScrape::LonelyPlanetTours.new
  tours_found = JSON.parse(obj.tours) if !obj.tours.nil?

  describe 'Validate structure of result' do

    it 'check if the number of taiwan tours has changed' do
      tours_found.size.must_equal tours_from_file.size
    end

    0.upto(tours_from_file.length - 1) do |index|
    it 'check if price exist and is not empty' do
      refute_empty tours_found[index]['price'] , "Expect Price not empty value for Object #{index}"
      refute_nil tours_found[index]['price'] , "Expect Price not nil value for Object #{index}"
    end

    it 'check for title changes' do
      refute_empty tours_found[index]['title'], "Expect Tittle not empty value for Object #{index}"
    end

    it 'check for description changes' do
      refute_empty tours_found[index]['content'], "Expect description not value for Object #{index}"
    end
   end  
  end
end
