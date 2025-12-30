import Lake
open Lake DSL

package "quantum-lean" where
  -- Quantum computing simulation in Lean 4

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

lean_lib «QuantumLean» where
  -- add library configuration options here

@[default_target]
lean_exe "quantum-lean" where
  root := `Main
