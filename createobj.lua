local createobj = {}
card = require('obj.card')
deposit = require('obj.deposit')
createobj.card = function (x, y)
    newCard = card.new(x, y)
    return newCard
end

createobj.deposit = function(x, y)
    newDeposit = deposit.new(x, y)
    return newDeposit
end

return createobj