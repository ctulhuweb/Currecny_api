class LoadCurrencies
  include Callable

  def initialize
    @url = "http://www.cbr.ru/scripts/XML_daily.asp"
  end

  def call
    res = RestClient.get(@url)
    curs = Hash.from_xml(res)["ValCurs"]["Valute"]
    curs.map { |a| {name: a["Name"], rate: parse_rate(a["Value"]) } }
  end

  def parse_rate(str)
    BigDecimal(str.tr(",", "."))
  end

end