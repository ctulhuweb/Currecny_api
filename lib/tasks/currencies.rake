namespace :currencies do
  desc "updates rate of currencies"
  task :update => :environment do
    curs = LoadCurrencies.call(url: "http://www.cbr.ru/scripts/XML_daily.asp")
    curs.each do |c|
      cur = Currency.find_by_name(c["Name"])
      if cur.present?
        cur.update_attribute(:rate, BigDecimal(c["Value"].tr(",", ".")))
      end
    end
  end
  
  desc "creates currencies"
  task :create => :environment do
    curs = LoadCurrencies.call(url: "http://www.cbr.ru/scripts/XML_daily.asp")
    curs.each do |c|
      cur = Currency.find_by_name(c["Name"])
      if cur.blank?
        Currency.create(name: c["Name"], rate: BigDecimal(c["Value"].tr(",", ".")))
      end
    end
  end
end
