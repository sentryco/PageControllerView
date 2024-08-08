#if os(macOS)
import SwiftUI
import AppKit
/**
 * SwiftUI does not support tabview for macos. This class provides similar support. Primarly it solves swiping left and right for macOS onboarding
 * - Remark: NSViewControllerRepresentable is a protocol in SwiftUI for macOS.
 * - Description: It's used to create and manage an NSViewController instance in SwiftUI.
 * - Remark: By conforming to this protocol, you can integrate NSViewController functionality into your SwiftUI views.
 * - Remark: It requires implementing two methods: makeNSViewController(context:) and updateNSViewController(_:context:).
 * - Note: ref: https://github.com/benjaminsage/iPages/
 * - Note: ref: https://github.com/notsobigcompany/BigUIPaging/
 */
public struct PageControllerView: NSViewControllerRepresentable { // PageControllerRepresentable
   /**
    * Define any properties needed for your NSPageController
    * - Description: The `dataSource` property holds an array of `NSPageController.ObjectIdentifier` which uniquely identifies each page in the `PageControllerView`. It is used by the page controller to manage the creation and arrangement of the page content.
    */
   public let dataSource: [NSPageController.ObjectIdentifier] // Replace with your data source
   /**
    * This should change page from the caller
    * - Description: Use this to get callbacks when page changes, and also use it to set pages
    */
   @Binding public var currentPage: Int
   /**
    * - Fixme: ⚠️️ we could try use some View somehow
    * - Fixme: ⚠️️ move into extension?
    * - Description: The `MakeView` typealias defines a closure type that takes an `NSPageController.ObjectIdentifier` and returns a SwiftUI view wrapped in `AnyView`. This closure is used to dynamically create the content for each page in the `PageControllerView`.
    */
   public typealias MakeView = (_ id: NSPageController.ObjectIdentifier) -> AnyView
   /**
    * Callback to make content for each page
    * - Description: here we make a callback, that takes index and returns View for the NSHostingController to use
    * - Remark: The idea is to make this more like swiftui `tabview` api
    */
   public var makeView: MakeView = { id in Swift.print("default makeView - id: \(id)"); return AnyView(EmptyView()) }
   /**
    * - Description: The `EffectView.Config` typealias defines a tuple type that represents the configuration for the `EffectView`. This configuration includes the material and blending mode for the visual effect view.
    */
   public let effectViewConfig: EffectView.Config
   /**
    * Initializes a new PageControllerView
    * - Description: Initializes a new PageControllerView with the specified data source, current page binding, effect view configuration, and a closure to create views for each page. This allows for the integration of a page controller within SwiftUI on macOS, providing functionality similar to a TabView with swipe navigation.
    * - Parameters:
    *   - dataSource: An array of identifiers for the pages. Each identifier is used to create the corresponding page.
    *   - currentPage: A binding to a property that tracks the currently selected page. The PageControllerView updates the property as the user interacts with the interface.
    *   - makeView: A closure that takes an identifier and returns the view for the corresponding page. By default, it returns an empty view.
    */
   public init(dataSource: [NSPageController.ObjectIdentifier], currentPage: Binding<Int>, effectViewConfig: EffectView.Config = EffectView.defaultConfig, makeView: @escaping MakeView = { _ in AnyView(EmptyView()) }) {
      self.dataSource = dataSource // Assigns the provided dataSource array to the instance property.
      self._currentPage = currentPage // Binds the provided currentPage Binding to the instance property.
      self.effectViewConfig = effectViewConfig // Sets the effect view configuration with the provided config.
      self.makeView = makeView // Stores the provided closure for creating views for each page.
   }
}
#endif
