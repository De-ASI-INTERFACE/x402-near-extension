-- ============================================================
-- x402-NEAR: Basic Re-export Shim
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: NEAR Protocol / FT Standard / Ref Finance v2
--
-- Re-exports X402NEAR.PaymentVerification as the single
-- authoritative source of all shared types and definitions.
-- Chain-prefixed theorem aliases are provided for ergonomic use.
-- ============================================================
import X402NEAR.PaymentVerification

namespace X402NEAR

/-- Alias: replay prevention under the NEAR chain prefix.
    NEAR uses a Finset of consumed contract nonces.
    result type: a.nonce ∉ s.used_nonces. -/
theorem near_replay_prevented
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.nonce ∉ s.used_nonces :=
  replay_prevented a s h

/-- Alias: block-height expiry enforcement under the NEAR chain prefix.
    Delegates to within_expiry: s.current_block ≤ a.block_expiry. -/
theorem near_not_expired
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.current_block ≤ a.block_expiry :=
  within_expiry a s h

end X402NEAR
