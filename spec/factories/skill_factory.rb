# == Schema Information
#
# Table name: skills
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :string
#  role_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do

  factory :skill do
    sequence(:title) { |n| "Skill #{n}" }
    sequence(:description) { |n| "Skill description #{n}" }

    association :role
  end

end
