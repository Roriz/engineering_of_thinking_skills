# Rollbar Error Payload Extraction and Parsing Guide

When diagnosing production defects from Rollbar error export JSON files (such as `tmp/rollbar/error.json`), systematically extract data across these sections:

## 1. Top-Level Telemetry and Environment

| Field Path | Target Property | Purpose |
| :--- | :--- | :--- |
| `environment` | e.g. `production` | Deployment environment context |
| `notifier.configured_options.payload.code_version` | e.g. `1.5.1` | Source code tag/version |
| `uuid` | Rollbar Item UUID | Correlation across log systems |
| `client.javascript.browser` | User Agent string | OS/Browser runtime configuration |
| `request.url` | Target URL | Page or route where error occurred |

## 2. Error Definition and Call Stack

Rollbar payloads contain error details in two primary locations:

### A. Raw Exception Diagnostic
`notifier.diagnostic.raw_error`:
- `message`: The raw error message (e.g. `"wasm validation error: at offset 53189: function body too big"`)
- `name` / `constructor_name`: Exception class (`CompileError`, `TypeError`, `RangeError`, etc.)
- `stack`: String formatted call stack with async markers (`async*__wbg_load`, `promise callback*`, etc.)

### B. Formatted Trace Exception and Frames
`body.trace`:
- `exception.class`: Error class type
- `exception.message`: High-level error message
- `exception.description`: Optional context description
- `frames`: Array of stack frames ordered from caller (index 0) to exception point (last index):
  ```json
  {
    "filename": "https://app.enrichreader.com/_app/immutable/bundle.BxeeVxqy.js",
    "lineno": 3,
    "method": "async*boe",
    "colno": 45953
  }
  ```

## 3. Client Telemetry Timeline

The `telemetry` array contains a chronological list of actions taken by the client before the failure:

- **Network Requests** (`type: "network"`): `method`, `url`, `status_code`, response content type.
- **DOM Interactions** (`type: "dom"`): Focus, click, input, or scroll events.
- **Console Output** (`type: "log"`): Info, warning, or error logs preceding the exception.

Use this timeline to reconstruct the exact steps leading up to the error.

## 4. Example Deconstruction Workflow (`tmp/rollbar/error.json`)

1. **Extract Message and Class**: `CompileError`: WASM validation error (`function body too big`).
2. **Deconstruct Stack Frame Sequence**:
   - Page trigger: `https://app.enrichreader.com/skin` (line 251/252)
   - Application bundle: `bundle.BxeeVxqy.js` (async dispatchers)
   - WASM JS Wrapper: `epub_parser.js:499:42` (`__wbg_load`)
   - WebAssembly API: `WebAssembly.instantiateStreaming` (line 1708)
3. **Diagnosis**: WASM module compilation failure during streaming initialization due to engine size limits or compiler flag configuration.
