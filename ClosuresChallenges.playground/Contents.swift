
var number = [2, 43, 333, 3, 6, 40, 50, 80]

var reduceMethod = number.reduce(0) { (result, current) -> Int in
    return max(result, current)
}
print(reduceMethod)
var reduceMethodShort = number.reduce(0) { max($0, $1) }
print(reduceMethodShort)



var reduceMethodAddition = number.reduce(0) { (result, current) -> Int in
    return result + current
}
print(reduceMethodAddition)
var shortHandReduceAddition = number.reduce(0) { $0 + $1 }
print(shortHandReduceAddition)
