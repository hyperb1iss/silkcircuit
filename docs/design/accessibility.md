# Accessibility

SilkCircuit is designed with accessibility as a core principle.

## WCAG AA Compliance

Contrast is measured rather than asserted. The test suite computes every ratio from the WCAG formula and fails if any pair falls under its bar, and `:checkhealth silkcircuit` reports the text numbers for whichever variant you are running.

| Criterion          | Requirement   | SilkCircuit                                                               |
| ------------------ | ------------- | ------------------------------------------------------------------------- |
| Normal text        | 4.5:1 minimum | Gated for every text color on the page, the float body and the cursorline |
| Large text (18pt+) | 3:1 minimum   | Covered by the stricter 4.5:1 text bar                                    |
| UI elements        | 3:1 minimum   | Gated for borders, gutters, indent guides and the ANSI normals            |
| Graphics           | 3:1 minimum   | A design target, not machine-checked                                      |

`:checkhealth silkcircuit` runs the narrower version of the text check, measuring each distinct text color against the active variant's own background. On neon it reports 19 colors checked and no issues.

## Variant Accessibility

Each variant is optimized for different conditions:

### Neon

Full WCAG AA compliance with standard dark-theme contrast.

### Vibrant

Enhanced contrast for work in various lighting conditions.

### Soft

Optimized for extended use. Reduces eye strain while maintaining readability.

### Glow

Maximum contrast with pure neon on ultra-dark backgrounds. Ideal for:

- Low-light environments
- OLED displays
- Users who prefer high contrast

### Dawn

Light theme optimized for:

- Bright environments
- Daytime work
- Users who prefer light themes
- Outdoor laptop use

## Testing Tools

### Neovim

```vim
:SilkCircuitContrast
```

Validates all highlight group contrast ratios against WCAG AA standards.

### Web

```bash
# Install axe-core CLI
npm install -g @axe-core/cli

# Test your implementation
axe-cli --tags wcag2a,wcag2aa
```

### Manual Testing

| Tool                                                                                      | Purpose                        |
| ----------------------------------------------------------------------------------------- | ------------------------------ |
| [Contrast Checker](https://webaim.org/resources/contrastchecker/)                         | Verify specific color pairs    |
| [Colorblind Simulator](https://www.color-blindness.com/coblis-color-blindness-simulator/) | Test color blindness scenarios |
| Screen reader                                                                             | Verify content accessibility   |

## Keyboard Navigation

All SilkCircuit implementations should support:

- **Focus indicators**: Cyan glow (`#80ffea`) clearly shows focus state
- **Tab order**: Logical flow through interactive elements
- **Skip links**: Available for screen reader users
- **No keyboard traps**: Users can always navigate away

### Focus Indicator Style

```css
.sc-focusable:focus {
  outline: none;
  box-shadow: 0 0 0 2px var(--sc-cyan);
}

.sc-focusable:focus-visible {
  box-shadow:
    0 0 0 2px var(--sc-cyan),
    0 0 8px var(--sc-cyan);
}
```

## Screen Reader Support

### Requirements

- Semantic HTML structure
- Proper ARIA labels and roles
- Alternative text for meaningful graphics
- Color never conveys information alone

### Color Blindness Considerations

SilkCircuit uses shapes and patterns alongside color:

| Indicator  | Color  | Additional Cue           |
| ---------- | ------ | ------------------------ |
| Error      | Red    | Warning icon, text label |
| Success    | Green  | Checkmark, text label    |
| Warning    | Yellow | Caution icon, text label |
| Git add    | Green  | `+` prefix               |
| Git delete | Red    | `-` prefix               |

## Motion Sensitivity

For users with vestibular disorders:

```css
@media (prefers-reduced-motion: reduce) {
  .sc-animated {
    animation: none;
    transition: none;
  }
}
```

All SilkCircuit animations respect this media query.

## Checklist

### Development

- [ ] All text meets 4.5:1 contrast ratio
- [ ] Interactive elements have 3:1 contrast
- [ ] Focus indicators are clearly visible
- [ ] Keyboard navigation works throughout
- [ ] Color is not the only indicator of meaning

### Testing

- [ ] Run `:SilkCircuitContrast` in Neovim
- [ ] Test with keyboard-only navigation
- [ ] Verify with screen reader
- [ ] Check reduced motion preference
- [ ] Test in all five variants

## Resources

- [WCAG 2.1 Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Inclusive Components](https://inclusive-components.design/)
- [A11y Project](https://www.a11yproject.com/)
