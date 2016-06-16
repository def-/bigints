import bigints, unittest

test "initBigInt":
  let a = 1234567.initBigInt
  check $a == "1234567"

  let b = -1234567.initBigInt
  check $b == "-1234567"

  let c = 123456789012345678.initBigInt
  check $c == "123456789012345678"

  let d = -123456789012345678.initBigInt
  check $d == "-123456789012345678"

  let e = int64.high.initBigInt
  check $e == $int64.high

  let f = int64.low.initBigInt
  check $f == $int64.low

  let g = (1'u64 shl 63).initBigInt
  check $g == $(1'u64 shl 63)

  let h = 1234567.initBigInt
  let i = h.initBigInt
  check $h == $i

test "range of bigint (https://github.com/def-/nim-bigints/issues/1)":
  let two = 2.initBigInt
  let n = "123".initBigInt
  var result = 1.initBigInt
  for i in two .. n:
    result *= i
  check result == initBigInt("12146304367025329675766243241881295855454217088483382315328918161829235892362167668831156960612640202170735835221294047782591091570411651472186029519906261646730733907419814952960000000000000000000000000000")

test "multiple multiplications (https://github.com/def-/nim-bigints/issues/3)":
  let nums = [ "68855123440532288245010625",
               "201850901852714536181760000",
               "435980903974422631450250625",
               "824199001261152424427520000",
               "11527258048987096618327125",
               "18960243520191483654144000" ]

  var total = 1.initBigInt

  for e in items(nums):
    let bigInt = e.initBigInt
    total *= bigInt

  check total == initBigInt("1091531901753858845417645933677882391421406095571139520376889755608568225321090455009925801178698945969179844505331560015898829746339840000000000000000000000")

test "negative bigint (https://github.com/def-/nim-bigints/issues/4)":
  let x = -initBigInt(1)
  check x == initBigInt(-1)

test "off by one in division (https://github.com/def-/nim-bigints/issues/5)":
  block:
    var x = initBigInt("815915283247897734345611269596115894272000000000")
    var y = initBigInt("5919012181389927685417441689600000000")
    check x div y == initBigInt("137846528820")

  block:
    var x = initBigInt("815915283247897734345611269596115894272000000000")
    var y = initBigInt("20000000000")
    check x div y == initBigInt("40795764162394886717280563479805794713")

test "Mod operators":
  block:
    let
      x = 10.initBigInt
      y = 2.initBigInt
      z = 3.initBigInt
    check x %% y == 0.initBigInt
    check x %% z == 1.initBigInt

  block:
    let
      x = 10.initBigInt
      y = 2'i32
      z = 3'i32
    check x %% y == 0.initBigInt
    check x %% z == 1.initBigInt
