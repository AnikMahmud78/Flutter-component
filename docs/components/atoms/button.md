# GMRD Component Specification: Primary Filled Button (Atom)

**Component ID**: `GMRD-ATOM-BTN-001`  
**File Location**: `docs/components/atoms/button.md`  
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

### 7.1 Optimal Application Context
- **Primary Page Action**: Use the filled button exclusively for the single primary action on a screen (e.g., "Save & Continue", "Submit Entry", "Finalize Offboarding").
- **Modal Dialog Confirmation**: Serves as the affirmative primary trigger in alert and confirmation dialogs.
- **Form Submissions**: Placed at the bottom of data entry forms, locked until all required fields pass validation.

### 7.2 Do's and Don'ts Matrix
| Rule Type | Guidance | Rationale |
| :--- | :--- | :--- |
| **DO** | Use a single filled button per action region. | Prevents visual hierarchy confusion for the user. |
| **DO** | Enforce a minimum $48\times 48\text{dp}$ touch bounding box on mobile viewports. | Guarantees WCAG 2.1 AA/AAA accessibility compliance. |
| **DO** | Display a centered loading indicator during background async requests. | Prevents duplicate form submissions and indicates active processing. |
| **DON'T** | Place two primary filled buttons in the same container. | Pair a primary filled button with an outlined or text button instead. |
| **DON'T** | Hardcode pixel widths or margins (e.g., `width: 320px`). | Hardcoded pixel values cause layout breaking across varying screen sizes. |
| **DON'T** | Use ambiguous labels like "OK" or "Click Here". | Use action-oriented verbs (e.g., "Approve Request", "Save Changes"). |

### 7.3 Viewport Layout Mapping & Responsive Scaling
```
[Mobile < 600dp]       --> Full-width container (width: double.infinity, minHeight: 48dp)
[Tablet 600dp - 839dp] --> Auto-sized width with 24dp horizontal padding (minHeight: 48dp)
[Desktop >= 840dp]     --> Auto-sized width with hover elevation overlay and keyboard focus ring
```

### 7.4 Accessibility & Hit Target Regulations
- **Touch Boundary Target**: Must never shrink below $48\times 48\text{dp}$ on mobile viewports.
- **Contrast Ratio**: Minimum 4.5:1 ratio between text (`md.sys.color.on-primary`) and container (`md.sys.color.primary`).
- **Screen Reader Labeling**: Include explicit `semanticsLabel` attributes for screen reader announcement.

## 8. Code Snippet & Usage Rules
```dart
ConstrainedBox(
  constraints: const BoxConstraints(minWidth: 48.0, minHeight: 48.0),
  child: SizedBox(
    width: double.infinity,
    height: 48.0,
    child: FilledButton.icon(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      onPressed: isLoading ? null : () {},
      icon: const Icon(Icons.check_circle_rounded, size: 18),
      label: const Text('SUBMIT_ENTRY'),
    ),
  ),
);
```

## 9. Governance & Poka-Yoke Rules

- **Poka-Yoke Linter Rule**: CI/CD build pipelines reject front-end updates instantly if hardcoded dimensions (e.g., `height: 32px`) override tokenized specification bounds.
