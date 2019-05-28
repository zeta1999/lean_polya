import .tactic

open tactic polya

meta def test (e : expr) : tactic unit :=
do
    (nt, ρ, pr) ← nterm_of_expr e,
    nt ← eval_expr (@nterm γ _) nt,
    type_check pr,
    trace nt,
    skip

constants x y z : ℝ

/- benchmak -/
set_option profiler true

/- debug -/
set_option trace.app_builder true

--sterm tests
run_cmd test `( x - x )
run_cmd test `( x * (1 / 10 : ℚ) + x * (1 / 10 : ℚ) - x * (1 / 5 : ℚ))
run_cmd test `( x * (3 : ℚ) + y * (1 : ℚ) - x * y * (2 : ℚ) - y * (2 : ℚ) )
run_cmd test `( x * y * (3 : ℚ) - x * y * (4 : ℚ) )

--pterm tests
run_cmd test `( x * x)
run_cmd test `( x / x )
run_cmd test `( (x * y) ^ 3 / x ^ 2 )

