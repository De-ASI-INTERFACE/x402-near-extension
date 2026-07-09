-- x402-NEAR Payment Verification | Author: Richard Patterson
import X402NEAR.Basic

namespace X402NEAR.Verification

def settle (p : NEARPayment) (s : ContractState) (h : verify p s) : ContractState :=
  { s with used_nonces := s.used_nonces ∪ {p.nonce} }

theorem settled_nonce_recorded (p : NEARPayment) (s : ContractState) (h : verify p s)
    : p.nonce ∈ (settle p s h).used_nonces := by
  simp [settle, Finset.mem_union, Finset.mem_singleton]

end X402NEAR.Verification
