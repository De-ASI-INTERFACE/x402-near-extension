import Lake
open Lake DSL
package «x402-near» where
  name := "x402-near"
require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"
lean_lib «X402NEAR» where
  roots := #[`X402NEAR]
