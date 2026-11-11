#!/usr/bin/env bash
# Syntax check for the asi / ARIA repo.
# FAILS (exit 1) on any syntax error — unlike the old CI, which swallowed
# every failure and printed SUCCESS unconditionally.
# Used by `npm test` and by .github/workflows/ci.yml: one source of truth.
# Python-like files are listed explicitly because several have no .py
# extension (agi, agi2.0, asi.py2.0, asi.py3.0).
set -u
fail=0

echo "== JavaScript: node --check =="
for file in *.js lib/*.js; do
    if ! node --check "$file"; then
        echo "FAIL: $file"
        fail=1
    fi
done

echo "== Python: python3 -m py_compile =="
for file in aeon.py asi.py infinite_bitcoin_mining_simulator.py omega_integration.py omega_society.py omega_society_infinite.py asi.py2.0 asi.py3.0 agi agi2.0; do
    if ! python3 -m py_compile "$file"; then
        echo "FAIL: $file"
        fail=1
    fi
done

if [ "$fail" -ne 0 ]; then
    echo "SYNTAX CHECK FAILED"
    exit 1
fi
echo "SYNTAX CHECK PASSED"
