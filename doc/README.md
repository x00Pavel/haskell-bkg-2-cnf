# Function and logical programming

---
Author: Pavel Yadlouski (xyadlo00)

---

## Functional projects

Aim of this project is to implement translation of context-free grammar to
Chomsky normal form using algorithms presented in Theoretical informatics (TIN)


### File structure
 
`src/` directory contains source code of the entire program which is split into
the following files:

1. `Main.hs` contains main control function that follows phases
   reade content -> parse content -> remove redundant rules -> create NCF.
2. `Types.hs` contains definition of data types with getter functions.
3. `ParseInput.hs` contains functions for parsing input data including
   validation of the rules: correct syntax, correct terminals and non-terminals
4. `Minimaze.hs` contains core functionality of the program - functions for
   removing simple rules and functions for converting to the CNF

### Extra implementation details

1. Same CLI arguments are ignored and unknown argument would case an error
2. Species in input grammar are stripped on parsing step
3. Additionally to required test files in `test/` directory, there are extra
   tests in the `extra/` directory. Closer description is in the
   `doc/test-description.txt` file. Test requires PyTest framework present on
   the system. All extra tests can be executed with `make test` command in root
   directory of the program.
