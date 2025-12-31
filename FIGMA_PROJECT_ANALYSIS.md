# Figma Design & Project Structure Analysis
## Wynante || Anchor Up

**Figma Design Link:** [Wynante || Anchor Up](https://www.figma.com/design/I9lcVzTuS4q1CuLJrOK14w/Wynante-%7C%7C-Anchor-Up?node-id=0-1&p=f&t=ZigceqPHqbsJn4NH-0)

**Analysis Date:** 2025-01-27

---

## 📋 Executive Summary

This document provides a comprehensive analysis of the Wynante Flutter project structure and its alignment with the Figma design specifications. The project appears to be in early development stages with a solid foundation but requires implementation of most UI screens.

---

## 🏗️ Current Project Structure

### ✅ **Well-Organized Foundation**

```
wynante/
├── lib/
│   ├── core/                    # Design system & constants
│   │   ├── app_colors.dart      # Color palette (⚠️ Note: References ScoreLivePro)
│   │   ├── app_padding.dart     # Responsive padding utilities
│   │   ├── app_spacing.dart     # Responsive spacing utilities
│   │   ├── app_strings.dart     # App strings (⚠️ Note: References ScoreLivePro)
│   │   ├── assets_manager.dart  # Asset path constants
│   │   └── font_manager.dart    # Typography system
│   ├── custom_widget/           # Reusable widgets
│   │   ├── home_widget/
│   │   └── mini_widget/
│   ├── models/                  # Data models (empty)
│   ├── providers/               # State management (empty)
│   ├── services/                # Business logic (empty)
│   ├── views/                   # Screen implementations
│   │   ├── auth/
│   │   │   ├── login/           # Empty
│   │   │   └── sign_up/         # Empty
│   │   ├── community/           # Empty
│   │   ├── home/                # Empty
│   │   ├── info_onborading/     # Empty (typo: onboarding)
│   │   ├── matches/             # Empty
│   │   ├── messaging/           # Empty
│   │   ├── onboarding/          # Empty
│   │   ├── profile/             # Empty
│   │   └── splash/
│   │       └── splash_screen.dart # Placeholder only
│   ├── app.dart                 # Main app widget
│   └── main.dart                # Entry point
└── assets/
    ├── icons/
    ├── images/
    └── svgs/
```

---

## 🎨 Design System Analysis

### **Color System** (`app_colors.dart`)

**Status:** ✅ Comprehensive color palette defined

**Key Colors:**
- **Primary:** `#FF7931` (Orange) - Primary brand color
- **Background:** `#F0F0F0` (Light grey)
- **Text:** Multiple shades from black to light grey
- **Semantic:** Success, Error, Warning, Info colors defined
- **UI Elements:** Border, divider, input field, button colors

**⚠️ Issue:** Comments reference "ScoreLivePro" instead of "Wynante"

### **Typography System** (`font_manager.dart`)

**Status:** ✅ Well-structured typography hierarchy

**Font Families:**
- Primary: Poppins
- Secondary: Inter
- Display: Roboto
- Body: Montserrat

**Text Styles:**
- Display (Large, Medium, Small)
- Headings (H1-H4)
- Body (Large, Medium, Small)
- Labels (Large, Medium, Small)
- Sports-specific styles (Match Score, Team Name, League Name)

**⚠️ Issue:** Comments reference "ScoreLivePro" instead of "Wynante"

### **Spacing & Layout** (`app_padding.dart`, `app_spacing.dart`)

**Status:** ✅ Responsive spacing system implemented

**Features:**
- Responsive padding utilities (using `flutter_screenutil`)
- Border radius utilities
- Horizontal, vertical, and mixed padding options
- Comprehensive spacing system (heights & widths)

### **Strings** (`app_strings.dart`)

**Status:** ✅ Extensive string constants defined

**Coverage:**
- Authentication (Login, Sign Up, OTP, Forgot Password)
- Home screen
- Leagues, Teams, Matches
- News
- Favorites
- Notifications
- Settings
- Match Details
- Validation & Error messages

**⚠️ Issue:** All strings reference "ScoreLivePro" instead of "Wynante"

---

## 📱 Screen Structure Analysis

### **Implemented Screens**

| Screen | Status | Notes |
|--------|--------|-------|
| Splash Screen | ⚠️ Placeholder | Only contains `Placeholder()` widget |

### **Planned Screens (Directory Structure)**

| Screen | Directory | Status | Priority |
|--------|-----------|--------|----------|
| Splash | `views/splash/` | ⚠️ Placeholder | 🔴 High |
| Onboarding | `views/onboarding/` | ❌ Empty | 🔴 High |
| Info Onboarding | `views/info_onborading/` | ❌ Empty | 🟡 Medium |
| Login | `views/auth/login/` | ❌ Empty | 🔴 High |
| Sign Up | `views/auth/sign_up/` | ❌ Empty | 🔴 High |
| Home | `views/home/` | ❌ Empty | 🔴 High |
| Matches | `views/matches/` | ❌ Empty | 🟡 Medium |
| Messaging | `views/messaging/` | ❌ Empty | 🟡 Medium |
| Community | `views/community/` | ❌ Empty | 🟡 Medium |
| Profile | `views/profile/` | ❌ Empty | 🟡 Medium |

**Note:** Directory name typo: `info_onborading` should be `info_onboarding`

---

## 🔧 Technical Stack

### **Dependencies** (`pubspec.yaml`)

```yaml
dependencies:
  flutter_screenutil: ^5.9.3    # Responsive design
  google_fonts: ^6.3.3           # Typography
  flutter_svg: ^2.2.3            # SVG support
  cupertino_icons: ^1.0.8        # iOS icons
```

**Missing Dependencies (Likely Needed):**
- State management (Provider, Riverpod, Bloc, etc.)
- Navigation (go_router, auto_route, etc.)
- HTTP client (dio, http, etc.)
- Local storage (shared_preferences, hive, etc.)
- Image handling (cached_network_image, etc.)

### **Configuration**

- **Design Size:** `375 x 812` (iPhone X/11/12 standard)
- **SDK Version:** `^3.10.4`
- **Platforms:** Android, iOS, Web, Linux, macOS, Windows

---

## 🎯 Figma Design Alignment Checklist

### **To Verify from Figma:**

1. **Color Palette**
   - [ ] Verify primary color `#FF7931` matches Figma
   - [ ] Verify all semantic colors match
   - [ ] Check for any missing brand colors

2. **Typography**
   - [ ] Verify font families (Poppins, Inter, etc.) match Figma
   - [ ] Verify font sizes match design specifications
   - [ ] Check font weights for each text style

3. **Spacing System**
   - [ ] Verify spacing values (4, 8, 12, 16, etc.) match Figma grid
   - [ ] Check border radius values match design

4. **Component Library**
   - [ ] Identify reusable components in Figma
   - [ ] Map components to `custom_widget/` structure
   - [ ] Check button styles, input fields, cards, etc.

5. **Screen Flow**
   - [ ] Map all screens in Figma to `views/` structure
   - [ ] Identify navigation flow
   - [ ] Check for missing screens

6. **Assets**
   - [ ] Verify all images, icons, SVGs are exported from Figma
   - [ ] Check asset naming conventions
   - [ ] Verify asset sizes and formats

---

## 🚨 Issues & Recommendations

### **Critical Issues**

1. **⚠️ Brand Name Mismatch**
   - Files reference "ScoreLivePro" instead of "Wynante"
   - **Action:** Update all comments and strings to reflect "Wynante"

2. **⚠️ Typo in Directory Name**
   - `info_onborading` should be `info_onboarding`
   - **Action:** Rename directory

3. **❌ Missing Implementation**
   - Only splash screen exists (as placeholder)
   - All other screens need implementation

### **Recommendations**

1. **State Management**
   - Choose and implement state management solution
   - Consider: Provider, Riverpod, or Bloc

2. **Navigation**
   - Implement navigation system
   - Consider: go_router or auto_route

3. **API Integration**
   - Set up HTTP client and API services
   - Create models for data structures

4. **Asset Management**
   - Export all assets from Figma
   - Organize assets in `assets/` directory
   - Update `assets_manager.dart` with actual asset paths

5. **Component Development**
   - Create reusable components based on Figma design
   - Start with: Buttons, Input Fields, Cards, AppBar

6. **Screen Implementation Priority**
   ```
   Priority 1 (Core Flow):
   1. Splash Screen
   2. Onboarding Screens
   3. Login/Sign Up
   4. Home Screen
   
   Priority 2 (Features):
   5. Profile
   6. Matches
   7. Messaging
   8. Community
   ```

---

## 📊 Implementation Roadmap

### **Phase 1: Foundation (Week 1)**
- [ ] Fix brand name references
- [ ] Fix directory typo
- [ ] Export and organize Figma assets
- [ ] Verify color palette matches Figma
- [ ] Verify typography matches Figma

### **Phase 2: Core Components (Week 1-2)**
- [ ] Implement reusable button components
- [ ] Implement input field components
- [ ] Implement card components
- [ ] Implement app bar component
- [ ] Implement bottom navigation (if needed)

### **Phase 3: Authentication Flow (Week 2)**
- [ ] Implement splash screen
- [ ] Implement onboarding screens
- [ ] Implement login screen
- [ ] Implement sign up screen
- [ ] Set up navigation between screens

### **Phase 4: Main Features (Week 3-4)**
- [ ] Implement home screen
- [ ] Implement profile screen
- [ ] Implement matches screen
- [ ] Implement messaging screen
- [ ] Implement community screen

### **Phase 5: Integration & Polish (Week 4+)**
- [ ] API integration
- [ ] State management implementation
- [ ] Error handling
- [ ] Loading states
- [ ] Animations and transitions
- [ ] Testing

---

## 📝 Next Steps

1. **Access Figma Design**
   - Review all screens and components
   - Export design tokens (colors, typography, spacing)
   - Export assets (images, icons, SVGs)
   - Document component specifications

2. **Update Project Files**
   - Fix brand name references
   - Fix directory typo
   - Update strings to match Wynante branding

3. **Start Implementation**
   - Begin with splash screen
   - Follow priority order from roadmap
   - Implement components as needed

---

## 🔗 Resources

- **Figma Design:** [Wynante || Anchor Up](https://www.figma.com/design/I9lcVzTuS4q1CuLJrOK14w/Wynante-%7C%7C-Anchor-Up?node-id=0-1&p=f&t=ZigceqPHqbsJn4NH-0)
- **Flutter Documentation:** https://flutter.dev/docs
- **ScreenUtil Package:** https://pub.dev/packages/flutter_screenutil
- **Google Fonts:** https://fonts.google.com/

---

**Document Version:** 1.0  
**Last Updated:** 2025-01-27

