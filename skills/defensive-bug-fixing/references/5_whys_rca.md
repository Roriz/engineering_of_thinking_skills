# 5 Whys Root Cause Analysis (RCA) Guide and Causal Matrix

Root Cause Analysis ensures that software fixes resolve fundamental design, concurrency, state management, or resource allocation defects rather than applying superficial band-aids.

## The 5 Whys Methodology

For every bug, construct a 5-step causal sequence:

```text
Symptom: Exception / Crash
  └── Why 1? (Immediate Failure)
       └── Why 2? (Invalid State Origin)
            └── Why 3? (Uncoordinated Upstream Process)
                 └── Why 4? (Synchronization / Validation Gap)
                      └── Why 5? (ROOT CAUSE: Fundamental Flaw)
```

### Example 1: TOCTOU Cache Invalidation Race Condition (SPEC-ENG-BUG-0042)

1. **Why did the application throw `TypeError`?**
   - Because `userProfile` was `undefined` inside `calculateBillingTier()`.
2. **Why was `userProfile` undefined?**
   - Because the Redis cache key was evicted mid-execution during the asynchronous database update.
3. **Why was the Redis cache key evicted mid-execution?**
   - Because the webhook handler triggered an asynchronous cache invalidation event concurrently without holding a lock or acquiring a transaction snapshot.
4. **Why were concurrent webhooks running without coordination?**
   - Because the message queue partition key was set to `EventID` instead of `UserID`, causing parallel processing of events for the same user across multiple workers.
5. **ROOT CAUSE**:
   - **Flawed Queue Partitioning Strategy and Unprotected Shared State Mutation**. The system lacked strict message ordering per user and lacked optimistic concurrency locking on subscription state.

---

### Example 2: WASM Size / Instantiation Failure (`tmp/rollbar/error.json`)

1. **Why did the application throw `CompileError`?**
   - Because `WebAssembly.instantiateStreaming` rejected with "function body too big".
2. **Why was the function body too big?**
   - Because LTO (Link-Time Optimization) or code splitting was disabled in the WASM build configuration, producing monolithic un-optimized WASM functions.
3. **Why were functions un-optimized in production build?**
   - Because the release profile build flags in Cargo workspace missed size-optimization flags (`opt-level = 'z'`).
4. **Why were size flags missing in WASM build script?**
   - Because WASM build scripts ran default dev/fast release profiles without checking binary size limits.
5. **ROOT CAUSE**:
   - **Unbounded WASM Binary Compilation and Missing Optimization Fingerprint Validation**. Build pipeline lacked automated size checks and release profile optimization enforcement.

---

## Behavioral Impact Matrix Template

When proposing a root fix, evaluate the impact across four standard vectors:

| Vector | Before Fix (Flawed Behavior) | After Fix (Remediated State) |
| :--- | :--- | :--- |
| **Concurrency Safety** | Race window during async operations | Locks / mutexes / partition keys guarantee sequential consistency |
| **Null Safety** | Implicit state assumption, unhandled errors | Explicit validation, typed errors, immutable local snapshots |
| **Error Recovery** | Process crash, partial DB state | Transactional rollback, clean HTTP status, correlation logging |
| **Performance / Latency** | Unlocked latency (unsafe) | Acceptable lock/validation overhead for full data integrity |
