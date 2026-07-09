# x402-NEAR Specification
**Author:** Richard Patterson | **Ref:** RP-DEASI-NEAR-2026-0709-001

## Native NEAR Schema (`scheme: near-native`)
```json
{ "scheme": "near-native", "network": "mainnet",
  "sender": "<account.near>", "facilitator": "facilitator.x402.near",
  "amount": "<yoctoNEAR-u128>", "nonce": "<u64>",
  "blockHeightExpiry": "<u64>", "signature": "<ed25519-sig>" }
```

## NEP-141 FT Schema (`scheme: near-ft`)
```json
{ "scheme": "near-ft", "tokenContract": "usdc.token.near",
  "amount": "<u128>", "sender": "<account.near>",
  "facilitator": "facilitator.x402.near",
  "nonce": "<u64>", "blockHeightExpiry": "<u64>",
  "msg": "<ft_transfer_call-msg-json>", "signature": "<ed25519-sig>" }
```

## NEAR-Specific Invariants
1. **Named Account Authorization:** Payment tied to human-readable NEAR account ID
2. **Function Call Access Key:** Restricted key can only authorize x402 payment calls
3. **Block Height Expiry:** `env::block_height() <= blockHeightExpiry`
4. **ft_transfer_call Atomicity:** NEP-141 transfer and swap execute in single cross-contract call
5. **Nonce Replay Prevention:** Contract state map `used_nonces: LookupMap<u64, bool>`
