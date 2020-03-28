namespace :currencies do
  desc "update rate of currencies"
  task :update => :environment do
    # byebug
    res = RestClient.get("http://www.cbr.ru/scripts/XML_daily.asp")
    curs = Hash.from_xml(res)["ValCurs"]["Valute"]
    curs.each do |c|
      cur = Currency.find_by_name(c["Name"])
      if cur.present?
        cur.update_attribute(:rate, BigDecimal(c["Value"].tr(",", ".")))
      else
        Currency.create(name: c["Name"], rate: BigDecimal(c["Value"].tr(",", ".")))
      end
    end
  end 
end
