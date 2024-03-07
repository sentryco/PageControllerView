#if os(macOS)
import SwiftUI
import AppKit
/**
 * NSViewControllerRepresentable extension
 */
extension PageControllerView {
   /**
    * This method is part of the NSViewControllerRepresentable protocol in SwiftUI for macOS.
    * It's responsible for creating an instance of Coordinator, which is a helper class that can manage and coordinate with the NSPageController.
    * The Coordinator can handle tasks such as responding to user input, managing the current page index, and managing the view controllers.
    * - Returns A new instance of Coordinator.
    */
   public func makeCoordinator() -> Coordinator {
      Coordinator(self) // Create a new Coordinator instance
   }
   /**
    * This method is part of the NSViewControllerRepresentable protocol in SwiftUI for macOS.
    * It's responsible for creating an instance of NSPageController, which is a native macOS controller that manages navigation between pages of content.
    * The created NSPageController can be configured in this method, for example by setting its delegate.
    * - Parameter: The context in which the NSViewControllerRepresentable is being used.
    * - Returns A configured instance of NSPageController.
    */
   public func makeNSViewController(context: Context) -> NSPageController {
      let pageController = NSPageController() // PageController(frame: .zero) // ()  // PageController() /
      pageController.view = EffectView( // Onboarding for macOS usually has a translucent background
         material: .underWindowBackground, // Set the material of the effect view to underWindowBackground
         blendingMode: .behindWindow, // Set the blending mode of the effect view to behindWindow
         frame: .zero // Set the frame of the effect view to the specified frame
      ) // Design element
      pageController.view.autoresizingMask = [.height, .width] // Resizes on window resize etc
      pageController.delegate =  context.coordinator // Informs the class on page id activity
      pageController.arrangedObjects = dataSource // Array(0..<4).map { String($0) } // The number of items in this array must be equal to the number of view controllers you want to display inside the page controller. So if you wanted to display three view controllers in the page controller, you might create an array with three arbitrarily named items like this:
      pageController.transitionStyle = .horizontalStrip // Pages are arranged horizontally
      pageController.selectedIndex = currentPage // Initial page
      return pageController
   }
   /**
    * This method is part of the NSViewControllerRepresentable protocol in SwiftUI for macOS.
    * It's called whenever the SwiftUI view's state changes and the changes need to be reflected in the corresponding NSViewController.
    * In this specific case, the method is currently printing the frame of the NSPageController's view to the console.
    * However, it's also where you would update the NSPageController based on changes to the SwiftUI view's state.
    * For example, if the SwiftUI view had a @State variable that the NSPageController needed to reflect, you would update that here.
    *  - Fixme: ⚠️️ we might want to keep selection value in sync with page controller here
    *
    * - Parameter: nsViewController The NSPageController that needs to be updated.
    * - Parameter: context The context in which the NSViewControllerRepresentable is being used.
    */
   public func updateNSViewController(_ nsViewController: NSPageController, context: Context) {
      // Update the NSPageController when the SwiftUI view's state changes
      goToPage(pageController: nsViewController, index: currentPage) // we add the binding here, not sure if the unwrapp is needed
   }
}
#endif
//      let pageController = NSPageController(transitionStyle: .scroll, navigationOrientation: .horizontal)
//      pageController.dataSource = context.coordinator // Set the data source
//      return pageController
//      pageController.view.wantsLayer = true // might be needed?
