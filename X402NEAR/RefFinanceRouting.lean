-- ============================================================
-- x402-NEAR: Ref Finance v2 Routing Invariants
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Nat.Basic
import X402NEAR.PaymentVerification

namespace X402NEAR.RefFinance

structure PoolAction where
  pool_id    : Nat
  token_in   : Nat; token_out : Nat
  amount_in  : Nat; min_amount_out : Nat
  deriving Repr

structure GatedSwap where
  auth : PaymentAuth; action : PoolAction
  deriving Repr

def route_authorized (gs : GatedSwap) (s : FacilitatorState) : Prop := verify gs.auth s
def route_sane (gs : GatedSwap) : Prop := 0 < gs.action.min_amount_out ∧ gs.auth.amount = gs.action.amount_in
def gated_swap_valid (gs : GatedSwap) (s : FacilitatorState) : Prop := route_authorized gs s ∧ route_sane gs

theorem gated_swap_requires_payment (gs : GatedSwap) (s : FacilitatorState) (h : gated_swap_valid gs s) :
    gs.auth.nonce ∉ s.used_nonces := replay_prevented gs.auth s h.1

end X402NEAR.RefFinance
