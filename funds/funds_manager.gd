extends Node
class_name FundsManager
@export var prices : Dictionary[Global.StatType,PriceResource]
@export var funds : FundRes

func purchase_stat(stat : Global.StatType):
    var price_res : PriceResource = prices.get(stat)
    if price_res:
        var price : int = price_res.get_price()
        funds.subtract_funds(price)
        price_res.increment_upgrade()
    pass
