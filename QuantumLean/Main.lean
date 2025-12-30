import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.NonsingularInverse
import Mathlib.Data.Fin.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

def Qubit := Fin 2 → ℂ
def QuantumRegister (n : Nat) := Fin (2^n) → ℂ
def QuantumGate (n : Nat) := Fin (2^n) → Fin (2^n) → ℂ

def qubit_zero : Qubit := fun i => if i = 0 then 1 else 0
def qubit_one : Qubit := fun i => if i = 1 then 1 else 0

noncomputable def sqrt2_inv : ℂ := 1 / Complex.ofReal (Real.sqrt 2)

noncomputable def hadamard : QuantumGate 1 := fun i j =>
  if i = 0 ∧ j = 0 then sqrt2_inv
  else if i = 0 ∧ j = 1 then sqrt2_inv
  else if i = 1 ∧ j = 0 then sqrt2_inv
  else -sqrt2_inv

def cnot : QuantumGate 2 := fun i j =>
  if i = 0 ∧ j = 0 then 1
  else if i = 1 ∧ j = 1 then 1
  else if i = 2 ∧ j = 3 then 1
  else if i = 3 ∧ j = 2 then 1
  else 0

noncomputable def apply_gate {n : Nat} (g : QuantumGate n) (ψ : QuantumRegister n) : QuantumRegister n :=
  fun i => Finset.sum Finset.univ (fun j => g i j * ψ j)

noncomputable def probability (ψ : Qubit) (state : Fin 2) : ℝ :=
  Complex.normSq (ψ state)

def isConstant (f : Bool → Bool) : Bool := f false == f true
def isBalanced (f : Bool → Bool) : Bool := f false != f true

def deutschJozsaDemo (f : Bool → Bool) : String :=
  if isConstant f then "Function is CONSTANT" else "Function is BALANCED"

def constantZero : Bool → Bool := fun _ => false
def constantOne : Bool → Bool := fun _ => true
def identity : Bool → Bool := fun b => b
def notFunction : Bool → Bool := fun b => !b

#eval deutschJozsaDemo constantZero
#eval deutschJozsaDemo constantOne
#eval deutschJozsaDemo identity
#eval deutschJozsaDemo notFunction