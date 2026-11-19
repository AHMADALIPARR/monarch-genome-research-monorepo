/-!
  Genome/Cognition bridge. Mathematical abstraction ONLY.
  No genome-to-cognition biological causal relation is asserted.
-/
namespace GenomeCognitionBridge

structure CognitiveState where
  agency : Nat
  orientation : Nat
  distress : Nat
  functioning : Nat
  deriving DecidableEq, Repr

structure GenomeState where
  identity : Nat
  deriving DecidableEq, Repr

structure Observation where
  genome : GenomeState
  cognition : CognitiveState

/-- A bounded ordinal score, modeling the research scale 0..4. -/
def bounded (s : CognitiveState) : Prop :=
  s.agency ≤ 4 ∧ s.orientation ≤ 4 ∧
  s.distress ≤ 4 ∧ s.functioning ≤ 4

/-- A genome identity-preserving transition need not preserve cognition. -/
def preserveGenome (x y : Observation) : Prop :=
  x.genome = y.genome

/-- Explicit witness: identical modeled genomes, different cognitions. -/
def before : Observation :=
  ⟨⟨0⟩, ⟨2,3,2,2⟩⟩
def after : Observation :=
  ⟨⟨0⟩, ⟨3,3,1,3⟩⟩

theorem genome_preserved : preserveGenome before after := by
  rfl

theorem cognition_can_differ : before.cognition ≠ after.cognition := by
  decide

end GenomeCognitionBridge
