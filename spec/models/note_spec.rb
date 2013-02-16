require 'spec_helper'

describe Note do

  def filter(given)
    Note.filter_tags(given).map(&:name).to_set
  end

  it "filters tag list right with correct input" do
    tgs = %w(ter per mer)
    given = tgs.join(', ')# "ter, per, mer"
    assert filter(given).should eq(tgs.to_set)
  end
  it "filters tag list with garbage" do
    expects = %w(dsa ddd dd).to_set
    given = "dsa, dsa, ddd,dsa , dd ,, +-&*^*&,dsa"
    assert filter(given).should eq(expects)
  end
end