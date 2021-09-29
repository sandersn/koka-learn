public module flexible-ch2
fun iter<a, e, e1>(n: int): div ((a -> e1 a) -> div (a -> e1 a))
    fn(f)
        if n == 0 then id else compi(f, iter(n - 1)(f))
fun compi<a, b, c, e>(f: a -> e b, g: c -> e a): ((x: c) -> e b)
    fn (x) { f(g(x)) }
fun parallel-combine(h, f, g)
    fun the-combination(arg)
        h(arg.f, arg.g)
    the-combination
val r-dot = "."
val r-bol = "^"
val r-eol = "$"
fun r-quote(s: string) { s }
fun r-char-from(s: string) { "[" ++ s ++ "]" }
fun r-alt (pattern: list<string>): string
    pattern.join("|")

val gas-constant = 8.3144621 // J/K*mol
val l = [1,2,3]
fun sphere-radius(volume: double): double
    (volume / 4 / 3 * 3.14159) ^ (1/3)
fun gas-law-volume(args: list<double>): double
    match args
        [pressure, temperature, amount] -> amount * gas-constant * temperature / pressure
        _ -> 0.0
struct unit-conversion
    from: (double -> double)
    to: (double -> double)
val fahrenheit-to-celsius = Unit-conversion(
    to = fn (f) { (f - 32.0) * 5.0 / 9.0 },
    from = fn (c) { c * 9.0 / 5.0 + 32.0 }
)
val zero-celsius = 273.0
val celsius-to-kelvin = Unit-conversion(
    to = fn (c) { c + zero-celsius },
    from = fn (k) { k - zero-celsius }
)
alias unit = (args: list<double>) -> double
alias conversion = (input: double) -> double
alias alist<a> = list<(string, a)>
fun converter ()
    val conversions = [
        ("celsius|kelvin", celsius-to-kelvin.to),
        ()
    ]
    fun lookup-converter (from: string, to: string): maybe<conversion>
        val key: string = from ++ "|" ++ to
        match conversions.find (fn ((k,_)) { k == key })
            Just ((_,v)) -> Just(v)
            Nothing -> Nothing
    // struct converter
    //     questionMark: int
    fun unit-specialiser(procedure: unit, implicit-output-unit: string, implicit-input-units: list<string>)
        fun specialiser(specific-output-unit: string, specific-input-units: list<string>): unit
            val output-converter = lookup-converter(implicit-output-unit, specific-output-unit)
            val input-converters = zipwith(implicit-input-units, specific-input-units, lookup-converter)
            fn (args: list<double>): double
                val result = procedure(zipwith(args, input-converters, (fn (arg,conv) {
                                                                                match conv {
                                                                                    Just(c) -> c(arg)
                                                                                    Nothing -> 0.0
                                                                                }
                                                                            })))
                match output-converter
                    Just(oc) -> oc(result)
                    Nothing -> 0.0
        specialiser
    val make-specialised-gas-law-volume = unit-specialiser(gas-law-volume, "m^3", ["newton / m^2", "kelvin", "mole"])
    val imperial-gas-law-volume: unit = make-specialised-gas-law-volume("inch^3", ["pound / inch^2", "fahrenheit", "mole"])
    ()