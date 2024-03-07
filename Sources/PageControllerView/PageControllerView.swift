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
    */
   public let dataSource: [NSPageController.ObjectIdentifier] // Replace with your data source
   /**
    * This should change page from the caller
    * Use this to get callbacks when page changes, and also use it to set pages
    */
   @Binding public var currentPage: Int
   /**
    * - Fixme: ⚠️️ we could try use some View somehow
    */
   public typealias MakeView = (_ id: NSPageController.ObjectIdentifier) -> AnyView
   /**
    * Callback to make content for each page
    * - Description: here we make a callback, that takes index and returns View for the NSHostingController to use
    * - Remark: The idea is to make this more like swiftui `tabview` api
    */
   public var makeView: MakeView = { id in Swift.print("default makeView - id: \(id)"); return AnyView(EmptyView()) }
}
#endif
