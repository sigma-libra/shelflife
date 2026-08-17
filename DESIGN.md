---
name: Shelf Life
description: A warm wooden shelf of household consumables, resting on a cool Material 3 substrate.
colors:
  black-brown: "#2B1719"
  shelf-brown: "#D3A067"
  shelf-top-brown: "#E0C195"
  jar-blue: "#99D1E2"
  jar-green: "#C4D9A0"
  jar-yellow: "#F9DE2D"
  jar-red: "#F84038"
  life-full: "#3A821A"
  life-low: "#E27C10"
  life-due: "#F0301F"
  life-overdue: "#B4200F"
  primary: "#00687B"
  on-primary: "#FFFFFF"
  primary-container: "#AEECFF"
  on-primary-container: "#004E5D"
  secondary: "#4B6269"
  secondary-container: "#CEE7EF"
  tertiary: "#575C7E"
  error: "#BA1A1A"
  surface: "#F5FAFC"
  on-surface: "#171C1E"
  on-surface-variant: "#3F484B"
  surface-container-low: "#EFF4F7"
  surface-container: "#E9EFF1"
  surface-container-high: "#E4E9EB"
  surface-container-highest: "#DEE3E6"
  outline: "#70787C"
  outline-variant: "#BFC8CB"
typography:
  display:
    fontFamily: "Roboto, sans-serif"
    fontSize: "36sp"
    fontWeight: 400
    lineHeight: 1.22
    letterSpacing: "0"
  headline:
    fontFamily: "Roboto, sans-serif"
    fontSize: "24sp"
    fontWeight: 400
    lineHeight: 1.33
    letterSpacing: "0"
  title:
    fontFamily: "Roboto, sans-serif"
    fontSize: "22sp"
    fontWeight: 400
    lineHeight: 1.27
    letterSpacing: "0"
  title-medium:
    fontFamily: "Roboto, sans-serif"
    fontSize: "16sp"
    fontWeight: 500
    lineHeight: 1.5
    letterSpacing: "0.15"
  body:
    fontFamily: "Roboto, sans-serif"
    fontSize: "16sp"
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "0.5"
  body-medium:
    fontFamily: "Roboto, sans-serif"
    fontSize: "14sp"
    fontWeight: 400
    lineHeight: 1.43
    letterSpacing: "0.25"
  label:
    fontFamily: "Roboto, sans-serif"
    fontSize: "14sp"
    fontWeight: 500
    lineHeight: 1.43
    letterSpacing: "0.1"
rounded:
  none: "0dp"
  chip: "8dp"
  card: "12dp"
  fab: "16dp"
  dialog: "28dp"
spacing:
  hairline: "4dp"
  tight: "8dp"
  gutter: "16dp"
  action-pitch: "32dp"
  row: "56dp"
components:
  product-card:
    backgroundColor: "{colors.shelf-brown}"
    textColor: "{colors.black-brown}"
    rounded: "{rounded.card}"
  product-card-header:
    backgroundColor: "{colors.shelf-top-brown}"
    textColor: "{colors.black-brown}"
    height: "56dp"
  card-action-button:
    backgroundColor: "{colors.jar-green}"
    textColor: "{colors.black-brown}"
    rounded: "{rounded.none}"
    padding: "4dp"
    size: "24dp"
  app-bar:
    backgroundColor: "{colors.jar-blue}"
    textColor: "{colors.on-surface}"
    typography: "{typography.title}"
    height: "56dp"
  fab:
    backgroundColor: "{colors.primary-container}"
    textColor: "{colors.on-primary-container}"
    rounded: "{rounded.fab}"
    size: "56dp"
  tag-chip:
    textColor: "{colors.black-brown}"
    rounded: "{rounded.chip}"
  jar-gauge:
    textColor: "{colors.black-brown}"
    size: "42dp"
  multiselect-field:
    backgroundColor: "{colors.jar-green}"
    textColor: "{colors.black-brown}"
  switch-active:
    backgroundColor: "{colors.jar-red}"
---

# Design System: Shelf Life

## Overview

**Creative North Star: "Warm Objects on a Cool Wall"**

Shelf Life is built from the picture in its own launcher icon: pale daylit wall, wooden shelves bolted across it, and a row of saturated ceramic jars standing on the timber. The interface is that photograph made operable. The screen background is the wall — a cool, almost-white `#F5FAFC` that stays out of the way. Each product is a plank of shelf, a warm `#D3A067` card with a lighter `#E0C195` lip along its top edge. The colors the user assigns to their own tags are the jars: fully saturated, chosen by hand, and the only truly loud thing in the system.

The system runs on two palettes at once, and this is a structural fact rather than an accident to tidy away. A generated Material 3 scheme — seeded from `JAR_BLUE` and resolving to a cool teal `#00687B` primary — owns everything structural: surfaces, body text defaults, dialogs, snackbars, pickers, and every control the framework draws. Seven hand-picked constants in `lib/colors.dart` own everything the product itself draws: the card, the app bar, the accents. Material handles the room; the shelf palette handles the furniture. Where the two touch, the hand-picked value wins.

Density is generous rather than efficient. Cards are tall, padding is a plain 16dp gutter, and the list is a single vertical column with no compaction at any width. Nothing is packed. The system has no dark theme and no responsive behavior, and both absences are load-bearing facts about the current implementation rather than deliberate positions.

**Key Characteristics:**
- Cool near-white ground, warm timber objects, hand-saturated tag color
- Material 3 substrate with a hand-painted layer sitting on top of it
- Physical depth: cards are objects that cast shadows, not tinted regions
- One typeface (Roboto) at Material 3's stock scale; no custom type
- Color carries identity everywhere except the jar gauge, the system's one state-color exception
- Right-angled controls deliberately breaking Material's rounded vocabulary

## Colors

A cool near-neutral ground supporting a warm wood-and-ceramic palette, with user-authored color as the only true accent.

### Primary

The Material 3 scheme generated from `colorSchemeSeed: JAR_BLUE`. Flutter derives these; they are not written anywhere in the source, which is why they drift from the hand-picked values.

- **Deep Teal** (`#00687B`): The generated primary. Appears on text buttons (Cancel / Save / Add / Edit Tags / Done), text-field focus underlines, and selection controls. Notably it is *never* used as a fill — the app bar that would normally carry it is overridden.
- **Pale Cyan** (`#AEECFF`): The generated primary container, which is what actually fills the floating action button. It reads as a lighter, cooler cousin of the app bar rather than a match to it.
- **Slate Teal** (`#4B6269`) and **Muted Periwinkle** (`#575C7E`): Generated secondary and tertiary. Present in the scheme, effectively unused by the product.

### Secondary

The hand-picked shelf palette in `lib/colors.dart`, authored as `Color.fromRGBO` and stated here as hex. These are the identity of the app.

- **Sky Jar Blue** (`#99D1E2`): A soft, chalky, desaturated sky blue. Fills the app bar on all three screens (Products, Tags, Settings) and seeds the entire Material scheme. It is the closest thing the app has to a brand color.
- **Shelf Brown** (`#D3A067`): Mid-tone warm oak. The body of every product card. The single largest area of color in the app.
- **Shelf Top Brown** (`#E0C195`): A paler, sandier wood tone. The header strip of every product card, reading as the lit top edge of a plank.
- **Deep Cocoa** (`#2B1719`): A near-black with a distinct red-brown cast. Every piece of text drawn on a warm surface — card copy, tag chip labels, tag-page icons. Warmer and softer than the generated `#171C1E`, and chosen so type sits *in* the wood rather than on it.

### Tertiary

Accent constants, used sparingly and each in exactly one place.

- **Sage Jar Green** (`#C4D9A0`): A soft yellow-green. Fills the two card action squares and the tag multi-select sheet. The system's only "chrome" color.
- **Tomato Jar Red** (`#F84038`): Hot, slightly orange red. Used once, as the active track of the "Get Again" switch.
- **Lemon Jar Yellow** (`#F9DE2D`): The default color offered when creating a new tag. It seeds the user's palette but is never drawn by the app itself.

### State

The system's one deliberate exception to identity-only color. Reserved exclusively for the jar gauge's fill and outline — the single place shelf-life condition is expressed as color, and read the same stepped way a phone battery gauge is read rather than as a continuous gradient.

- **Full Green** (`#3A821A`): The gauge's fill with more than two months left.
- **Low Orange** (`#E27C10`): The fill between one and two months left.
- **Due Red** (`#F0301F`): The fill at one month or less.
- **Overdue Red** (`#B4200F`): The gauge's outline once the window has closed. The jar draws empty at this state — no fill at all — so the outline carries the entire signal, and is deliberately darker than Due Red so it holds contrast against the card header on its own (3.88:1).

### Neutral

Generated Material 3 surfaces. Cool-leaning, low-chroma, blue-grey.

- **Wall White** (`#F5FAFC`): Scaffold background on every screen. The wall behind the shelves.
- **Ink** (`#171C1E`): Default text on generated surfaces — app bar titles, settings rows, dialog copy, tag names.
- **Muted Ink** (`#3F484B`): Secondary text, hint text, and unfocused field labels.
- **Surface Container Low → Highest** (`#EFF4F7`, `#E9EFF1`, `#E4E9EB`, `#DEE3E6`): Material's tonal steps. Present in the scheme and used by framework components (menus, dialogs) but never invoked by product code.
- **Outline** (`#70787C`) and **Outline Variant** (`#BFC8CB`): Dividers, text-field underlines, and default chip borders.
- **Signal Red** (`#BA1A1A`): The generated error role. Currently reachable only through framework validation; no product surface uses it.

### Named Rules

**The Two-Palette Rule.** Material owns the room, the shelf palette owns the furniture. Anything the framework draws for you — dialogs, snackbars, menus, pickers, text fields — keeps its generated color role. Anything the product draws itself — cards, app bars, product accents — uses a constant from `lib/colors.dart`. Never convert one to the other for tidiness; the mix is the look.

**The Warm-Text Rule.** Text on any warm surface is `#2B1719`, never the generated `#171C1E`. The two are nearly indistinguishable in isolation and clearly different over wood.

**The Borrowed Color Rule.** Tag colors belong to the user, not to the system. They arrive from a `BlockPicker` and may be any hue at any saturation. Never assign meaning to a tag color, never derive a UI color from one, and never assume contrast against one — always pair a tag color with its name.

**The One State Exception Rule.** State color exists in exactly one place: the jar gauge. Nowhere else on the product surface — not card backgrounds, not text, not chips — changes color to indicate condition, and the gauge always restates its state in adjacent text too, so nothing rests on color alone. A future state need outside the gauge is a genuine new color decision, never a re-use of `LIFE_FULL` / `LIFE_LOW` / `LIFE_DUE` / `LIFE_OVERDUE` or of `JAR_RED` / `JAR_GREEN` / `JAR_YELLOW`.

## Typography

**Display Font:** Roboto (Android system face)
**Body Font:** Roboto
**Label/Mono Font:** none

**Character:** Entirely stock. The app ships no custom font and no type overrides — every text style resolves from Material 3's 2021 scale at default weights. Personality comes from color and surface, never from letterforms. The result is plain and institutionally legible, which is why the warm palette carries the whole identity.

### Hierarchy

- **Display** (400, 36sp, 1.22): Available, unused. No screen in the app has a display-scale element.
- **Headline** (400, 24sp, 1.33): Available, unused.
- **Title** (400, 22sp, 1.27): App bar titles on all three screens — "Your Products", "Tags", "Settings".
- **Title Medium** (500, 16sp, 1.5, +0.15): `ListTile` titles. Carries the product name on the card header, tag names on the tags page, and row labels in settings.
- **Body** (400, 16sp, 1.5, +0.5): Dialog content, text-field input, and the default for loose `Text` in the card body.
- **Body Medium** (400, 14sp, 1.43, +0.25): `ListTile` subtitles — the product purpose line. The smallest type routinely used.
- **Label** (500, 14sp, 1.43, +0.1): Button text, chip labels, popup menu items.

### Named Rules

**The Stock Scale Rule.** Never hand-pick a font size. Map text to a Material role and let the theme resolve it, so the app follows the system font-size setting. There is not a single literal `fontSize` in the codebase today, and that is worth preserving.

**The One-Weight-Apart Rule.** Hierarchy in the card body is carried by position and color, not weight — every line of card copy is the same size and weight. Any new emphasis should come from a role change (Body Medium → Title Medium), never from an ad-hoc `FontWeight`.

## Layout

A single-column vertical list at every screen size, with no breakpoints, no grid, and no adaptive behavior. The app is phone-portrait only in practice; on a tablet the list simply stretches to full width.

**Spacing rhythm** is a plain 4dp-based scale, sparsely used: `4dp` for the padding inside card action squares, `8dp` for vertical separation between card body lines and for the tag list gutter, and `16dp` for the standard horizontal gutter inside cards and on the Settings and Tags pages. Material's own 4dp card margin sits between stacked cards.

Two measurements sit outside the scale and are load-bearing to the current card composition: a **28dp top pad** above the product name, which is what clears the floating action squares, and a **32dp pitch** between the two squares (right-anchored at 8 and 40dp). Each square's invisible touch target is a 48dp box centered on it, so the pitch between visible squares stays 32dp while the interactive area meets Android's minimum without changing the shape on screen.

**Rows** are 56dp: the app bar, `ListTile` minimum height, and the FAB all share that measure, which gives the app its one consistent horizontal rhythm.

Content extends edge to edge horizontally; there is no max-width container anywhere.

### Named Rules

**The Single Column Rule.** One list, full width, always. There is no two-up, no grid, and no rail. If a wide layout is ever introduced it is a new pattern, not a variant of this one.

## Elevation & Depth

Depth is real and structural. This is a system of physical objects on a flat ground, not tonal regions.

Product cards sit at **elevation 4** — four times Material's default card elevation of 1 — which is the single most deliberate visual decision in the app. It is what makes a card read as a plank standing off a wall rather than a tinted panel. The FAB carries Material's stock elevation 6 and floats above everything. Dialogs and menus use framework defaults.

The card's action squares are *not* elevated. They are flat `#C4D9A0` chips positioned directly on the card face, so the depth story is two layers deep: wall → shelf → controls resting on the shelf.

Material's tonal elevation is present in the generated scheme but unused by product code; the app expresses depth exclusively through shadow.

### Shadow Vocabulary

- **Shelf** (Material elevation `4`): Product cards. Permanent, not a state.
- **Float** (Material elevation `6`): The FAB.
- **Lift** (Material `ReorderableListView` default): Applied automatically while a card is being dragged, on top of its resting elevation.

### Named Rules

**The Always-Lifted Rule.** A product card is elevated at rest. Elevation here means "this is a physical thing," not "this is hovered" or "this is selected." Never remove a card's shadow to indicate a state, and never add elevation to something that is not an object.

## Shapes

Rounded by Material default, with one sharp exception that carries most of the app's character.

Cards use a **12dp** radius, chips **8dp**, the FAB **16dp**, and dialogs **28dp** — all stock Material 3 values, none overridden. The card's header strip is a `ListTile` that fills the card's full width and is clipped by the card's own corners, so the top two corners of the lighter `#E0C195` band inherit the 12dp curve while its bottom edge is a hard horizontal line across the card. That line is the shelf's front edge.

The exception: the two card-corner action squares are **perfectly square, 0dp radius**. Against a system where everything else is rounded, the right angles read as small applied labels or lids rather than as buttons. It is the one place the app contradicts Material's form language, and it is intentional enough to preserve.

Borders are rare and each does a specific job. A `#D3A067` hairline rings each tag chip — the card's own background color used as a border, so the chip appears cut out of the shelf rather than laid on it. A `#2B1719` hairline rings each action square instead, for the opposite reason: Sage Jar Green sits at only 1.53:1 against Shelf Brown, well under the 3:1 a control boundary needs, so the square borrows the system's one color built for edge legibility rather than blending into the card.

### Named Rules

**The Right-Angle Exception.** Card action controls are square. Everything else follows Material's radius scale. Do not "fix" the squares to match, and do not extend right angles to other components.

**The Cut-Out Border Rule.** When a chip sits on a colored surface, border it with that surface's own color rather than an outline neutral. The chip reads as inset.

**The Legible-Edge Border Rule.** When a control's fill doesn't clear 3:1 against the surface it sits on, border it in `#2B1719` rather than leaving the boundary to contrast alone. Reserved for cases the fill itself can't fix without breaking an established color rule (here, Sage Jar Green's fixed job per the Two-Palette Rule).

## Components

### Product Card *(signature component)*

The one genuinely custom construction in the app, and the thing worth protecting.

- **Shape:** 12dp radius, elevation 4, Material's default 4dp outer margin
- **Background:** Shelf Brown `#D3A067`
- **Header:** a full-bleed `ListTile` in Shelf Top Brown `#E0C195`, carrying the Jar Gauge at the leading edge, the product name as title (pushed down 28dp), and the purpose as subtitle
- **Body:** 16dp horizontal gutter; a stack of plain 14–16sp lines in `#2B1719` — the shelf-life state line, the Get Again state, months remaining, cost — each separated by 8dp
- **Tags:** a horizontally scrollable chip row at the bottom, compact density
- **Actions:** two flat 24dp Sage Green squares, each ringed in a `#2B1719` hairline (the Legible-Edge Border Rule), pinned to the top-right corner at 8 / 40dp — duplicate, edit, right to left. Each visible square sits centered inside its own invisible 48dp touch target, so the control meets Android's minimum without growing the shape that gives the corner its "lid" read.
- **Gesture:** the whole card is a `Dismissible`; swiping end-to-start (never both directions, so a stray reorder-drag flick can't trigger it) deletes it, with an Undo snackbar. Delete is deliberately absent as a corner action — it's the one irreversible action, so it lives on the swipe rather than sitting 8dp from Edit at the top of the thumb's arc.

### Jar Gauge *(signature component)*

The launcher icon's jar, made to carry state. A custom-painted glass jar that empties as a product's shelf life runs down — the one place in the system where fill color means condition rather than identity.

- **Shape:** a `CustomPainter` silhouette (lid, neck, body) proportioned as fractions of its own box, so it scales cleanly with the system font-size setting instead of the surrounding text shrinking to fit it.
- **Fill:** stepped, not continuous — full above two months, half between one and two, a red sliver at one month or less, empty when overdue.
- **Color:** the four State colors above. Glass and default outline are `#2B1719` at low opacity; the overdue state swaps the outline to Overdue Red, since an empty jar needs its own signal rather than reading as merely absent.
- **Redundancy:** always paired with a text line stating the same fact (months left, or "Overdue"), so the color is never the only channel.
- **Reuse:** a compact per-product gauge on every card, and a large, flagged instance as the empty-shelf illustration.

### Chips

- **Style:** filled with the tag's own user-chosen color, `#2B1719` label, hairline border in the parent card's `#D3A067`, compact visual density, 8dp radius
- **State:** display-only on the card. In the multi-select sheet the same chips gain a selected state drawn by `multi_select_flutter` against a Sage Green `#C4D9A0` background.

### Cards / Containers

Outside the product card, the app uses no container surfaces at all. Settings and Tags are bare `ListTile` rows on the scaffold background, separated by a single `Divider` on Settings and by 8dp padding on Tags. Tag rows tint their entire tile with the tag's color, making the row itself the color swatch.

### Inputs / Fields

- **Style:** Material 3 stock — filled-less underline decoration, floating label, no radius, no custom fill
- **Focus:** underline thickens and shifts to the generated primary `#00687B`; the label lifts and recolors
- **Error / Disabled:** never styled by product code. Validation on the Tags page is surfaced through a snackbar instead of field-level error text.
- **Numeric fields** are width-constrained rather than validated: a 50dp base for integers, 72dp for two-decimal currency, with the currency symbol as a separate 8dp-spaced prefix outside the field. The base scales with the system font-size setting (clamped to 2x) so digits don't clip at accessibility text sizes — the same mechanism the Jar Gauge uses to stay legible when scaled.

### Navigation

- **Style:** a 56dp app bar filled with Sky Jar Blue `#99D1E2` on every screen, title in Title role, no elevation change on scroll
- **Actions:** a filter icon and a three-dot overflow menu on the Products screen; nothing on Tags or Settings
- **Hierarchy:** flat push navigation via `Navigator.push` with default Material page transitions. No bottom navigation bar, no rail, no drawer, no tabs.
- **Primary action:** a single 56dp FAB in Pale Cyan `#AEECFF` bottom-right, carrying `Icons.add`

### Named Rules

**The One-Blue-Bar Rule.** Every screen in the app wears the same `#99D1E2` app bar. It is the only element that is identical everywhere, and it is how the app signals it is still itself as you push screens. Do not tint it per screen.

## Do's and Don'ts

### Do:
- **Do** use `lib/colors.dart` constants for anything the product draws itself, and Material color roles for anything the framework draws.
- **Do** put `#2B1719` on warm surfaces and let the generated `#171C1E` handle cool ones.
- **Do** keep product cards at elevation 4. It is what makes them read as shelves.
- **Do** keep the card action squares at 0dp radius.
- **Do** map type to Material roles and let the theme resolve the size, so system font scaling keeps working.
- **Do** pair every tag color with its tag name, since the color is user-chosen and carries no guaranteed contrast.
- **Do** border chips with their parent surface's color so they read as cut into it.
- **Do** keep the jar gauge's state restated in adjacent text — never let color alone carry the shelf-life signal.

### Don't:
- **Don't** introduce a second typeface or a literal `fontSize`. The system has neither today.
- **Don't** give the app bar a per-screen color.
- **Don't** use `JAR_RED #F84038`, `JAR_GREEN #C4D9A0`, or `JAR_YELLOW #F9DE2D` as state colors. They are identity accents with one fixed job each; recruiting them for meaning would collide with their existing use.
- **Don't** extend the jar gauge's `LIFE_*` state colors to any other surface — card backgrounds, text, chips. The gauge is the one sanctioned exception, not a precedent.
- **Don't** derive UI color from a tag color, or assume any contrast against one.
- **Don't** add tonal-elevation surfaces alongside the shadowed cards. The system expresses depth one way.
- **Don't** round the card action squares to match Material.
- **Don't** assume a dark theme exists. Every color above is a light-theme value, and the hardcoded constants will not invert with `Brightness.dark`.

### Known tensions

Recorded as observations, not prescriptions — these are places where the implemented system disagrees with itself, and any future work should resolve them deliberately rather than by accident.

- **The FAB does not match the app bar.** `colorSchemeSeed: JAR_BLUE` generates `#AEECFF` for the FAB, which is visibly lighter and cooler than the `#99D1E2` bar it was seeded from. Two blues that look like a near-miss rather than a pair.
- **The generated primary `#00687B` never appears as a fill.** The scheme's most saturated color surfaces only as button text, so the app reads far less teal than its own theme claims.
- **There is no dark theme.** `ThemeData` declares only a light scheme, and every hardcoded constant is a light-surface value. Enabling dark mode today would put `#2B1719` text on `#D3A067` cards over a dark scaffold.
