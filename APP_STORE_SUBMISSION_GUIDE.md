# Pasteo - App Store Submission Guide

Complete step-by-step guide to submit Pasteo to the Mac App Store.

---

## Prerequisites ✅

- [x] macOS 14.0+ for testing
- [x] Xcode installed
- [x] Apple Developer Account ($99/year)
- [x] Valid Developer ID certificate
- [ ] App Icon (1024x1024) - **YOU NEED TO CREATE THIS**
- [ ] Screenshots
- [ ] Privacy Policy hosted online

---

## Step 1: Complete App Icon 🎨

**CRITICAL: You must create a unique icon for Pasteo**

### Option A: DIY Design
1. Use Figma, Sketch, or Affinity Designer
2. Create 1024x1024 px icon
3. Export as PNG
4. Use Icon Generator app to create all sizes

### Option B: Hire Designer
- Fiverr: $5-50
- Upwork: $50-200
- 99designs: Design contest

### Replace Icon Files
```bash
cd /Users/haichang/Projects/Maccy/Maccy/Assets.xcassets/AppIcon.appiconset/
# Replace all "AppIcon (Big Sur)-*.png" files with your new icons
```

---

## Step 2: Take Screenshots 📸

### Required Sizes
- 1280 x 800 (minimum)
- 1440 x 900 (recommended)
- 2560 x 1600 (recommended)
- 2880 x 1800 (Retina)

### How to Capture
1. Build and run Pasteo
2. Open clipboard history (⇧⌘C)
3. Use macOS Screenshot tool (⇧⌘5)
4. Capture these scenes:
   - Main interface with items
   - Search in action
   - Pinned items
   - Settings panel (optional)
   - Beautiful UI details

### Tips
- Use colorful sample data
- Show the gradient effects
- Demonstrate key features
- Keep UI clean and attractive

---

## Step 3: Host Privacy Policy 🔒

### Option A: GitHub Pages (Free & Easy)

```bash
# In your Pasteo repository
cp /Users/haichang/Projects/Maccy/PRIVACY_POLICY.md privacy-policy.md
git add privacy-policy.md
git commit -m "Add privacy policy"
git push

# Enable GitHub Pages in repo settings
# URL will be: https://yourusername.github.io/Pasteo/privacy-policy
```

### Option B: Your Own Website
Host the PRIVACY_POLICY.md content on your website

---

## Step 4: Create App Store Connect Listing 🏪

### 4.1 Sign in to App Store Connect
1. Go to https://appstoreconnect.apple.com
2. Sign in with your Apple Developer account
3. Click "My Apps"
4. Click "+" → "New App"

### 4.2 Fill App Information

**Platforms:** macOS

**Name:** Pasteo

**Primary Language:** English

**Bundle ID:** com.haichang.Pasteo

**SKU:** pasteo-clipboard-manager (or any unique identifier)

**User Access:** Full Access

### 4.3 Pricing and Availability

**Price:** Free (or set your price)

**Availability:** All territories (or select specific countries)

### 4.4 App Information

**Category:**
- Primary: Productivity
- Secondary: Utilities (optional)

**App Subtitle:** Modern Clipboard Manager

**Privacy Policy URL:** (Your GitHub Pages or website URL)

**Support URL:** https://github.com/haichang/Pasteo

**Marketing URL:** https://github.com/haichang/Pasteo (optional)

---

## Step 5: Prepare Build Archive 📦

### 5.1 Clean Build
```bash
cd /Users/haichang/Projects/Maccy
xcodebuild clean -project Maccy.xcodeproj -scheme Maccy -configuration Release
```

### 5.2 Archive via Xcode (RECOMMENDED)

1. Open Xcode:
```bash
open Maccy.xcodeproj
```

2. In Xcode:
   - Select "Any Mac" as destination (top bar)
   - Product → Archive (or ⌘B then wait, then Product → Archive)
   - Wait for archiving to complete

3. Organizer window will open:
   - Select your archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Click "Upload"
   - Follow the wizard

### 5.3 Archive via Command Line (Advanced)

```bash
xcodebuild archive \
  -project Maccy.xcodeproj \
  -scheme Maccy \
  -configuration Release \
  -archivePath ~/Desktop/Pasteo.xcarchive

xcodebuild -exportArchive \
  -archivePath ~/Desktop/Pasteo.xcarchive \
  -exportPath ~/Desktop/PasteoExport \
  -exportOptionsPlist exportOptions.plist
```

---

## Step 6: Upload to App Store 📤

### Via Xcode Organizer (Easiest)
1. Window → Organizer (⌥⌘⇧O)
2. Select "Pasteo" archive
3. Click "Distribute App"
4. Select "App Store Connect"
5. Click "Upload"
6. Wait for processing

### Via Transporter App
1. Download Transporter from Mac App Store
2. Sign in with Apple ID
3. Drag your .pkg file
4. Click "Deliver"

---

## Step 7: Submit for Review 🎯

### 7.1 In App Store Connect

1. Go to your app → "1.0.0 Prepare for Submission"
2. Fill in all required fields:

**App Information:**
- Description (see AppStoreMetadata.md)
- Keywords
- Screenshots (upload your captures)
- App Icon (1024x1024)

**Version Information:**
- What's New in This Version
- Promotional Text (optional)
- Support URL
- Marketing URL

**Rating:**
- Complete the questionnaire
- Pasteo should be rated 4+

**App Review Information:**
- Contact Information (your email)
- Notes for Review:
  ```
  Pasteo is a clipboard manager that runs in the menu bar.

  To test:
  1. Launch Pasteo (it appears in menu bar)
  2. Copy some text (⌘C)
  3. Press ⇧⌘C to open history
  4. Click any item to copy it
  5. Paste with ⌘V

  The app requires Accessibility permission for auto-paste feature (optional).
  All data is stored locally on the device.
  ```

**Version Release:**
- Choose "Automatically release" or "Manually release"

3. Click "Submit for Review"

---

## Step 8: Wait for Review 🕐

- Review typically takes 1-3 days
- Check email for updates
- Respond promptly to any issues

### Common Rejection Reasons
1. **Missing Privacy Policy** - Make sure URL is valid
2. **Functionality Issues** - Test thoroughly before submitting
3. **Misleading Description** - Be accurate in what app does
4. **Guideline Violations** - Follow App Store Review Guidelines

---

## Troubleshooting 🔧

### Archive Fails
```bash
# Clean derived data
rm -rf ~/Library/Developer/Xcode/DerivedData/Maccy-*

# Clean build
xcodebuild clean -project Maccy.xcodeproj -scheme Maccy
```

### Signing Issues
1. Xcode → Settings → Accounts
2. Select your Apple ID
3. Download Manual Profiles
4. Project Settings → Signing & Capabilities
5. Check "Automatically manage signing"

### Upload Fails
- Check internet connection
- Try uploading via Transporter app instead
- Verify bundle ID matches App Store Connect
- Ensure version/build numbers are incremented

---

## Quick Reference Commands

```bash
# Build for testing
xcodebuild -project Maccy.xcodeproj -scheme Maccy -configuration Debug build

# Create archive
xcodebuild archive -project Maccy.xcodeproj -scheme Maccy -archivePath ~/Desktop/Pasteo.xcarchive

# Open in Xcode
open Maccy.xcodeproj

# Check code signing
codesign -dv --verbose=4 /path/to/Pasteo.app
```

---

## Important Notes ⚠️

1. **First submission can take longer** - Apple may manually review more carefully
2. **Keep version numbers updated** - Each submission needs new build number
3. **Test on clean macOS** - Don't rely only on your dev machine
4. **Read rejection carefully** - Apple provides specific feedback
5. **Be patient** - Review process takes time

---

## After Approval 🎉

1. App goes live on Mac App Store
2. Monitor reviews and ratings
3. Respond to user feedback
4. Plan updates and improvements
5. Consider adding more features (iCloud sync!)

---

## Resources

- [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)
- [Human Interface Guidelines - macOS](https://developer.apple.com/design/human-interface-guidelines/macos)
- [App Store Connect Help](https://developer.apple.com/help/app-store-connect/)
- [Common App Rejections](https://developer.apple.com/app-store/review/rejections/)

---

## Checklist Before Submission

- [ ] App icon created and added
- [ ] Screenshots captured (all required sizes)
- [ ] Privacy policy hosted and URL tested
- [ ] App tested on macOS 14.0+
- [ ] All features working correctly
- [ ] No crashes or major bugs
- [ ] Code signed with valid certificate
- [ ] Version set to 1.0.0
- [ ] Bundle ID matches App Store Connect
- [ ] App Store description written
- [ ] Keywords selected
- [ ] Support URL working
- [ ] Archive created successfully
- [ ] Build uploaded to App Store Connect

---

Good luck with your submission! 🚀
