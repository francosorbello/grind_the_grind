extends Node
class_name GrindScoreCalculator

static var coefficient : float = 1.3

## Points for grinding are calculated using an exponential function.
static func calculate(base: int, level : int) -> int:
    return int(base * pow(coefficient, level))
