# Best Practices

Guidelines for implementing SilkCircuit in your projects.

## Do

### Use semantic colors consistently

Every color should carry the same meaning across your entire application.

```css
/* Always use keywords = purple, functions = cyan */
.keyword {
  color: var(--sc-purple);
}
.function {
  color: var(--sc-cyan);
}
```

### Maintain WCAG AA contrast ratios

Never sacrifice accessibility for aesthetics.

```css
/* Test all color combinations */
:silkcircuitcontrast;
```

### Apply glow effects sparingly

Maximum impact comes from restraint.

```css
/* One glow effect per section maximum */
.hero-title {
  text-shadow: 0 0 20px var(--sc-purple);
}
```

### Follow the 4px spacing scale

Consistent spacing creates visual harmony.

```css
/* Use spacing tokens */
padding: var(--sc-space-md); /* 16px */
gap: var(--sc-space-lg); /* 24px */
```

### Test across all variants

What works in Neon may need adjustment in Dawn.

```lua
-- Test each variant before shipping
:SilkCircuit neon
:SilkCircuit vibrant
:SilkCircuit soft
:SilkCircuit glow
:SilkCircuit dawn
```

### Use CSS custom properties

Enable easy variant switching.

```css
/* Define once, use everywhere */
:root {
  --sc-purple: #e135ff;
}
.keyword {
  color: var(--sc-purple);
}
```

## Don't

### Mix semantic meanings

Don't use purple for functions or cyan for keywords.

```css
/* Wrong */
.function {
  color: var(--sc-purple);
}

/* Right */
.function {
  color: var(--sc-cyan);
}
```

### Use more than 3 electric colors per section

Too many neon colors create visual noise.

```css
/* Keep it focused */
.card {
  border-color: var(--sc-cyan); /* One accent */
  /* Not: purple border, pink shadow, yellow glow */
}
```

### Apply bright backgrounds to large areas

Dark backgrounds with electric accents, not the reverse.

```css
/* Wrong */
.main-content {
  background: var(--sc-purple);
}

/* Right */
.main-content {
  background: var(--sc-bg);
}
.accent {
  color: var(--sc-purple);
}
```

### Override contrast ratios

Accessibility is non-negotiable.

```css
/* Never reduce contrast for "softer" look */
/* Use the Soft variant instead */
```

### Use distracting animations

Motion should enhance, not overwhelm.

```css
/* Wrong */
.element {
  animation: rainbow-pulse 0.5s infinite;
}

/* Right */
.element:hover {
  transition: all 0.25s ease;
  transform: translateY(-2px);
}
```

### Forget keyboard navigation

Every interactive element must be keyboard accessible.

## Implementation Checklist

### Planning Phase

- [ ] Define which variants will be supported
- [ ] Map design elements to semantic colors
- [ ] Plan responsive breakpoints
- [ ] Consider accessibility requirements

### Development Phase

- [ ] Implement CSS custom properties
- [ ] Add semantic class names
- [ ] Test interactive states (hover, focus, active)
- [ ] Validate contrast ratios

### Testing Phase

- [ ] Test across all supported variants
- [ ] Validate keyboard navigation
- [ ] Run accessibility tests
- [ ] Test on different devices
- [ ] Verify animation performance

### Launch Phase

- [ ] Document variant usage
- [ ] Provide variant switching mechanism
- [ ] Monitor user feedback
- [ ] Plan iteration based on usage

## Component Patterns

### Buttons

```css
.sc-btn-primary {
  background: linear-gradient(45deg, var(--sc-purple), var(--sc-pink));
  color: white;
  border: none;
  padding: var(--sc-space-sm) var(--sc-space-lg);
  border-radius: 6px;
  transition: all 0.25s ease;
}

.sc-btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px var(--sc-purple);
}
```

### Cards

```css
.sc-card {
  background: var(--sc-bg-highlight);
  border: 1px solid var(--sc-cyan);
  border-radius: 8px;
  padding: var(--sc-space-lg);
  transition: all 0.25s ease;
}

.sc-card:hover {
  border-color: var(--sc-cyan);
  box-shadow: 0 4px 20px var(--sc-cyan);
}
```

### Form Inputs

```css
.sc-input {
  background: var(--sc-bg-dark);
  border: 1px solid var(--sc-purple);
  color: var(--sc-fg);
  padding: var(--sc-space-sm);
  border-radius: 4px;
}

.sc-input:focus {
  outline: none;
  border-color: var(--sc-cyan);
  box-shadow: 0 0 0 2px var(--sc-cyan);
}
```

## Performance Tips

1. **Preload critical fonts**: Prevent flash of unstyled text
2. **Use CSS containment**: Isolate animated elements
3. **Lazy load heavy assets**: Don't block initial render
4. **Minimize paint areas**: Use transform/opacity for animations

## Resources

- [SilkCircuit Color System](/design/colors)
- [Accessibility Guidelines](/design/accessibility)
- [Semantic Color Mapping](/design/semantic)
- [Typography System](/design/typography)
