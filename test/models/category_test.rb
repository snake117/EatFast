# == Schema Information
#
# Table name: categories
#
#  id             :bigint           not null, primary key
#  name           :string(100)      not null
#  display_name   :string(100)      not null
#  slug           :string
#  ancestry       :string           not null
#  ancestry_depth :integer          default(0)
#  children_count :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
