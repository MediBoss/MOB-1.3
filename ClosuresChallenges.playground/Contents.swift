var numbers = [1, 2, 3, 4]
var evenAndSquareProduct = numbers.filter({$0 % 2 == 0}).map({$0 * $0}).reduce(1, { $0 * $1 })


print(evenAndSquareProduct)
