# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Tag do
  it "can sanitize name" do
    Tag.sanitize_name("  ab -- ++ rah am   ").should eq("abraham")
  end
  it "can sanitize blank name" do
    Tag.sanitize_name('').should eq('')
  end
  it "can sanitize null" do
    Tag.sanitize_name(nil).should eq('')
  end
end
