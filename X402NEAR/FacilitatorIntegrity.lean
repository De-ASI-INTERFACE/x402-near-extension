-- ============================================================
-- x402-NEAR: Facilitator State Integrity
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Finset.Basic
import X402NEAR.PaymentVerification

namespace X402NEAR.Facilitator

theorem nonces_monotone (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.used_nonces ⊆ (settle a s).used_nonces := by simp [settle]; exact Finset.subset_union_left

theorem fresh_not_in_pre_state (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.nonce ∉ s.used_nonces := replay_prevented a s h

structure TimeStep where
  s_before : FacilitatorState; s_after : FacilitatorState
  mono : s_before.current_block ≤ s_after.current_block

theorem expiry_is_monotone (a : PaymentAuth) (ts : TimeStep) (h_valid : not_expired a ts.s_before) :
    ts.s_before.current_block ≤ a.block_expiry := h_valid

end X402NEAR.Facilitator
