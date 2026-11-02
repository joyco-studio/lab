# JOYCO Lab

Public registry of [JOYCO Studio](https://joyco.studio) experiments.

Each experiment lives in its own isolated repository and gets listed here via [`experiments.json`](./experiments.json) — the single source of truth consumed by the [Hub](https://hub.joyco.studio) to render the experiments showcase.

## How it works

1. Scaffold a new experiment using the JOYCO CLI:
   ```sh
   joyco create
   ```
   This lets you pick a template (`3d` or `motion`), creates a new repo, and sets everything up.

2. Build and deploy your experiment.

3. Publish it to the registry:
   ```sh
   joyco lab create
   ```
   This opens a PR adding your experiment to `experiments.json`.

## Schema

Each entry in `experiments.json` follows this shape:

| Field          | Type       | Required | Description                              |
| -------------- | ---------- | -------- | ---------------------------------------- |
| `slug`         | `string`   | yes      | URL-friendly unique identifier           |
| `title`        | `string`   | yes      | Display name                             |
| `description`  | `string`   | yes      | What the experiment explores             |
| `href`         | `string`   | yes      | Live deployment URL                      |
| `thumbnail`    | `string`   | no       | Preview image URL shown on the Hub       |
| `repo`         | `string`   | no       | Source repository URL                    |
| `template`     | `string`   | no      | Template used (`3d` \| `motion`)         |
| `tags`         | `string[]` | no       | Filter tags, see [Tags](#tags)           |
| `hasControls`  | `boolean`  | no       | Whether the experiment exposes controls   |
| `date`         | `string`   | yes      | Publication date (`YYYY-MM-DD`)          |

The full JSON Schema is in [`schema.json`](./schema.json).

## Tags

The Hub filters experiments with `?tag=<slug>`, and external sites deep-link to those slugs, so a tag is a public URL. Treat renames as breaking changes.

- Tags are lowercase kebab-case: `[a-z0-9]+(-[a-z0-9]+)*`. No spaces, dots, `@` or slashes.
- One canonical spelling per technology: `threejs`, `r3f`, `tsl`, `glsl`, `webgl`, `webgpu`, `post-processing`.
- Singular nouns: `shader`, not `shaders`.
- Prefer tags that apply to several experiments over one-off descriptors. A tag used by only one experiment needs a reason to exist.
- Reuse a tag from the list below before inventing a new one. If you do add one, add it here too.
- Never rename `lettra`; the Lettra landing links to `?tag=lettra`.

`./scripts/check-tags.sh` (run in CI) rejects tags that aren't slugs and tags that collapse to the same key once case, `.`, `@`, `/`, `-`, spaces and a trailing `s` are ignored. Synonyms (`text` vs `typography`) are caught in review.

### Canonical tags

| Area             | Tags                                                                                     |
| ---------------- | ---------------------------------------------------------------------------------------- |
| Rendering / APIs | `webgl`, `webgpu`, `threejs`, `r3f`, `tsl`, `glsl`, `shader`, `post-processing`, `3d`    |
| Techniques       | `procedural`, `sdf`, `msdf`, `fluid-simulation`, `halftone`, `pattern`                   |
| Look & feel      | `retro`, `risograph`, `duotone`, `grain`, `dots`                                         |
| Type             | `typography`                                                                             |
| Input            | `interaction`, `mouse`, `third-person`                                                   |
| Libraries        | `rapier`                                                                                 |
| Projects         | `lettra`, `susano`                                                                       |
| Other            | `creative-tools`, `terminal`, `grass`                                                    |

## Templates

| Template | Repository |
| -------- | ---------- |
| `3d`     | [lab-template-3d](https://github.com/joyco-studio/lab-template-3d) |
| `motion` | [lab-template-motion](https://github.com/joyco-studio/lab-template-motion) |
