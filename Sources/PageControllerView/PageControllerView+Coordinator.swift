#if os(macOS)
import SwiftUI
import AppKit
/**
 * Delegate
 * - Description: Informs the class on page id activity
 * - Remark: There are also other delegate callbacks: `pageControllerWillStartLiveTransition`, `didTransitionTo`, `frameFor`, `prepare viewController`
 */
extension PageControllerView {
   /**
    * Define a Coordinator class to handle delegate callbacks
    */
   public class Coordinator: NSObject, NSPageControllerDelegate {
      /**
       * Parent
       * - Fixme: ⚠️️ add description
       */
      var parent: PageControllerView
      /**
       * Set parent
       * - Fixme: ⚠️️ add reasoning
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
    * - Returns: an identifier for the given object that we can use to get the data model item
    * - Remark: This could be based on the object's position in an array or its properties
    */
   public func pageController(_ pageController: NSPageController, identifierFor object: Any) -> NSPageController.ObjectIdentifier { // String
      // Swift.print("Coordinator.identifierFor: \(object)")
      return String(describing: object) // Return identifier
   }
   /**
    * Instatiate `ViewController` for identifier  (Returns the swift ui view)
    * - Returns: the view controller for the given identifier
    * - Remark: This could involve looking up the identifier in a dictionary or storyboard
    * - Remark: Displays the `ViewController` in the page-controller
    * - Remark: We can also use `NSViewcontroller` and a `NSHostingView
    * - Fixme: ⚠️️ doc each line, use copilot
    * - Fixme: ⚠️️ ref pageController instead of parent?
    * - Parameters:
    *   - pageController: current page controller
    *   - identifier: page id
    * - Returns: current page
    */
   public func pageController(_ pageController: NSPageController, viewControllerForIdentifier identifier: NSPageController.ObjectIdentifier) -> NSViewController {
      // Swift.print("viewControllerForIdentifier \(identifier)")
      let rootView: some View = AnyView(parent.makeView(identifier)) // ⚠️️ We can probably find a better way than using AnyView
      let hostingController = NSHostingController(rootView: rootView)
      hostingController.view.autoresizingMask = [.height, .width] // this is the key to make the swiftuiu view work on init and when window is resized
      return hostingController
   }
   /**
    * Delegate callback
    * - Description: Ends the transition when the user swipes left or right
    * - Fixme: ⚠️️ We can add callback here to update `PageIndicator` (or use WillStartLiveTransition, if we want more instant UX etc)
    * - Parameter pageController: The pagecontroller that the live transition ended in
    */
   public func pageControllerDidEndLiveTransition(_ pageController: NSPageController) {
      pageController.completeTransition() // Hide the transition view used for animation and show the selectedViewController.view. Generally, this is called during pageControllerDidEndLiveTransition: in the delegate when the new contents of view is ready to be displayed.
      parent.$currentPage.wrappedValue = pageController.selectedIndex // update binding
   }
}
#endif
