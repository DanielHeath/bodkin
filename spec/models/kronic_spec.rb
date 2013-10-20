require './app/models/kronic'
require 'active_support/all'

describe Kronic do

  START = Time.local(2012, 1, 1)
  {
    'Monday' => START + 1.days,
    'Tuesday' => START + 2.days,
    'Wednesday' => START + 3.days,
    'Thursday' => START + 4.days,
    'Friday' => START + 5.days,
    'Saturday' => START + 6.days,
    'Sunday' => START + 7.days,
  }.each do |un_desc, un_expected|
    description, expected = un_desc, un_expected

    it "handles '#{description}'" do
      expect(Kronic.parse(description, START)).to eq(expected)
    end

    it "handles '#{description} week'" do
      expect(Kronic.parse(description + " week", START)).to eq(expected + 7.days)
    end

  end

  # TODO: 2013-10-12

end
#      require 'pry'; binding.pry unless defined?(EXIT_NOW)
