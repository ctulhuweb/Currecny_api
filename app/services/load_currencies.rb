class LoadCurrencies
  include Callable

  def initialize(url:)
    @url = url
  end

  def call
    res = RestClient.get(@url)
    Hash.from_xml(res)["ValCurs"]["Valute"]
  end

end