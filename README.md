# x402-NEAR Extension
**HTTP 402 Payment-Gated Routing on NEAR Protocol**
**Author:** Richard Patterson (@De-ASI-INTERFACE) | **Version:** 1.0.0 | **Date:** 2026-07-09 | **License:** MIT

## Overview
The x402-NEAR Extension adapts the x402 HTTP 402 payment standard to NEAR Protocol using NEAR's account-based model, Function Call access keys, and Rust-based smart contracts. It defines `scheme: near-ft` for NEP-141 Fungible Token payments and `scheme: near-native` for native NEAR payments, with Ref Finance v2 as the canonical AMM routing surface. Near's unique account model enables named account payment authorization (e.g. `facilitator.x402.near`). Lean 4 proofs verify nonce replay prevention and block height expiry.
**Reference ID:** RP-DEASI-NEAR-2026-0709-001
