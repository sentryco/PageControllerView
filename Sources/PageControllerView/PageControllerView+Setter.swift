#if os(macOS)
import SwiftUI
import AppKit

extension PageControllerView {
   /**
    * Updates "page-flipper"
    * - Description: This function navigates to a specified page index within the NSPageController. It uses an animation to smoothly transition from the current page to the new page.
    * - Fixme: ⚠️️ We could make animation optional
    * - Fixme: ⚠️️ Remove param pageController, figure out how to reach it without
    * - Parameters:
    *   - pageController: reference to pageController
    *   - index: current index
    */
   func goToPage(pageController: NSPageController, index: Int) {
      NSAnimationContext.runAnimationGroup({ _ /*context*/ in // To animate a selectedIndex change:
         pageController.animator().selectedIndex = index // Sets the selected index of the NSPageController to the provided index
      }, completionHandler: {
         pageController.completeTransition() // calls internal page control API
      })
   }
}
#endif
