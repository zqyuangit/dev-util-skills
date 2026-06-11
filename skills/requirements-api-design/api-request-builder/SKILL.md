---
name: api-request-builder
description: Build a basic HTTP request (curl or fetch) for an API. Use when a junior developer needs a quick request example.
---

# API Request Builder

## Purpose
Build a basic HTTP request (curl or fetch) for an API.

## Inputs to request
- Method, URL, and endpoint description.
- Auth type and credentials.
- Required headers and payload shape.

## Workflow
1. Confirm method, URL, headers, and auth scheme.
2. Construct the request with placeholder values.
3. Show how to inspect the response status and body.

## Output
- Runnable request example.
- Notes on required headers and auth.

## Collaboration
- Upstream: use after `api-contract-designer` or when an endpoint contract already exists.
- Downstream: hand off to `autonomous-development-governor` when request examples need runtime smoke validation or completion evidence.
- Handoff output: include method, URL, headers, payload, placeholders, and expected response check.

## Quality bar
- Redact secrets and use placeholders.
- Include a sample response check.
