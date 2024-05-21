#if os(macOS)
import SwiftUI
import AppKit

extension PageControllerView {
   /**
    * Updates "page-flipper"
    * - Fixme: ⚠️️ We could make animation optional
    * - Fixme: ⚠️️ Remove param pageController, figure out how to reach it without
    * - Parameters:
    *   - pageController: reference to pageController
    *   - index: current index
    */
   func goToPage(pageController: NSPageController, index: Int) {
      NSAnimationContext.runAnimationGroup({ _ /*context*/ in // To animate a selectedIndex change:
         pageController.animator().selectedIndex = index // 2
      }, completionHandler: {
         pageController.completeTransition() // calls internal page control API
      })
   }
}
#endif
