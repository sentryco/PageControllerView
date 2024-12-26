#if os(macOS)
import SwiftUI
import AppKit
/**
 * Delegate
 * - Description: Informs the class on page id activity
 * - Remark: There are also other delegate callbacks: 
 *           `pageControllerWillStartLiveTransition`, `didTransitionTo`, 
 *           `frameFor`, `prepare viewController`
 */
extension PageControllerView {
   /**
    * Define a Coordinator class to handle delegate callbacks
    * - Description: The `Coordinator` class acts as a delegate for the
    *                `NSPageController`, handling page lifecycle events and
    *                coordinating the data source with the page content.
    */
   public class Coordinator: NSObject, NSPageControllerDelegate {
      /**
       * Reference to the parent `PageControllerView` instance
       * - Description: Holds a reference to the `PageControllerView` that created
       *                this coordinator. This allows the coordinator to access the
       *                parent view's properties and methods, such as `dataSource`
       *                and `makeView`, to manage page content and respond to page
       *                lifecycle events.
       */
      var parent: PageControllerView
      /**
       * Set parent
       * - Description: The initializer sets the `parent` property to the
       *                provided `PageControllerView` instance. This association
       *                is crucial as it allows the `Coordinator` to access the
       *                `PageControllerView`'s properties and methods, which are
       *                necessary for the `Coordinator` to fulfill its role as a
       *                delegate, such as updating the `currentPage` and creating
       *                views for new pages.
       */
      public init(_ pageControllerView: PageControllerView) {
         self.parent = pageControllerView
      }
   }
}
/**
 * Delegates
 */
extension PageControllerView.Coordinator {
   /**
    * Delegate callback (Boilerplate)
    * - Description: Returns a unique identifier for the given object that can
    *                be used by the `NSPageController` to manage page content.
    *                The identifier is typically a string that uniquely
    *                represents the object in the data source array.
    * - Returns: an identifier for the given object that we can use to get the data model item
    * - Remark: This could be based on the object's position in an array or its properties
    */
   public func pageController(_ pageController: NSPageController, identifierFor object: Any) -> NSPageController.ObjectIdentifier { // String
      // Swift.print("Coordinator.identifierFor: \(object)")
      String(describing: object) // Return identifier
   }
   /**
    * Instatiate `ViewController` for identifier  (Returns the swift ui view)
    * - Description: Instantiates a `NSViewController` for the given identifier
    *                by creating a SwiftUI view hierarchy that is hosted within an
    *                `NSHostingController`. This method is responsible for creating
    *                the view controller that will be displayed when a page is
    *                selected in the `NSPageController`.
    * - Returns: the view controller for the given identifier
    * - Important: ⚠️️ To align page views to a constraintless environment we add
    *              the pageview to a ZStack that has .ignoresSafeArea() with a clear
    *              Rectangle that has idealWidth and idealHeight set to .inifinite.
    *              This solves a bug where 14px are added to top inset etc
    * - Remark: This could involve looking up the identifier in a dictionary or storyboard
    * - Remark: Displays the `ViewController` in the page-controller
    * - Remark: We can also use `NSViewcontroller` and a `NSHostingView
    * - Fixme: ⚠️️ ref pageController instead of parent?
    * - Parameters:
    *   - pageController: current page controller
    *   - identifier: page id
    * - Returns: current page
    */
   @MainActor // ⚠️️ Needed for Swift 6.0
   public func pageController(_ pageController: NSPageController, viewControllerForIdentifier identifier: NSPageController.ObjectIdentifier) -> NSViewController {
      // Swift.print("viewControllerForIdentifier \(identifier)")
      let rootView: some View = AnyView( // Wraps the provided view in a type-erasing AnyView to allow for heterogeneous view types
         ZStack { // Creates a ZStack to layer views on top of each other
            Rectangle() // ⚠️️ this is key to expanding the view to fill the NSView
               .frame(idealWidth: .infinity, idealHeight: .infinity) // Sets an ideal width and height for the frame to infinity, which instructs SwiftUI to make the frame as large as possible within its parent view.
               .foregroundColor(.clear) // Sets the rectangle's foreground color to clear, making it invisible but still occupying space for layout purposes.
            parent.makeView(identifier) // Calls the parent's makeView function to create the view for the current page using the provided identifier.
         }
            .ignoresSafeArea() // ⚠️️ this is key to expanding the view to fill the NSView
      ) // ⚠️️ We can probably find a better way than using AnyView
      let hostingController = NSHostingController(rootView: rootView) // Initializes an NSHostingController with the specified rootView. The NSHostingController is a view controller that provides a bridge between SwiftUI views and AppKit, allowing SwiftUI views to be integrated into an AppKit view hierarchy.
      hostingController.view.autoresizingMask = [.height, .width] // this is the key to make the swiftuiu view work on init and when window is resized 
      return hostingController // Returns the NSHostingController that contains the SwiftUI view for the current page.
   }
   /**
    * Delegate callback
    * - Description: Ends the transition when the user swipes left or right
    * - Fixme: ⚠️️ We can add callback here to update `PageIndicator` (or use WillStartLiveTransition, if we want more instant UX etc)
    * - Parameter pageController: The pagecontroller that the live transition ended in
    */
   @MainActor // ⚠️️ Needed for Swift 6.0
   public func pageControllerDidEndLiveTransition(_ pageController: NSPageController) {
      pageController.completeTransition() // Hide the transition view used for animation and show the selectedViewController.view. Generally, this is called during pageControllerDidEndLiveTransition: in the delegate when the new contents of view is ready to be displayed.
      parent.$currentPage.wrappedValue = pageController.selectedIndex // update binding
   }
}
#endif
