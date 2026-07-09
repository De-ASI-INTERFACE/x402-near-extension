-- ============================================================
-- x402-NEAR: Payment Verification Formal Proofs
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: NEAR Protocol / FT Standard / Ref Finance v2
-- ============================================================
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic
import Mathlib.Logic.Basic

namespace X402NEAR

structure PaymentAuth where
  nonce        : Nat    -- contract nonce
  amount       : Nat    -- yoctoNEAR or FT units
  block_expiry : Nat    -- block height expiry
  ft_contract  : Nat    -- FT contract account
  deriving Repr, DecidableEq

structure FacilitatorState where
  used_nonces   : Finset Nat
  current_block : Nat
  deriving Repr

def not_expired (a : PaymentAuth) (s : FacilitatorState) : Prop := s.current_block ≤ a.block_expiry
def nonce_fresh (a : PaymentAuth) (s : FacilitatorState) : Prop := a.nonce ∉ s.used_nonces
def amount_positive (a : PaymentAuth) : Prop := 0 < a.amount
def verify (a : PaymentAuth) (s : FacilitatorState) : Prop :=
  not_expired a s ∧ nonce_fresh a s ∧ amount_positive a

theorem replay_prevented (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : a.nonce ∉ s.used_nonces := h.2.1
theorem within_expiry (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : s.current_block ≤ a.block_expiry := h.1
theorem positive_amount (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : 0 < a.amount := h.2.2

def settle (a : PaymentAuth) (s : FacilitatorState) : FacilitatorState :=
  { s with used_nonces := s.used_nonces ∪ {a.nonce} }

theorem settled_nonce_used (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.nonce ∈ (settle a s).used_nonces := by
  simp [settle, Finset.mem_union, Finset.mem_singleton]

theorem post_settlement_replay_blocked (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.nonce ∈ (settle a s).used_nonces ∧ ¬a.nonce ∉ (settle a s).used_nonces := by
  constructor
  · exact settled_nonce_used a s h
  · simp [settle, Finset.mem_union, Finset.mem_singleton]

end X402NEAR
