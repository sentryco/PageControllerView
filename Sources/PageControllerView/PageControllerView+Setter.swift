#if os(macOS)
import SwiftUI
import AppKit

extension PageControllerView {
   /**
    * Updates "page-flipper"
    * - Parameter pageController: reference to pageController
    * - Parameter index: current index
    * - Fixme: ⚠️️ we could make animation optional
    * - Fixme: ⚠️️ remove param pageController, figure out how to reach it without
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
