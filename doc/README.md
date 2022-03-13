# Function and logical programming

---
Author: Pavel Yadlouski (xyadlo00)

---

## Functional projects

Aim of this project is to implement translation of context-free grammar to
Chomsky normal form using algorithms presented in Theoretical informatics (TIN)


### File sturcutre

`src` directory contains source code of the entire program which is splited into
following files:

1. `Main.hs` contains main control function that follows phases 
   reade content -> parse content -> remove redundant rules -> create NCF.
2. `Types.hs` contains definition of data types with getter functions.
3. `ParseInput.hs`

### Implementation
Top-level workflow of my program is following:

1. Same CLI arguments are ignored and unknown argument would case an error
2. Species in input grammar are stripped on parsing step
3. 
