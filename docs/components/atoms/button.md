# GMRD Component Specification: Primary Filled Button (Atom)

**Component ID**: `GMRD-ATOM-BTN-001`  
**File Location**: `docs/components/atoms/button.md`  
**Review Status**: Step 19.0 Final Quality Review Passed  
**Governance Sign-off**: Design System Maintainer & Structural Documentation Writer (Anik)  

---

## 1. Overview & Purpose
The Primary Filled Button is the core call-to-action primitive across all HABOT platforms. It provides a high-emphasis visual trigger for primary user workflows (e.g., "Save & Continue", "Submit Entry"). The component uses Material Design 3 surface tinting and strictly enforces touch target accessibility rules to guarantee error-free operation on high-density mobile displays.

## 2. Anatomy & Structural Hierarchy
- **Container**: Rounded rectangle pill with 100px corner radius (`radiusFull`).
- **Icon (Optional)**: 18x18dp leading icon set in `onPrimary` color token.
- **Label**: Bold typography set in `Label Large` (14px, 700 weight, 0.8 letter spacing).
- **State Layer**: Interactive Material ripple overlay.

## 3. Design Token Cross-References
| Property | Design Token Reference | Default Value |
| :--- | :--- | :--- |
| **Background Fill** | `md.sys.color.primary` | Indigo (`#3F51B5`) |
| **Label Text Color** | `md.sys.color.on-primary` | White (`#FFFFFF`) |
| **Min Touch Height** | `md.sys.touch.min-height` | `48.0dp` |
| **Min Touch Width** | `md.sys.touch.min-width` | `48.0dp` |
| **Corner Radius** | `md.sys.shape.corner.full` | `100.0dp` |

## 4. Accessibility & Touch Target Sizing
- **WCAG 2.1 Level**: AA & AAA Compliant.
- **Touch Boundary**: Hard-constrained to `minHeight: 48.0dp`, `minWidth: 48.0dp` (meets WCAG 44–48dp requirements).
- **Contrast Ratio**: Minimum 4.5:1 against page background.

## 5. Responsive Viewport Scaling
- **Mobile (< 600dp)**: Expands to full container width (`width: double.infinity`), height fixed at `48dp`.
- **Tablet (600dp – 839dp)**: Auto-sizes to text label + padding, maintaining `48dp` touch height.
- **Desktop (>= 840dp)**: Auto-sizes with hover elevation state layer enabled.

## 6. Interaction States
1. **Default**: Resting elevation level 0, 100% opacity fill.
2. **Hover**: Primary container dims by 8% tint overlay.
3. **Pressed**: Scales down to 0.98 for 150ms tactile feedback.
4. **Disabled**: 38% opacity, `pointer-events: none`.
5. **Loading**: Label replaced with 18dp centered `CircularProgressIndicator`.

## 7. Usage Guidelines & Scenario Rules
- **DO**: Use a single filled button per action region.
- **DO**: Enforce a minimum $48\times 48\text{dp}$ touch bounding box on mobile viewports.
- **DON'T**: Place two primary filled buttons in the same container.
- **DON'T**: Hardcode pixel dimensions omitted from token specs.

## 8. Governance & Poka-Yoke Linter Rules
- **Poka-Yoke Linter Rule**: CI/CD build pipelines reject front-end updates instantly if hardcoded dimensions override tokenized specification bounds.
