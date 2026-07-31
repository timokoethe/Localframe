# AGENTS.md

## Project purpose

Localframe is a small native SwiftUI showcase for Apple's on-device Image Playground framework. It targets iOS 26 and demonstrates creating an `ImageCreator`, streaming images for a text prompt, and presenting the results in a minimal state-driven UI. It is a reference app, not a production image-generation product.

Preserve these product invariants:

- Generation stays fully on-device through `ImagePlayground.ImageCreator`. Do not add network requests, cloud generation, analytics, telemetry, or remote dependencies.
- Prompts and generated images remain in memory only. Do not add persistence unless a task explicitly changes that decision.
- Keep the deployment target at iOS 26.0 and the target iPhone-only unless a task explicitly changes platform support.
- `ImageCreator`, the API used here for direct programmatic on-device image generation, is deprecated as of iOS 27. Apple has announced that the class is being discontinued and will no longer work on iOS 27 or later. Do not add an unsupported compatibility shim or raise the deployment target as a workaround. Migrating to the system Image Playground sheet would be a product-level change because it replaces the current direct generation flow.
- User-facing text is currently written in English.

Keep `README.md` in sync when features, requirements, privacy properties, limitations, or platform support change. In particular, keep its feature links and `ImageCreator` discontinuation guidance accurate.

Every app feature must have a focused Markdown file under `docs/features/`, based on `docs/features/_template.md`. When a change adds, removes, or alters feature behavior, requirements, privacy properties, limitations, or platform support, update the affected feature documentation in the same change. Add a new feature file when no existing document fits, keep its frontmatter status accurate, and do not leave acceptance criteria that contradict the implementation.

## Repository map

```text
Localframe/
├── LocalframeApp.swift
├── Home/
│   ├── HomeView.swift              # State-based root view
│   ├── HomeViewModel.swift         # ImageCreator lifecycle and generation logic
│   └── Components/
│       ├── GeneratorView.swift     # Style picker and prompt area
│       ├── TypebarView.swift       # Prompt field and generate action
│       ├── ProgressionView.swift   # In-progress state
│       ├── FinalView.swift         # Results and restart action
│       └── ErrorView.swift         # Framework or fallback error
└── Assets.xcassets/                # Colors and preview fixtures

Icon.icon/                          # App icon source
Localframe.xcodeproj/               # Xcode project and shared scheme
docs/features/                      # Per-feature documentation and template
```

The Xcode project uses a file-system-synchronized source group. Add source files under `Localframe/`; do not edit `project.pbxproj` merely to register them. Change the project file only for build settings, targets, capabilities, or resource configuration.

## Platform and API constraints

- Import `ImagePlayground` in files that directly use `ImageCreator`, `ImageCreator.Error`, or `ImagePlaygroundStyle`.
- Use an Xcode installation with the iOS 26 SDK. Select it through `DEVELOPER_DIR` when the machine has multiple Xcode versions.
- Image generation requires a supported physical Apple Intelligence-capable iPhone, Apple Intelligence enabled, and supported device and Siri languages. Simulator builds verify compilation and UI flow only; generation is unsupported there and may return `.notSupported`.
- Do not replace `ImageCreator` with a remote image service. Apple lists such services as a migration option for iOS 27, but they are outside this repository's on-device scope.

## Architecture and behavior

- `HomeView` owns the `@Observable`, `@MainActor` `HomeViewModel` with `@State`; child views receive it through `@Bindable`.
- Keep creator initialization, streaming, errors, and state transitions in `HomeViewModel`, not in SwiftUI view bodies.
- Preserve the `ViewState` flow routed by `HomeView`: `.idle`, `.isGenerating`, `.generated`, and `.error`.
- `ImageCreator` is initialized asynchronously from `HomeViewModel.init()`. Generation remains disabled until `isCreatorReady` is true; initialization failures enter `.error`.
- `TypebarView` enables submission when the creator is ready and `inputPrompt` is non-empty. The current implementation does not trim the prompt or reject whitespace-only input; do not describe it as doing so.
- The available styles are `.animation`, `.illustration`, and `.sketch`, with `.animation` selected initially.
- `generateImages(limit:)` defaults to two images. It clears previous results, consumes `images(for:style:limit:)` as an async stream, and appends each `CGImage` as it arrives. One or more results lead to `.generated`; an empty stream or thrown error leads to `.error`.
- `ProgressionView` contains exactly two progress placeholders and therefore assumes the default limit. Update it with the generation limit if that limit changes. `FinalView` already renders any number of returned images.
- Avoid overlapping generation tasks. The current state routing removes the submit UI during generation, and the restart button in `ProgressionView` remains disabled while `.isGenerating`.
- Framework errors are stored as `ImageCreator.Error` when that cast succeeds; `ErrorView` otherwise shows its generic fallback.
- `reset()` clears the prompt, results, and error and returns to `.idle`; it retains the initialized `ImageCreator` and selected style.
- Keep async UI state main-actor isolated. The target also enables `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` and approachable concurrency.
- `Image01.Test` and `Image02.Test` are preview fixtures, not runtime output or user data.

## Swift and SwiftUI conventions

- Follow the surrounding code style and keep changes narrowly scoped.
- Prefer SwiftUI, Image Playground, and Apple frameworks already used by the project.
- Keep views focused on presentation and user interaction; keep generation logic in `HomeViewModel`.
- Use existing assets such as `Tint`, and do not add third-party packages without an explicit requirement.
- Add comments only for non-obvious API behavior or lifecycle decisions.

## Build and verification

The repository has one app target and shared scheme, both named `Localframe`, and no automated test target. For code changes, at minimum run:

```sh
xcodebuild \
  -project Localframe.xcodeproj \
  -scheme Localframe \
  -configuration Debug \
  -sdk iphonesimulator \
  -destination 'generic/platform=iOS Simulator' \
  -derivedDataPath /tmp/localframe-derived-data \
  CODE_SIGNING_ALLOWED=NO \
  build
```

For generation changes, manually test on a supported physical iPhone when available: creator readiness, all three styles, streamed results, restart, error handling, and the absence of persistence after relaunch. State unavailable SDKs, runtimes, or devices in the final report rather than claiming those checks passed.

Before finishing, run `git status --short`, `git diff --check`, and review `git diff`. Account for untracked files separately, and report exactly which build and manual checks were run.
