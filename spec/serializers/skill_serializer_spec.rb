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

require "rails_helper"

describe SkillSerializer, :type => :serializer do

  context "individual resource representation" do
    let(:resource) { create(:skill) }

    let(:serializer) { SkillSerializer.new(resource) }
    let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }

    context "root" do
      subject do
        JSON.parse(serialization.to_json)["data"]
      end

      it "has an attributes object" do
        expect(subject["attributes"]).not_to be_nil
      end

      it "has an relationships object" do
        expect(subject["relationships"]).not_to be_nil
      end

      it "has an id" do
        expect(subject["id"]).not_to be_nil
      end

      it "has a type set to 'projects'" do
        expect(subject["type"]).to eq "skills"
      end
    end

    context "attributes" do

      subject do
        JSON.parse(serialization.to_json)["data"]["attributes"]
      end

      it "has a 'title'" do
        expect(subject["title"]).to eql resource.title
      end

      it "has a 'description'" do
        expect(subject["description"]).to eql resource.description
      end
    end

    context "relationships" do
      subject do
        JSON.parse(serialization.to_json)["data"]["relationships"]
      end

      it "contains a 'role' relationship" do
        expect(subject["role"]).not_to be_nil
        expect(subject["role"]["data"]["type"]).to eq "roles"
        expect(subject["role"]["data"]["id"]).to eq resource.role.id.to_s
      end
    end

    context "included" do
      subject do
        JSON.parse(serialization.to_json)["included"]
      end

      it "should be empty" do
        expect(subject).to be_nil
      end
    end
  end
end
