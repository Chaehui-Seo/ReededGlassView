# ReededGlassView
![reededGlassFrontImage](https://github.com/Chaehui-Seo/ReededGlassView/assets/73422344/cde7c70f-77b1-4a82-8e27-c36a228735cb)

# Requirements
- iOS 13.0+


# Usage
### 1. Add ReededGlassView
Place `ReededGlassView`, that you want to apply effect, in the same hierarchy of the target image view (more specifically, above image view)
```
// Hierarchy example

Background View
  └── Target Image View (Image behind)
  └── Reeded Glass View (view to apply effect)
```

### 2. Apply effect
Set reeded glass effect with a public method like below
```swift
reededGlassView.applyReededGlassEffect(with: targetImageView)
reededGlassView.applyReededGlassEffect(with: targetImageView, widthType: .default) // Adding width type is available
```

# Customizing options
You can choose width type (among narrow, default, wide)
| narrow | default | wide |
| :-: | :-: | :-: |
| ![image](https://github.com/user-attachments/assets/80976da9-ac5e-4a9e-8a59-7418773c2793) | ![image](https://github.com/user-attachments/assets/5e6ae805-26b2-411d-867a-78476e71863b) | ![image](https://github.com/user-attachments/assets/38107342-4909-442a-ae27-d6423a9e331f) |
```swift
reededGlassView.setWidthType(to: .default) // .narrow, .wide
```


# SampleApp
You can run the SampleApp Project located in `SampleApp` folder.
All the functions provided by the package are testable through the SampleApp project.</br>
(It takes some time to apply effects. A Spinner is added to express loading in the SampleApp.)</br>
![Simulator Screen Recording - iPhone 15 Pro - 2024-10-06 at 21 42 34](https://github.com/user-attachments/assets/2c62e62c-cba0-422d-9e53-d227a81bc2bc)





# Caution
- The target image view and the reeded glass view must be in the **SAME HIERARCHY**.
- The target image view **MUST BE SAME OR BIGGER** than the reeded glass view above.
