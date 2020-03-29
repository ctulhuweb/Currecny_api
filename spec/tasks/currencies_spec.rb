require "rails_helper"

describe "currencies" do 
  before(:all) do
    Rails.application.load_tasks
  end

  describe ":create" do
    it "creates currencies" do
      task = Rake::Task["currencies:create"] 
      expect { task.invoke }.to change { Currency.count }
    end
  end

  describe ":update" do
    before(:each) do
      Rake::Task["currencies:create"].reenable
      Rake::Task["currencies:create"].invoke
    end

    it "updates existing currencies" do
      currency = Currency.first
      currency.update_attribute("rate", 88.1234)
      task = Rake::Task["currencies:update"]
      expect{ task.invoke }.to change { currency.reload.rate }
    end
  end
end