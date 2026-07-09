-- x402-NEAR Basic | Author: Richard Patterson (@De-ASI-INTERFACE)
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace X402NEAR

structure NEARPayment where
  nonce        : Nat
  amount       : Nat
  block_expiry : Nat
  deriving Repr, DecidableEq

structure ContractState where
  used_nonces   : Finset Nat
  current_block : Nat
  deriving Repr

def verify (p : NEARPayment) (s : ContractState) : Prop :=
  p.nonce ∉ s.used_nonces ∧ s.current_block ≤ p.block_expiry

theorem near_replay_prevented (p : NEARPayment) (s : ContractState) (h : verify p s)
    : p.nonce ∉ s.used_nonces := h.1

theorem near_not_expired (p : NEARPayment) (s : ContractState) (h : verify p s)
    : s.current_block ≤ p.block_expiry := h.2

end X402NEAR
