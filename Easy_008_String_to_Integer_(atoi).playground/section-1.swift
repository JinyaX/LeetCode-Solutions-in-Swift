/*

https://oj.leetcode.com/problems/string-to-integer-atoi/

#8 String to Integer (atoi)

Level: easy

Implement atoi to convert a string to an integer.

Hint: Carefully consider all possible input cases. If you want a challenge, please do not see below and ask yourself what are the possible input cases.

Notes: It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible to gather all the input requirements up front.

Update (2015-02-10):
The signature of the C++ function had been updated. If you still see your function signature accepts a const char * argument, please click the reload button  to reset your code definition.

Requirements for atoi:
The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

If no valid conversion could be performed, a zero value is returned. If the correct value is out of the range of representable values, INT_MAX (2147483647) or INT_MIN (-2147483648) is returned.

Inspired by @yuruofeifei at https://oj.leetcode.com/discuss/8886/my-simple-solution

*/

// Helper
extension String {
    subscript (index: Int) -> Character {
        return self[advance(self.startIndex, index)]
    }
}

extension String.UTF8View {
    subscript (index: Int) -> UTF8.CodeUnit {
        return self[advance(self.startIndex, index)]
    }
}

func atoi(str: String) -> Int {
    var sign: Bool = true   // positive by default
    var base: Int = 0, i: Int = 0
    while str[i] == " " {
        i++
    }
    if str[i] == "-" {
        sign = false
        i++
    } else if str[i] == "+" {
        sign = true
        i++
    }

    var zero: Int = Int(String("0").utf8[0])
    var nine: Int = Int(String("9").utf8[0])

    var len: Int = count(str)
    var tmp: Int = Int(str.utf8[i])

    while tmp >= zero && tmp <= nine {
        if base > Int.max/10 || (base == Int.max/10 && tmp > zero + 7) {
            if sign {
                return Int.max
            } else {
                return Int.min
            }
        }
        base = tmp - zero + 10 * base
        ++i
        if i < len {
            tmp = Int(str.utf8[i])
        } else {
            break
        }
    }

    if sign {
        return base
    } else {
        return 0 - base
    }
}

"123"

atoi("123")                     //123
atoi("     123")                //123
atoi("    +123")                //123
atoi("-123")                    //-123
atoi("    -123")                //-123
atoi(String(Int.max))           //9223372036854775807
atoi("  9223372036854775808")   //9223372036854775807, overflow
atoi("  9223372036854775806")   //9223372036854775806
atoi(String(Int.min))           //-9223372036854775808
atoi(" -9223372036854775809")   //9223372036854775808, overflow
atoi(" -9223372036854775806")   //-9223372036854775806
