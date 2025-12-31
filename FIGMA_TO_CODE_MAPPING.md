# Figma to Code Mapping Guide
## Wynante || Anchor Up

This guide helps map Figma design elements to the Flutter codebase structure.

---

## 🎨 Design Tokens Mapping

### **Colors**

When reviewing Figma, extract these color values and verify against `lib/core/app_colors.dart`:

| Figma Token | Code Reference | Current Value | Status |
|-------------|----------------|---------------|--------|
| Primary/Brand Color | `AppColors.primaryColor` | `#FF7931` | ⚠️ Verify |
| Primary Dark | `AppColors.primaryDark` | `#E6681F` | ⚠️ Verify |
| Primary Light | `AppColors.primaryLight` | `#FF9D6B` | ⚠️ Verify |
| Background | `AppColors.bgColor` | `#F0F0F0` | ⚠️ Verify |
| Surface | `AppColors.surface` | `#FFFFFF` | ⚠️ Verify |
| Text Primary | `AppColors.textPrimary` | `#000000` | ⚠️ Verify |
| Text Secondary | `AppColors.textSecondary` | `#4B4B4B` | ⚠️ Verify |
| Error | `AppColors.error` | `#FF0040` | ⚠️ Verify |
| Success | `AppColors.success` | `#28A745` | ⚠️ Verify |

**Action Items:**
1. Open Figma → Design Tokens / Variables
2. Extract all color values
3. Compare with `app_colors.dart`
4. Update any mismatches

---

### **Typography**

Map Figma text styles to `lib/core/font_manager.dart`:

| Figma Text Style | Code Method | Example Usage |
|------------------|-------------|---------------|
| Display/Large | `FontManager.displayLarge()` | Hero titles |
| Heading 1 | `FontManager.heading1()` | Page titles |
| Heading 2 | `FontManager.heading2()` | Section headings |
| Heading 3 | `FontManager.heading3()` | Subsection headings |
| Body/Large | `FontManager.bodyLarge()` | Important text |
| Body/Medium | `FontManager.bodyMedium()` | Standard text |
| Body/Small | `FontManager.bodySmall()` | Secondary text |
| Label/Medium | `FontManager.labelMedium()` | Button text, labels |

**Action Items:**
1. Open Figma → Text Styles
2. Note font family, size, weight, line height for each style
3. Verify against `font_manager.dart`
4. Update if needed

---

### **Spacing**

Figma spacing should align with `lib/core/app_padding.dart` and `lib/core/app_spacing.dart`:

| Figma Spacing | Code Reference | Value |
|---------------|----------------|-------|
| 4px | `AppPadding.r4` / `AppSpacing.h4` | 4.r / 4.h |
| 8px | `AppPadding.r8` / `AppSpacing.h8` | 8.r / 8.h |
| 12px | `AppPadding.r12` / `AppSpacing.h12` | 12.r / 12.h |
| 16px | `AppPadding.r16` / `AppSpacing.h16` | 16.r / 16.h |
| 24px | `AppPadding.r24` / `AppSpacing.h24` | 24.r / 24.h |
| 32px | `AppPadding.r32` / `AppSpacing.h32` | 32.r / 32.h |

**Action Items:**
1. Check Figma grid system (usually 4px or 8px)
2. Verify spacing values match code
3. Add any missing spacing values

---

## 🧩 Component Mapping

### **Reusable Components**

When you find components in Figma, create them in `lib/custom_widget/`:

#### **Button Components**

**Figma Location:** Components → Buttons

**Code Location:** `lib/custom_widget/mini_widget/buttons/`

**Components to Create:**
- `primary_button.dart` - Main CTA button
- `secondary_button.dart` - Secondary action button
- `outline_button.dart` - Outlined button
- `text_button.dart` - Text-only button
- `icon_button.dart` - Icon button

**Properties to Extract:**
- Background color
- Text color
- Border radius
- Padding
- Font style
- Height
- States (default, pressed, disabled)

#### **Input Field Components**

**Figma Location:** Components → Inputs

**Code Location:** `lib/custom_widget/mini_widget/inputs/`

**Components to Create:**
- `text_input.dart` - Standard text input
- `password_input.dart` - Password field
- `search_input.dart` - Search bar
- `dropdown_input.dart` - Dropdown selector

**Properties to Extract:**
- Border color (default, focused, error)
- Background color
- Border radius
- Padding
- Placeholder text style
- Label text style
- Error message style

#### **Card Components**

**Figma Location:** Components → Cards

**Code Location:** `lib/custom_widget/mini_widget/cards/`

**Components to Create:**
- `match_card.dart` - Match information card
- `news_card.dart` - News article card
- `profile_card.dart` - User profile card
- `stat_card.dart` - Statistics card

**Properties to Extract:**
- Background color
- Border radius
- Shadow/elevation
- Padding
- Spacing between elements

#### **Navigation Components**

**Figma Location:** Components → Navigation

**Code Location:** `lib/custom_widget/mini_widget/navigation/`

**Components to Create:**
- `app_bar.dart` - Custom app bar
- `bottom_nav_bar.dart` - Bottom navigation (if used)
- `tab_bar.dart` - Tab navigation (if used)

---

## 📱 Screen Mapping

### **Screen-by-Screen Checklist**

For each screen in Figma, verify:

1. **Layout Structure**
   - [ ] AppBar/Header design
   - [ ] Content layout (Column, Row, Grid)
   - [ ] Bottom navigation (if applicable)
   - [ ] Floating action button (if applicable)

2. **Components Used**
   - [ ] List all components from Figma
   - [ ] Check if components exist in code
   - [ ] Create missing components

3. **Spacing & Padding**
   - [ ] Measure spacing between elements
   - [ ] Verify padding values
   - [ ] Check alignment

4. **Colors**
   - [ ] Verify all colors match design tokens
   - [ ] Check for any custom colors not in tokens

5. **Typography**
   - [ ] Map all text to text styles
   - [ ] Verify font sizes
   - [ ] Check text colors

6. **Interactions**
   - [ ] Note button states
   - [ ] Check input field states
   - [ ] Document animations/transitions

---

## 📋 Screen Implementation Checklist

### **Splash Screen** (`views/splash/`)

**Figma Location:** Screens → Splash

**Checklist:**
- [ ] Logo/App name
- [ ] Background color/image
- [ ] Loading indicator (if any)
- [ ] Animation (if any)
- [ ] Duration before navigation

**Current Status:** ⚠️ Placeholder only

---

### **Onboarding Screens** (`views/onboarding/`)

**Figma Location:** Screens → Onboarding

**Checklist:**
- [ ] Number of screens
- [ ] Illustration/image per screen
- [ ] Title text style
- [ ] Description text style
- [ ] Skip button
- [ ] Next/Continue button
- [ ] Page indicator (dots)
- [ ] Get Started button on last screen

**Current Status:** ❌ Not implemented

---

### **Login Screen** (`views/auth/login/`)

**Figma Location:** Screens → Auth → Login

**Checklist:**
- [ ] Logo/App name
- [ ] Email input field
- [ ] Password input field
- [ ] Remember me checkbox
- [ ] Forgot password link
- [ ] Login button
- [ ] Social login buttons (Google, Apple, Facebook)
- [ ] Sign up link
- [ ] Error message display

**Current Status:** ❌ Not implemented

---

### **Sign Up Screen** (`views/auth/sign_up/`)

**Figma Location:** Screens → Auth → Sign Up

**Checklist:**
- [ ] Logo/App name
- [ ] Full name input
- [ ] Email input
- [ ] Phone input (if applicable)
- [ ] Password input
- [ ] Confirm password input
- [ ] Terms & conditions checkbox
- [ ] Sign up button
- [ ] Social sign up buttons
- [ ] Login link
- [ ] Error message display

**Current Status:** ❌ Not implemented

---

### **Home Screen** (`views/home/`)

**Figma Location:** Screens → Home

**Checklist:**
- [ ] AppBar with profile/search
- [ ] Welcome message
- [ ] Date display
- [ ] Live matches section
- [ ] Upcoming matches section
- [ ] News section
- [ ] Quick actions
- [ ] Bottom navigation (if applicable)
- [ ] Pull to refresh

**Current Status:** ❌ Not implemented

---

### **Matches Screen** (`views/matches/`)

**Figma Location:** Screens → Matches

**Checklist:**
- [ ] Filter/tab bar (Live, Upcoming, Finished)
- [ ] Match cards list
- [ ] Match card design
- [ ] Empty state
- [ ] Loading state
- [ ] Search functionality

**Current Status:** ❌ Not implemented

---

### **Messaging Screen** (`views/messaging/`)

**Figma Location:** Screens → Messaging

**Checklist:**
- [ ] Chat list
- [ ] Chat item design
- [ ] Message input
- [ ] Send button
- [ ] Message bubbles
- [ ] Timestamp display
- [ ] Empty state

**Current Status:** ❌ Not implemented

---

### **Community Screen** (`views/community/`)

**Figma Location:** Screens → Community

**Checklist:**
- [ ] Community feed
- [ ] Post card design
- [ ] Like/comment buttons
- [ ] Create post button
- [ ] Filter options
- [ ] Empty state

**Current Status:** ❌ Not implemented

---

### **Profile Screen** (`views/profile/`)

**Figma Location:** Screens → Profile

**Checklist:**
- [ ] Profile header (avatar, name, bio)
- [ ] Edit profile button
- [ ] Settings list
- [ ] Logout button
- [ ] Statistics section (if any)
- [ ] Favorites section (if any)

**Current Status:** ❌ Not implemented

---

## 🔍 Figma Inspection Tips

### **How to Extract Design Specs:**

1. **Select Element in Figma**
   - Click on any element
   - Check right panel for properties

2. **Color Values**
   - Look for fill color (hex code)
   - Check opacity if applicable
   - Note if it's a design token/variable

3. **Typography**
   - Check font family
   - Note font size (px)
   - Check font weight
   - Note line height
   - Check letter spacing

4. **Spacing**
   - Use Figma's measurement tool
   - Check padding values
   - Note margins between elements

5. **Components**
   - Check if element is a component instance
   - View component definition
   - Note all variants and states

6. **Export Assets**
   - Select image/icon
   - Right-click → Export
   - Choose format (PNG, SVG)
   - Use appropriate size (@1x, @2x, @3x)

---

## ✅ Verification Workflow

1. **Open Figma Design**
   - Navigate to each screen
   - Document all components used

2. **Compare with Code**
   - Check if component exists
   - Verify properties match
   - Note discrepancies

3. **Update Code**
   - Fix color mismatches
   - Update typography
   - Create missing components
   - Implement missing screens

4. **Test**
   - Visual comparison
   - Responsive behavior
   - Interaction states

---

## 📝 Notes Template

For each screen, create a note file:

```markdown
# [Screen Name] - Figma Analysis

**Figma Location:** [Path in Figma]

## Layout
- Structure: [Column/Row/Grid]
- AppBar: [Yes/No, design details]
- Bottom Nav: [Yes/No]

## Components Used
1. [Component Name] - [Status: Exists/Needs Creation]
2. [Component Name] - [Status: Exists/Needs Creation]

## Colors
- Background: [Color code]
- Primary elements: [Color codes]

## Typography
- Title: [Text style]
- Body: [Text style]

## Spacing
- Main padding: [Value]
- Element spacing: [Value]

## Interactions
- [Button] → [Action]
- [Input] → [Validation]

## Assets Needed
- [Asset name] - [Format] - [Size]
```

---

**Last Updated:** 2025-01-27

