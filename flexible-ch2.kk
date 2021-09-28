module koka-learn/flexible-ch2
public fun iter<a, e, e1>(n: int): div ((a -> e1 a) -> div (a -> e1 a))
    fn(f)
        if n == 0 then id else compi(f, iter(n - 1)(f))
public fun compi<a, b, c, e>(f: a -> e b, g: c -> e a): ((x: c) -> e b)
    fn (x) { f(g(x)) }
public fun parallel-combine(h, f, g)
    fun the-combination(arg)
        h(arg.f, arg.g)
    the-combination
