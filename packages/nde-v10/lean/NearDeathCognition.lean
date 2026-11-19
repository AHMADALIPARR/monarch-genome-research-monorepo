namespace NearDeathCognition

/-- Source-attributed study aggregates are not individual observations. -/
structure StudyAggregate where
  sample : Nat
  reported : Nat
  countBound : reported ≤ sample

/-- A sample cannot contain more reports than people counted. -/
theorem reports_le_sample (s : StudyAggregate) : s.reported ≤ s.sample :=
  s.countBound

/-- Published Dutch cardiac-arrest cohort aggregate. -/
def dutchStudy : StudyAggregate := ⟨344, 62, by decide⟩

theorem dutch_count_invariant : dutchStudy.reported ≤ dutchStudy.sample := by
  decide

/-- A synthetic observation keeps evidence classification separate from experience. -/
structure Observation where
  experienceReported : Bool
  independentlyVerified : Bool

/-- Reporting an experience does not logically imply independent verification. -/
theorem report_does_not_force_verification :
    ∃ o : Observation, o.experienceReported = true ∧ o.independentlyVerified = false := by
  exact ⟨⟨true, false⟩, rfl, rfl⟩

end NearDeathCognition
