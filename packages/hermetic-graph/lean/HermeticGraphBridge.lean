-- Finite graph-space witness; algebra only, not physical metrology.
-- Original chronology value 89/2462 is tracked separately.
namespace HermeticGraphBridge

abbrev State := Int × Int

def adjacency (v : State) : State := (v.2, v.1)
def chronology (v : State) : State := (89 * v.1, 2462 * v.2)
def commutator (v : State) : State :=
  let av := adjacency (chronology v)
  let va := chronology (adjacency v)
  (av.1 - va.1, av.2 - va.2)

def orbit : Nat → State → State
  | 0, v => v
  | n + 1, v => orbit n (adjacency v)

theorem commutator_witness : commutator (1, 0) = (0, -2373) := by
  decide

theorem adjacency_involution (v : State) :
    adjacency (adjacency v) = v := by
  cases v
  rfl

theorem orbit_two (v : State) : orbit 2 v = v := by
  simp [orbit, adjacency_involution]

theorem commutator_nonzero : commutator (1, 0) ≠ (0, 0) := by
  decide

end HermeticGraphBridge
