[![Tests](https://github.com/sentryco/PageControllerView/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/PageControllerView/actions/workflows/Tests.yml)

# 📖 PageControllerView

PageControllerView is a Swift library that provides `tab view like` support for macOS applications using SwiftUI. It primarily solves the issue of swiping left and right for macOS onboarding.

## Architecture

- **Data Source**: Define any properties needed for your `NSPageController`. Replace with your data source.
- **Current Page**: This should change page from the caller. Use this to get callbacks when page changes, and also use it to set pages.
- **MakeView**: Callback to make content for each page. Here we make a callback, that takes index and returns View for the `NSHostingController` to use. The idea is to make this more like swiftui `tabview` api.

## Example Usage

Here is an example of how to use the `PageControllerView` in a SwiftUI view:

> [!NOTE]
> Swiping does not work properly in Xcode preview canvas. To see the swipe effect, build and run the app target for macOS.

```swift
#if os(macOS)
@main

struct MacApp: App {
   @State var curPageIndex: Int = 0
   var body: some Scene {
      WindowGroup {
         PageControllerView(dataSource: ["green", "blue", "red"], currentPage: $curPageIndex ) { identifier in
             var rootView: Color
             switch identifier {
             case "green":
                 rootView = .green
             case "red":
                 rootView = .red
             default:
                 rootView = .blue
             }
             return AnyView(rootView)
         }
         .onChange(of: curPageIndex) { _, _ in // debugging to see that we get callbacks from the binding
             Swift.print("curPageIndex: \(curPageIndex)")
         }
      }
      .windowStyle(.hiddenTitleBar) // Hides the top bar
      .windowToolbarStyle(.unifiedCompact(showsTitle: false)) // Hides the top bar text and more compact vertical sizing than .unified
   }
}
#endif
```

## References
- [iPages](https://github.com/benjaminsage/iPages/)
- [BigUIPaging](https://github.com/notsobigcompany/BigUIPaging/)

## Links
- The onboarding API is fairly abstract / modular to support "whats new intro" in the future etc
- Apple docs: https://developer.apple.com/documentation/uikit/uipageviewcontroller/
- Use `UIPageViewController` https://spin.atomicobject.com/2015/12/23/swift-uipageviewcontroller-tutorial/ And: https://milanbrankovic.medium.com/creating-an-embedded-carousel-with-uipageviewcontroller-9549bd2319c7 and code here: https://github.com/srfunksensei/CarouselSample and https://medium.com/@anitaa_1990/create-a-horizontal-paging-uiscrollview-with-uipagecontrol-swift-4-xcode-9-a3dddc845e92 and https://fabcoding.com/2019/03/14/creating-an-onboarding-screen/ and https://github.com/gabrieltheodoropoulos/iOS-Swift-PageControl and  https://itnext.io/ios-uipageviewcontroller-easy-dd559c51ffa Simple UIPageViewCon... https://github.com/ThornTechPublic/Onboarding-With-UIPageViewController-Final
- Similar but uses `UICollectionView` etc: https://vijaysharma.ca/create-an-onboarding-screen-in-swift/ We could probably use Horizontal UIColelctionView, with flow? https://github.com/eonist/flowlayout
- For `SwiftUI`: https://blckbirds.com/post/how-to-create-a-onboarding-screen-in-swiftui-1/
- Sliding cards via constraints and gestures: https://github.com/eonist/Celestial

## Todo: 
- Add dedicated UITests
- remove unit tests
- Code Refactoring: Refactoring for Modern Swift Practices: The PageControllerView+NSViewControllerRepresentable.swift and other related files suggest improvements like using modern Swift syntax and possibly refactoring to reduce dependency on NSPageController specifics, making the code more modular and easier to manage.
- Improving Error Handling: The current implementation does not robustly handle potential errors or exceptional cases, particularly in delegate methods and view controller management.
- Integration and Build Process: GitHub Actions Workflow: The .github/workflows/Tests.yml file indicates that tests are temporarily disabled due to compatibility issues with Swift 5.9. Resolving this and ensuring continuous integration passes could prevent future bugs from being introduced.