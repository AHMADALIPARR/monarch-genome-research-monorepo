# monarch-genome-research-monorepo — one command validates the whole repo.
#
#   make check   run every check that can run here
#
# Tools are detected, never assumed. A missing tool is reported as SKIP,
# not hidden and not a pass. A runnable check that fails fails the build.
# Each package is checked with its real toolchain, by execution.

LEAN   := $(shell command -v lean 2>/dev/null || ls $(HOME)/.elan/bin/lean 2>/dev/null || echo "")
SWIPL  := $(shell command -v swipl 2>/dev/null || echo "")
PYTHON := $(shell command -v python3 2>/dev/null || echo "")
BQN    := $(shell command -v bqn 2>/dev/null || echo "")
CC     := $(shell command -v cc 2>/dev/null || command -v gcc 2>/dev/null || echo "")

LEAN_FILES := packages/hermetic-graph/lean/HermeticGraphBridge.lean \
              packages/genome-cognition/lean/GenomeCognitionBridge.lean \
              packages/nde-v10/lean/NearDeathCognition.lean

PL_FILES := packages/claims-corpus/src/monarch_claims.pl \
            packages/recovery/src/monarch_recovery.pl \
            packages/post-recovery/src/monarch_post_recovery.pl \
            packages/torus-chronology/src/monarch_torus_analysis.pl \
            packages/genome-cognition/prolog/genome_cognition.pl \
            packages/nde-v10/prolog/nde_research.pl \
            packages/gcp-import-v11/gcp_observations.pl

.PHONY: check check-c check-lean check-prolog check-python check-bqn clean

check: check-c check-lean check-prolog check-python check-bqn
	@echo "== make check: all runnable checks finished (SKIP lines above mark absent tools) =="

# C: the torus simulation compiles and runs, and prints its CSV table.
# It also writes torus_synthetic_trace.csv to the working directory,
# so run it from /tmp to keep the repo clean.
check-c:
	@if [ -z "$(CC)" ]; then echo "SKIP check-c: no C compiler (cc/gcc) on PATH"; else \
	  $(CC) -O2 -std=c11 -Wall -Wextra -o /tmp/torus_sim_check packages/torus-chronology/src/monarch_torus_sim.c -lm && \
	  (cd /tmp && /tmp/torus_sim_check) | head -1 | grep -q '^phase,observations' && \
	  echo "PASS check-c: torus_sim compiles and runs"; \
	fi

# Lean 4: the three standalone files typecheck. They import nothing,
# so plain `lean` suffices (no Mathlib project needed).
check-lean:
	@if [ -z "$(LEAN)" ]; then echo "SKIP check-lean: no lean binary (PATH or ~/.elan/bin/lean)"; else \
	  for f in $(LEAN_FILES); do "$(LEAN)" "$$f" || exit 1; done; \
	  echo "PASS check-lean: 3 Lean files typecheck, 0 errors"; \
	fi

# SWI-Prolog: every .pl file consult-loads with no ERROR output (an
# undefined exported predicate is a failure, not a warning), the
# post-recovery plunit suite passes, and the GCP well_formed(0) goal
# succeeds.
check-prolog:
	@if [ -z "$(SWIPL)" ]; then echo "SKIP check-prolog: no swipl on PATH"; else \
	  for f in $(PL_FILES); do \
	    out=$$("$(SWIPL)" -q -s "$$f" -g halt 2>&1); ec=$$?; \
	    if [ $$ec -ne 0 ]; then echo "FAIL check-prolog: $$f consult exit $$ec"; echo "$$out"; exit 1; fi; \
	    if echo "$$out" | grep -q 'ERROR'; then echo "FAIL check-prolog: $$f consult produced ERROR:"; echo "$$out" | grep 'ERROR' | head -5; exit 1; fi; \
	  done; \
	  echo "PASS check-prolog: 7 Prolog files consult-load, no ERROR"; \
	  (cd packages/post-recovery/src && "$(SWIPL)" -q -s test_monarch_post_recovery.pl -g run_tests -t halt) || exit 1; \
	  echo "PASS check-prolog: post-recovery plunit suite (10 tests)"; \
	  "$(SWIPL)" -q -s packages/gcp-import-v11/gcp_observations.pl -g "well_formed(0), halt" -t halt || exit 1; \
	  echo "PASS check-prolog: gcp well_formed(0)"; \
	fi

# Python: the genome-stack SPARQL runner lists its queries (needs rdflib).
# A real query needs packages/genome-stack/genome_stack.ttl, which is not
# in this repo; see STATUS.md. Only the runnable part is checked here.
check-python:
	@if [ -z "$(PYTHON)" ]; then echo "SKIP check-python: no python3 on PATH"; \
	elif ! "$(PYTHON)" -c "import rdflib" 2>/dev/null; then echo "SKIP check-python: rdflib not installed (pip install 'rdflib>=7')"; else \
	  "$(PYTHON)" packages/genome-stack/query.py list > /dev/null || exit 1; \
	  echo "PASS check-python: query.py lists SPARQL queries"; \
	fi

# CBQN: the hermetic graph witness runs.
check-bqn:
	@if [ -z "$(BQN)" ]; then echo "SKIP check-bqn: no bqn on PATH"; else \
	  "$(BQN)" packages/hermetic-graph/bqn/HermeticGraph.bqn > /dev/null || exit 1; \
	  echo "PASS check-bqn: HermeticGraph.bqn runs"; \
	fi

clean:
	@rm -f /tmp/torus_sim_check
	@echo "clean: removed check artifacts"
