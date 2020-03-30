namespace :currencies do
  desc "updates rate of currencies"
  task :update => :environment do
    curs = LoadCurrencies.call
    curs.each do |c|
      cur = Currency.find_by_name(c[:name])
      if cur.present?
        cur.update_attribute(:rate, c[:rate])
      end
    end
  end
  
  desc "creates currencies"
  task :create => :environment do
    curs = LoadCurrencies.call
    Currency.insert_all(curs.map { |c| { name: c[:name], rate: c[:rate], created_at: Time.now, updated_at: Time.now } })
  end
end
