# SilkCircuit Design Language

> The complete visual identity system for the electric digital aesthetic

## Table of Contents

1. [Brand Identity](#brand-identity)
2. [Color System](#color-system)
3. [Typography](#typography)
4. [Spacing & Layout](#spacing--layout)
5. [Motion & Animation](#motion--animation)
6. [Component Patterns](#component-patterns)
7. [Iconography](#iconography)
8. [Application Guidelines](#application-guidelines)
9. [Accessibility Standards](#accessibility-standards)
10. [Real-world Examples](#real-world-examples)

---

## 🎭 Brand Identity

### Core Philosophy

**"Electric meets elegant"**

SilkCircuit embodies the intersection of high-energy digital aesthetics and sophisticated design. We create experiences that energize without overwhelming, guide without distracting.

### Brand Personality

**Electric** ⚡ - Vibrant, energetic, forward-looking

- High contrast, saturated neon colors
- Sharp, precise visual elements
- Dynamic energy that sparks creativity

**Elegant** 💎 - Refined, purposeful, sophisticated

- Thoughtful color hierarchy and semantic meaning
- Clean typography with careful spacing
- Purposeful design that enhances focus

**Purposeful** 🎯 - Functional, semantic, intentional

- Every color carries semantic meaning
- Form follows function in all decisions
- Accessibility-first approach (WCAG AA compliance)

**Future-forward** 🌌 - Modern, progressive, innovative

- Embraces modern development tools
- Anticipates developer workflow needs
- Evolves with the development ecosystem

**Focused** 💜 - Clear, direct, uncluttered

- Reduces cognitive load during coding
- Enhances developer productivity
- Maintains coding flow state

### Voice & Tone

**Voice:** Confident yet approachable, technical yet accessible
**Tone:**

- **Documentation:** Clear, precise, helpful
- **Error Messages:** Direct but supportive
- **Success States:** Celebratory but professional
- **Marketing:** Electric energy with substance

---

## 🎨 Color System

### Variant-Specific Color Systems

SilkCircuit uses five carefully crafted variants, each with precisely tuned colors:

#### ⚡ Neon (100% intensity)

**Background System:**

- Base: `#12101a` | Dark: `#0a0812` | Highlight: `#1a162a`

**Primary Colors:**

- **Electric Purple** (`#e135ff`) - Keywords, control flow, importance
- **Pure Pink** (`#ff00ff`) - Tags, booleans, emphasis
- **Neon Cyan** (`#80ffea`) - Functions, methods, interaction
- **Coral** (`#ff6ac1`) - Numbers, constants
- **Electric Yellow** (`#f1fa8c`) - Classes, types, warnings

#### ⚡ Vibrant (85% intensity)

**Background System:**

- Base: `#0f0c1a` | Dark: `#08060f` | Highlight: `#0a0614`

**Primary Colors:**

- **Pure Magenta** (`#ff00ff`) - Maximum intensity purple
- **Electric Pink** (`#ff00cc`) - Vibrant but controlled
- **Electric Cyan** (`#00ffcc`) - High-energy interaction color
- **Coral** (`#F78C6C`) - Warm accent for numbers
- **Electric Yellow** (`#ffcc00`) - Strong type highlighting

#### 🌸 Soft (70% intensity)

**Background System:**

- Base: `#1a1626` | Dark: `#141220` | Highlight: `#3e3456`

**Primary Colors:**

- **Soft Purple** (`#e892ff`) - Gentle keywords
- **Soft Pink** (`#ff99ff`) - Comfortable string colors
- **Soft Cyan** (`#99ffee`) - Easy-on-eyes functions
- **Soft Coral** (`#ff99dd`) - Muted numbers
- **Soft Yellow** (`#ffe699`) - Gentle type highlighting

#### 🌌 Glow (Maximum contrast)

**Background System:**

- Base: `#0a0816` | Dark: `#000000` | Highlight: `#1a0033`

**Primary Colors:**

- **Pure Magenta** (`#ff00ff`) - Maximum contrast keywords
- **Pure Pink** (`#ff00ff`) - Ultra-bright emphasis
- **Pure Cyan** (`#00ffff`) - Electric function highlighting
- **Bright Pink** (`#ff66ff`) - High-contrast numbers
- **Pure Yellow** (`#ffff00`) - Maximum visibility types

#### 🌅 Dawn (Light theme)

**Background System:**

- Base: `#faf8ff` | Dark: `#f1ecff` | Highlight: `#e8e0ff`

**Primary Colors:**

- **Deep Purple** (`#7e2bd5`) - Keywords with strong contrast
- **Magenta** (`#b40077`) - Tags, booleans, emphasis
- **Teal** (`#007f8e`) - Functions, methods, interaction
- **Coral** (`#c74a8c`) - Numbers, constants
- **Golden Yellow** (`#a88600`) - Classes, types, warnings

**Text System:**

- Foreground: `#2b2540` (dark purple-gray)
- Muted: `#8e84a8` (gray-purple for comments)
- Emphasized: `#1a1318` (near-black)

### Universal Supporting Colors

**Success Green** (`#50fa7b` / Soft: `#66ff99` / Glow: `#00ff00` / Dawn: `#2d8659`)

- Success states, git additions, confirmations
- Semantic: Growth, positive actions, validation
- Applications: Success messages, add buttons, valid states

**Warning Yellow** (`#f1fa8c` / Soft: `#ffe699` / Glow: `#ffff00` / Dawn: `#a88600`)

- Caution, attention, modification
- Semantic: Alert, change, pending
- Applications: Warning messages, modified indicators

**Error Red** (`#ff6363` / Soft: `#ff6677` / Glow: `#ff0066` / Dawn: `#c1272d`)

- Errors, deletions, danger
- Semantic: Stop, danger, removal
- Applications: Error messages, delete buttons, invalid states

### Semantic Color Mapping (All Variants)

**Code Syntax:**

```
Keywords     → Purple (bold)
Functions    → Cyan (bold + italic)
Strings      → Pink Soft (italic)
Numbers      → Coral
Booleans     → Pink
Types        → Yellow
Comments     → Purple Muted (italic)
Operators    → Foreground Dark
Properties   → Cyan Bright
```

**Interactive States:**

- Hover: Add 10% brightness to base color
- Active: Invert foreground/background
- Focus: Add cyan glow (`0 0 0 2px #80ffea40`)
- Disabled: 50% opacity
- Selection: Variant-specific with transparency

---

## 📝 Typography

### Font Stacks

**Primary (UI Text):**

```css
font-family:
  "Inter",
  -apple-system,
  BlinkMacSystemFont,
  "Segoe UI",
  "Helvetica Neue",
  Arial,
  sans-serif;
```

**Code/Monospace:**

```css
font-family:
  "JetBrains Mono", "Fira Code", "SF Mono", "Cascadia Code", "Monaco", "Menlo", "Roboto Mono",
  monospace;
```

**Display (Headlines):**

```css
font-family:
  "Inter",
  -apple-system,
  BlinkMacSystemFont,
  sans-serif;
```

### Type Scale

#### Mobile (320px+)

```css
--sc-text-xs: 0.75rem (12px) --sc-text-sm: 0.875rem (14px) --sc-text-base: 1rem (16px)
  --sc-text-lg: 1.125rem (18px) --sc-text-xl: 1.25rem (20px) --sc-text-2xl: 1.5rem (24px)
  --sc-text-3xl: 1.875rem (30px) --sc-text-4xl: 2.25rem (36px);
```

#### Desktop (1024px+)

```css
--sc-text-xs: 0.75rem (12px) --sc-text-sm: 0.875rem (14px) --sc-text-base: 1rem (16px)
  --sc-text-lg: 1.125rem (18px) --sc-text-xl: 1.25rem (20px) --sc-text-2xl: 1.5rem (24px)
  --sc-text-3xl: 2rem (32px) --sc-text-4xl: 2.5rem (40px) --sc-text-5xl: 3rem (48px);
```

### Code Typography

**Syntax Styling:**

```css
.sc-keyword {
  font-weight: 700;
  color: var(--sc-purple);
}

.sc-function {
  font-weight: 700;
  font-style: italic;
  color: var(--sc-cyan);
}

.sc-string {
  font-style: italic;
  color: var(--sc-pink-soft);
}

.sc-comment {
  font-style: italic;
  color: var(--sc-purple-muted);
  opacity: 0.8;
}
```

---

## 📐 Layout & Spacing

### Grid System

**Base Unit:** 4px (follows modern design system standards)

**Spacing Scale:**

```css
/* SilkCircuit spacing tokens */
--sc-space-xs: 4px (0.25rem) /* Micro spacing */ --sc-space-sm: 8px (0.5rem) /* Small gaps */
  --sc-space-md: 16px (1rem) /* Base spacing */ --sc-space-lg: 24px (1.5rem) /* Section spacing */
  --sc-space-xl: 32px (2rem) /* Large gaps */ --sc-space-2xl: 48px (3rem) /* Major sections */
  --sc-space-3xl: 64px (4rem) /* Page sections */;
```

**Grid Layout:**

```css
/* Mobile-first responsive grid */
.sc-grid {
  display: grid;
  gap: var(--sc-space-md);
  grid-template-columns: repeat(4, 1fr); /* Mobile */
}

@media (min-width: 768px) {
  .sc-grid {
    grid-template-columns: repeat(8, 1fr);
  } /* Tablet */
}

@media (min-width: 1024px) {
  .sc-grid {
    grid-template-columns: repeat(12, 1fr);
  } /* Desktop */
}
```

**Responsive Breakpoints:**

```css
--sc-breakpoint-xs: 320px /* Mobile portrait */ --sc-breakpoint-sm: 768px /* Tablet portrait */
  --sc-breakpoint-md: 1024px /* Tablet landscape/Small desktop */ --sc-breakpoint-lg: 1440px
  /* Desktop */ --sc-breakpoint-xl: 1920px /* Large desktop */;
```

---

## ⚡ Motion & Animation

### Timing Functions

```css
--sc-ease-linear: linear --sc-ease-in: cubic-bezier(0.4, 0, 1, 1)
  --sc-ease-out: cubic-bezier(0, 0, 0.2, 1) --sc-ease-in-out: cubic-bezier(0.4, 0, 0.2, 1)
  --sc-ease-back: cubic-bezier(0.34, 1.56, 0.64, 1)
  --sc-ease-elastic: cubic-bezier(0.68, -0.55, 0.265, 1.55);
```

### Duration Scale

```css
--sc-duration-fast: 150ms --sc-duration-normal: 250ms --sc-duration-slow: 350ms
  --sc-duration-slower: 500ms;
```

### Signature Animations

**Neon Glow:**

```css
@keyframes neonGlow {
  from {
    filter: drop-shadow(0 0 10px var(--sc-purple) 40);
  }
  to {
    filter: drop-shadow(0 0 20px var(--sc-purple) 80);
  }
}
```

**Electric Pulse:**

```css
@keyframes electricPulse {
  0%,
  100% {
    opacity: 1;
    transform: scale(1);
  }
  50% {
    opacity: 0.8;
    transform: scale(1.05);
  }
}
```

**Cyber Slide:**

```css
@keyframes cyberSlide {
  from {
    transform: translateX(-100%) skewX(25deg);
  }
  to {
    transform: translateX(0) skewX(0);
  }
}
```

---

## 🧩 Component Patterns

### Buttons

**Primary Button:**

```css
.sc-btn-primary {
  background: linear-gradient(45deg, var(--sc-purple), var(--sc-pink));
  color: white;
  border: none;
  padding: var(--sc-space-sm) var(--sc-space-lg);
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all var(--sc-duration-normal) var(--sc-ease-out);
}

.sc-btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px var(--sc-purple) 40;
  filter: brightness(1.1);
}
```

**Ghost Button:**

```css
.sc-btn-ghost {
  background: transparent;
  color: var(--sc-cyan);
  border: 1px solid var(--sc-cyan);
  padding: var(--sc-space-sm) var(--sc-space-lg);
  border-radius: 6px;
  font-weight: 600;
  cursor: pointer;
  transition: all var(--sc-duration-normal) var(--sc-ease-out);
}

.sc-btn-ghost:hover {
  background: var(--sc-cyan);
  color: var(--sc-bg);
  box-shadow: 0 0 20px var(--sc-cyan) 30;
}
```

### Cards

```css
.sc-card {
  background: var(--sc-bg-highlight);
  border: 1px solid var(--sc-cyan) 20;
  border-radius: 8px;
  padding: var(--sc-space-lg);
  transition: all var(--sc-duration-normal) var(--sc-ease-out);
}

.sc-card:hover {
  border-color: var(--sc-cyan) 60;
  box-shadow: 0 4px 20px var(--sc-cyan) 10;
  transform: translateY(-2px);
}
```

### Form Inputs

```css
.sc-input {
  background: var(--sc-bg-dark);
  border: 1px solid var(--sc-purple) 30;
  color: var(--sc-fg);
  padding: var(--sc-space-sm);
  border-radius: 4px;
  font-family: inherit;
  transition: all var(--sc-duration-fast) var(--sc-ease-out);
}

.sc-input:focus {
  outline: none;
  border-color: var(--sc-cyan);
  box-shadow: 0 0 0 2px var(--sc-cyan) 20;
}
```

---

## 🎯 Iconography

### Icon Style Principles

- **Line weight**: 2px stroke
- **Corner radius**: 2px for rounded elements
- **Grid**: 24px base, scalable
- **Style**: Outline with selective fills

### Preferred Symbols

```
Navigation:   →  ←  ↑  ↓  ↗  ↙  ⟶  ⟵
Bullets:      •  ▪  ▫  ◦  ●  ○  ▲  ▼
Status:       √  ×  !  ?  ✓  ✗  ⚠  ℹ
Code:         ⟨  ⟩  ❮  ❯  ‹  ›  «  »
Electric:     ⚡  ⭐  ✦  💎  💜  🌟  ⭑
```

### Icon Color Usage

- **Active state**: Primary variant color (purple/cyan)
- **Inactive state**: 60% opacity
- **Success**: Green
- **Warning**: Yellow
- **Error**: Red
- **Info**: Cyan

---

## 📱 Application Guidelines

### Code Editors

- **Background**: Use variant-specific background system
- **Syntax**: Follow semantic color mapping precisely
- **UI Chrome**: Muted backgrounds with electric accents
- **Selections**: Translucent overlays with variant colors

### Web Applications

- **Layout**: Clean, spacious, focus-driven
- **Navigation**: Electric accents guide user flow
- **Cards/Panels**: Subtle borders with hover effects
- **Forms**: Clear validation with color-coded feedback

### Mobile Applications

- **Touch Targets**: Minimum 44px tap areas
- **Contrast**: Enhanced for outdoor visibility
- **Typography**: Larger base sizes for readability
- **Gestures**: Visual feedback with electric animations

### Marketing Materials

- **Hero Sections**: Gradient backgrounds with glow effects
- **CTAs**: High-energy gradient buttons
- **Typography**: Bold headlines with electric colors
- **Imagery**: High contrast with neon accents

---

## ♿ Accessibility Standards

### WCAG AA Compliance

All SilkCircuit color combinations meet or exceed WCAG AA standards:

**Contrast Ratios:**

- Normal text: 4.5:1 minimum ✓
- Large text (18pt+): 3:1 minimum ✓
- UI elements: 3:1 minimum ✓
- Graphics: 3:1 minimum ✓

### Variant Accessibility

- **Neon**: Full WCAG AA compliance
- **Vibrant**: Enhanced contrast for bright environments
- **Soft**: Optimized for extended use, reduces eye strain
- **Glow**: Maximum contrast for low-light conditions
- **Dawn**: Light theme optimized for bright environments and daytime use

### Testing Tools

```bash
# Neovim command for contrast validation
:SilkCircuitContrast

# Web accessibility testing
npm install -g @axe-core/cli
axe-cli --tags wcag2a,wcag2aa
```

### Keyboard Navigation

- Focus indicators use cyan glow (`#80ffea`)
- Tab order follows logical content flow
- All interactive elements keyboard accessible
- Skip links available for screen readers

### Screen Reader Support

- Semantic HTML structure
- Proper ARIA labels and roles
- Color information never conveyed through color alone
- Alternative text for all meaningful graphics

---

## 🌍 Real-world Examples

### Variant-Aware Code Editor Implementation

```css
/* SilkCircuit base editor styles */
.silkcircuit-editor {
  font-family: "JetBrains Mono", "Fira Code", "SF Mono", monospace;
  font-size: 14px;
  line-height: 1.5;
  transition: all 0.2s ease;
}

/* Neon variant */
.silkcircuit-editor[data-variant="neon"] {
  background-color: #12101a;
  color: #f8f8f2;
}

.silkcircuit-editor[data-variant="neon"] .sc-keyword {
  color: #e135ff;
  font-weight: bold;
}
.silkcircuit-editor[data-variant="neon"] .sc-string {
  color: #ff99ff;
  font-style: italic;
}
.silkcircuit-editor[data-variant="neon"] .sc-function {
  color: #80ffea;
  font-weight: bold;
  font-style: italic;
}

/* Vibrant variant */
.silkcircuit-editor[data-variant="vibrant"] {
  background-color: #0f0c1a;
  color: #f8f8f2;
}

.silkcircuit-editor[data-variant="vibrant"] .sc-keyword {
  color: #ff00ff;
  font-weight: bold;
}
.silkcircuit-editor[data-variant="vibrant"] .sc-string {
  color: #ff99ff;
  font-style: italic;
}
.silkcircuit-editor[data-variant="vibrant"] .sc-function {
  color: #00ffcc;
  font-weight: bold;
  font-style: italic;
}

/* Soft variant */
.silkcircuit-editor[data-variant="soft"] {
  background-color: #1a1626;
  color: #f8f8f2;
}

.silkcircuit-editor[data-variant="soft"] .sc-keyword {
  color: #e892ff;
  font-weight: bold;
}
.silkcircuit-editor[data-variant="soft"] .sc-string {
  color: #ffc2ff;
  font-style: italic;
}
.silkcircuit-editor[data-variant="soft"] .sc-function {
  color: #99ffee;
  font-weight: bold;
  font-style: italic;
}

/* Glow variant */
.silkcircuit-editor[data-variant="glow"] {
  background-color: #0a0816;
  color: #ffffff;
}

.silkcircuit-editor[data-variant="glow"] .sc-keyword {
  color: #ff00ff;
  font-weight: bold;
  text-shadow: 0 0 5px #ff00ff40;
}
.silkcircuit-editor[data-variant="glow"] .sc-string {
  color: #ff99ff;
  font-style: italic;
}
.silkcircuit-editor[data-variant="glow"] .sc-function {
  color: #00ffff;
  font-weight: bold;
  font-style: italic;
  text-shadow: 0 0 5px #00ffff40;
}

/* Dawn variant (light theme) */
.silkcircuit-editor[data-variant="dawn"] {
  background-color: #faf8ff;
  color: #2b2540;
}

.silkcircuit-editor[data-variant="dawn"] .sc-keyword {
  color: #7e2bd5;
  font-weight: bold;
}
.silkcircuit-editor[data-variant="dawn"] .sc-string {
  color: #9c4a88;
  font-style: italic;
}
.silkcircuit-editor[data-variant="dawn"] .sc-function {
  color: #007f8e;
  font-weight: bold;
  font-style: italic;
}
```

### Web Dashboard with Variant Support

```css
.silkcircuit-dashboard {
  min-height: 100vh;
  color: #f8f8f2;
  font-family:
    "Inter",
    -apple-system,
    BlinkMacSystemFont,
    sans-serif;
}

/* Neon variant dashboard */
.silkcircuit-dashboard[data-variant="neon"] {
  background: linear-gradient(135deg, #12101a 0%, #0a0812 100%);
}

.silkcircuit-dashboard[data-variant="neon"] .sc-card {
  background: #1a162a;
  border: 1px solid #80ffea40;
  border-radius: 8px;
  padding: var(--sc-space-lg);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.silkcircuit-dashboard[data-variant="neon"] .sc-card:hover {
  border-color: #80ffea;
  box-shadow: 0 4px 20px #80ffea20;
  transform: translateY(-2px);
}

/* Glow variant dashboard */
.silkcircuit-dashboard[data-variant="glow"] {
  background: linear-gradient(135deg, #0a0816 0%, #000000 100%);
  color: #ffffff;
}

.silkcircuit-dashboard[data-variant="glow"] .sc-card {
  background: #1a0033;
  border: 1px solid #00ffff40;
  box-shadow: 0 0 10px #ff00ff20;
}

.silkcircuit-dashboard[data-variant="glow"] .sc-card:hover {
  border-color: #00ffff;
  box-shadow:
    0 0 20px #ff00ff40,
    0 4px 20px #00ffff20;
  transform: translateY(-2px);
}
```

### React Native Multi-Variant Theme

```javascript
// SilkCircuit React Native theme system
const variantColors = {
  neon: {
    primary: "#e135ff",
    secondary: "#ff99ff",
    accent: "#80ffea",
    background: "#12101a",
    surface: "#1a162a",
    text: "#f8f8f2"
  },
  vibrant: {
    primary: "#ff00ff",
    secondary: "#ff99ff",
    accent: "#00ffcc",
    background: "#0f0c1a",
    surface: "#0a0614",
    text: "#f8f8f2"
  },
  soft: {
    primary: "#e892ff",
    secondary: "#ffc2ff",
    accent: "#99ffee",
    background: "#1a1626",
    surface: "#3e3456",
    text: "#f8f8f2"
  },
  glow: {
    primary: "#ff00ff",
    secondary: "#ff99ff",
    accent: "#00ffff",
    background: "#0a0816",
    surface: "#1a0033",
    text: "#ffffff"
  },
  dawn: {
    primary: "#7e2bd5",
    secondary: "#9c4a88",
    accent: "#007f8e",
    background: "#faf8ff",
    surface: "#f1ecff",
    text: "#2b2540"
  }
}

export const createSilkCircuitTheme = (variant = "neon") => ({
  colors: {
    ...variantColors[variant],
    success: variant === "glow" ? "#00ff00" : variant === "dawn" ? "#2d8659" : "#50fa7b",
    warning: variant === "glow" ? "#ffff00" : variant === "dawn" ? "#a88600" : "#f1fa8c",
    error: variant === "glow" ? "#ff0066" : variant === "dawn" ? "#c1272d" : "#ff6363"
  },
  spacing: {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48
  },
  typography: {
    h1: {
      fontSize: 28,
      fontWeight: "700",
      color: variantColors[variant].primary,
      lineHeight: 32
    },
    body: {
      fontSize: 16,
      fontWeight: "400",
      color: variantColors[variant].text,
      lineHeight: 22
    },
    code: {
      fontFamily: Platform.OS === "ios" ? "SF Mono" : "monospace",
      fontSize: 14,
      color: variantColors[variant].accent
    }
  }
})
```

### Terminal Configuration (All Variants)

```json
// Neon variant terminal theme
{
  "name": "SilkCircuit Neon",
  "background": "#12101a",
  "foreground": "#f8f8f2",
  "cursor": "#80ffea",
  "selection": "#44475a",
  "black": "#12101a",
  "red": "#ff99ff",
  "green": "#50fa7b",
  "yellow": "#f1fa8c",
  "blue": "#e135ff",
  "magenta": "#ff00ff",
  "cyan": "#80ffea",
  "white": "#f8f8f2"
}

// Glow variant terminal theme
{
  "name": "SilkCircuit Glow",
  "background": "#0a0816",
  "foreground": "#ffffff",
  "cursor": "#00ffff",
  "selection": "#ff00ff44",
  "black": "#000000",
  "red": "#ff0066",
  "green": "#00ff00",
  "yellow": "#ffff00",
  "blue": "#0099ff",
  "magenta": "#ff00ff",
  "cyan": "#00ffff",
  "white": "#ffffff"
}

// Dawn variant terminal theme (light)
{
  "name": "SilkCircuit Dawn",
  "background": "#faf8ff",
  "foreground": "#2b2540",
  "cursor": "#7e2bd5",
  "selection": "#d4c8f0",
  "black": "#2b2540",
  "red": "#c1272d",
  "green": "#2d8659",
  "yellow": "#a88600",
  "blue": "#2563eb",
  "magenta": "#7e2bd5",
  "cyan": "#007f8e",
  "white": "#faf8ff"
}
```

### Marketing Hero Section with Variant Theming

```css
/* Base hero styles */
.silkcircuit-hero {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  text-align: center;
  position: relative;
  overflow: hidden;
  font-family:
    "Inter",
    -apple-system,
    BlinkMacSystemFont,
    sans-serif;
}

/* Neon variant hero */
.silkcircuit-hero[data-variant="neon"] {
  background:
    radial-gradient(circle at center, #e135ff20 0%, transparent 50%),
    linear-gradient(135deg, #12101a 0%, #0a0812 100%);
}

.silkcircuit-hero[data-variant="neon"] .hero-title {
  background: linear-gradient(45deg, #e135ff, #ff99ff, #80ffea);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: neonGlow 2s ease-in-out infinite alternate;
}

@keyframes neonGlow {
  from {
    filter: drop-shadow(0 0 20px #e135ff40);
  }
  to {
    filter: drop-shadow(0 0 40px #e135ff80);
  }
}

/* Glow variant hero */
.silkcircuit-hero[data-variant="glow"] {
  background:
    radial-gradient(circle at center, #ff00ff30 0%, transparent 50%),
    linear-gradient(135deg, #0a0816 0%, #000000 100%);
}

.silkcircuit-hero[data-variant="glow"] .hero-title {
  background: linear-gradient(45deg, #ff00ff, #00ffff, #ffff00);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  animation: ultraGlow 2s ease-in-out infinite alternate;
}

@keyframes ultraGlow {
  from {
    filter: drop-shadow(0 0 30px #ff00ff60) drop-shadow(0 0 60px #00ffff40);
  }
  to {
    filter: drop-shadow(0 0 50px #ff00ff80) drop-shadow(0 0 80px #00ffff60);
  }
}

/* Responsive hero title */
.hero-title {
  font-size: clamp(2.5rem, 8vw, 5rem);
  font-weight: 800;
  margin-bottom: var(--sc-space-lg);
  line-height: 1.1;
  letter-spacing: -0.02em;
}
```

---

## 🎯 Best Practices

### DO ✓

- Use semantic colors consistently across all applications
- Maintain WCAG AA contrast ratios in all variants
- Apply glow effects sparingly for maximum impact
- Follow the 4px spacing scale for all layouts
- Test across all five variants before shipping
- Use CSS custom properties for easy variant switching

### DON'T ✗

- Mix semantic meanings between contexts
- Use more than 3 electric colors in one interface section
- Apply bright backgrounds to large text areas
- Override contrast ratios for aesthetic reasons
- Use animations that distract from content
- Forget to test keyboard navigation

---

## 🎯 Implementation Checklist

When creating new SilkCircuit implementations:

### Planning Phase

- [ ] Define which variants will be supported
- [ ] Map design elements to semantic color meanings
- [ ] Plan responsive breakpoints and scaling
- [ ] Consider accessibility requirements

### Development Phase

- [ ] Implement CSS custom properties for variant switching
- [ ] Add semantic class names (`.sc-keyword`, `.sc-function`, etc.)
- [ ] Test all interactive states (hover, focus, active, disabled)
- [ ] Validate contrast ratios with automated tools

### Testing Phase

- [ ] Test across all supported variants
- [ ] Validate keyboard navigation paths
- [ ] Run automated accessibility tests
- [ ] Test on different devices and screen sizes
- [ ] Verify performance with animations enabled

### Launch Phase

- [ ] Document variant usage in user guides
- [ ] Provide easy variant switching mechanism
- [ ] Monitor user feedback on color preferences
- [ ] Plan iteration based on usage analytics

---

_Remember: SilkCircuit is about enhancing focus through purposeful electric energy. Every glow should serve the user's workflow._
