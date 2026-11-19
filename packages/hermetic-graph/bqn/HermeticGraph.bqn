# Hermetic graph recursion: closed two-node witness graph.
# No IO, mutable global state, external service, or historical inference.
# State vector is a 2-element numeric list.
A ← [0‿1, 1‿0]              # symmetric graph adjacency: swap vertices
D ← [89‿0, 0‿2462]          # chronology labels as a diagonal operator
Mul ← +˝∘×⏎1‿∞             # matrix-vector/matrix product

# Left and right operator ordering: A(Dv) versus D(Av).
Commutator ← { (A Mul (D Mul 𝓩)) - (D Mul (A Mul 𝓩)) }

# Recursion carries both a remaining step count and a vector.
Orbit ← { n‿v ← 𝓩 ⋄ n=0 ? v ; 𝕊 (n-1)‿(A Mul v) }

# A finite exact witness of noncommutativity.
v ← 1‿0
! (Commutator v) ≡ 0‿¯2373
! (Orbit 2‿v) ≡ v
! (Orbit 1‿v) ≡ 0‿1

# Sovereign theta remains separate from the graph operator:
Theta ← 89÷2462
! Theta > 0
