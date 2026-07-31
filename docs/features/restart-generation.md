---
status: implemented
area: generation-flow
platforms:
  - ios
---

# Restart Generation

## Purpose

Allow the user to clear the current result and begin another generation cycle.

## User Story

As a user, I want to restart after viewing generated images so that I can create something new.

## Acceptance Criteria

- The results view provides a Restart action.
- Restart clears the prompt, generated images, and stored error.
- Restart returns the app to the initial prompt view.
- Restart retains the initialized image creator and selected style.
