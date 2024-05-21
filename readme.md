[![Tests](https://github.com/sentryco/PageControllerView/actions/workflows/Tests.yml/badge.svg)](https://github.com/sentryco/PageControllerView/actions/workflows/Tests.yml)

# 📖 PageControllerView

PageControllerView is a Swift library that provides `tab view like` support for macOS applications using SwiftUI. It primarily solves the issue of swiping left and right for macOS onboarding.

## Architecture

- **Data Source**: Define any properties needed for your NSPageController. Replace with your data source.
- **Current Page**: This should change page from the caller. Use this to get callbacks when page changes, and also use it to set pages.
- **MakeView**: Callback to make content for each page. Here we make a callback, that takes index and returns View for the NSHostingController to use. The idea is to make this more like swiftui `tabview` api.


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

## Todo: 
- Add dedicated UITests
