module koka-learn/basic
import std/num/double
// todo
fun fibonacci(n: int): div int
    fib(n, 0, 1)
fun fib(n: int, x1: int, x2: int): div int
    if n <= 0 
        then x1 
        else fib(n - 1, x2, x1 + x2)
fun encode(s: string, shift = 3)
    s.map fn (c)
        if c < 'a' || c > 'z' return c
        val base = (c - 'a').int
        val rot = (base + shift) % 26
        (rot.char + 'a')
fun caesar(s: string): string
    s.encode(3)
// The letter frequency table for English
val english = [8.2,1.5,2.8,4.3,12.7,2.2,
               2.0,6.1,7.0,0.2,0.8,4.0,2.4,
               6.7,7.5,1.9,0.1, 6.0,6.3,9.1,
               2.8,1.0,2.4,0.2,2.0,0.1]
fun percent(n: int, m: int)
    100.0 * (n.double/ m.double)
public fun rotate(xs, n)
    xs.drop(n) ++ xs.take(n)
fun freqs(s: string): list<double>
    val lowers = list('a', 'z')
    val occurs = lowers.map(fn (c) { s.count(c.string) })
    val total = occurs.sum
    occurs.map(fn (i) { percent(i, total) })
fun chisqr(xs: list<double>, ys: list<double>): double
    zipwith(xs, ys, fn (x,y) { ((x - y).abs)/y}).sum
public fun uncaesar(s: string): string
    val table = freqs(s)
    val chitab = list(0,25).map fn(n) { chisqr(table.rotate(n), english) }
    val min = chitab.minimum
    val shift = chitab.index-of(fn (f) { f == min }).negate
    s.encode(shift)
public fun main()
    12.fibonacci.show.println