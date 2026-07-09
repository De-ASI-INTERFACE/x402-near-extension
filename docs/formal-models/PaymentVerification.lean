-- x402-NEAR | Author: Richard Patterson
import Mathlib.Data.Finset.Basic
namespace X402NEAR
structure NEARPayment where
  nonce : Nat; amount : Nat; block_expiry : Nat
  deriving Repr
structure ContractState where
  used_nonces : Finset Nat; current_block : Nat
  deriving Repr
def verify (p : NEARPayment) (s : ContractState) : Prop :=
  p.nonce ∉ s.used_nonces ∧ s.current_block ≤ p.block_expiry
theorem near_replay_prevented (p : NEARPayment) (s : ContractState)
    (h : verify p s) : p.nonce ∉ s.used_nonces := h.1
end X402NEAR
