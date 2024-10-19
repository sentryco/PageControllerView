#if os(macOS)
import SwiftUI
import AppKit
/**
 * `NSViewControllerRepresentable` extension
 */
extension PageControllerView {
   /**
    * This method is part of the NSViewControllerRepresentable protocol in SwiftUI for macOS.
    * - Description: Creates a coordinator that establishes communication
    *                between the SwiftUI view and the underlying NSPageController.
    *                The coordinator is responsible for implementing the delegate
    *                methods of the NSPageController and updating the SwiftUI view
    *                in response to changes in the page controller's state.
    * - Note: It's responsible for creating an instance of Coordinator, which is
    *         a helper class that can manage and coordinate with the NSPageController.
    * - Note: The Coordinator can handle tasks such as responding to user input,
    *         managing the current page index, and managing the view controllers.
    * - Returns: A new instance of Coordinator.
    */
   public func makeCoordinator() -> Coordinator {
      Coordinator(self) // Create a new Coordinator instance
   }
   /**
    * This method is part of the NSViewControllerRepresentable protocol in SwiftUI for macOS.
    * - Note: It's responsible for creating an instance of NSPageController,
    *         which is a native macOS controller that manages navigation between
    *         pages of content.
    * - Note: The created NSPageController can be configured in this method,
    *         for example by setting its delegate.
    * - Description: Initializes and configures an `NSPageController` instance
    *                for use with SwiftUI. The `NSPageController` is set up with
    *                a custom `EffectView` as its background, configured with the
    *                specified material and blending mode. The delegate is set to
    *                the coordinator created by `makeCoordinator()`, and the
    *                `arrangedObjects` property is populated with the `dataSource`
    *                array to manage the content of each page. The `transitionStyle`
    *                is set to `.horizontalStrip` to enable horizontal swiping
    *                between pages, and the `selectedIndex` is initialized to the
    *                current page index provided by the `currentPage` binding.
    * - Parameter: The context in which the NSViewControllerRepresentable is
    *              being used.
    * - Returns A configured instance of NSPageController.
    */
   public func makeNSViewController(context: Context) -> NSPageController {
      let pageController = NSPageController() // PageController(frame: .zero) // ()  // PageController() /
      pageController.view = EffectView( // Onboarding for macOS usually has a translucent background
         material: effectViewConfig.material, // Set the material of the effect view to underWindowBackground
         blendingMode: effectViewConfig.blendingMode, // Set the blending mode of the effect view to behindWindow
         frame: .zero // Set the frame of the effect view to the specified frame
      ) // Design element
      pageController.view.autoresizingMask = [.height, .width] // Resizes on window resize etc
      pageController.delegate = context.coordinator // Informs the class on page id activity
      pageController.arrangedObjects = dataSource // Array(0..<4).map { String($0) } // The number of items in this array must be equal to the number of view controllers you want to display inside the page controller. So if you wanted to display three view controllers in the page controller, you might create an array with three arbitrarily named items like this:
      pageController.transitionStyle = .horizontalStrip // Pages are arranged horizontally
      pageController.selectedIndex = currentPage // Initial page
      return pageController
   }
   /**
    * This method is part of the NSViewControllerRepresentable protocol in SwiftUI for macOS.
    * - Description: It's called whenever the SwiftUI view's state changes and the
    *                changes need to be reflected in the corresponding NSViewController.
    *                In this specific case, the method is currently printing the frame
    *                of the NSPageController's view to the console. However, it's also
    *                where you would update the NSPageController based on changes to the
    *                SwiftUI view's state. For example, if the SwiftUI view had a @State
    *                variable that the NSPageController needed to reflect, you would
    *                update that here.
    * - Fixme: ⚠️️ we might want to keep selection value in sync with page
    *          controller here
    * - Parameters:
    *    - nsViewController: The NSPageController that needs to be updated.
    *    - context: The context in which the NSViewControllerRepresentable is being used.
    */
   public func updateNSViewController(_ nsViewController: NSPageController, context: Context) {
      // Update the NSPageController when the SwiftUI view's state changes
      goToPage( // Calls the goToPage function to navigate to the specified page index within the NSPageController
         pageController: nsViewController, // Passes the NSPageController instance to the goToPage function
         index: currentPage // Passes the current page index to the goToPage function (binding)
      ) 
   }
}
#endif
