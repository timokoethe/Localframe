---
status: implemented
area: generation-flow
platforms:
  - ios
---

# Generation Progress

## Purpose

Show that Localframe is working while on-device image generation is in progress.

## User Story

As a user, I want visible progress feedback so that I know my request is still being processed.

## Acceptance Criteria

- Submitting a prompt replaces the generator controls with the progress view.
- The progress view displays two placeholders for the default two-image request.
- Restart is disabled while generation is in progress.
