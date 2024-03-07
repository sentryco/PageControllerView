#if os(macOS)
import SwiftUI
import AppKit
/**
 * - Important: ⚠️️ Preview doesn't work properly with swiping, so run the app to see the swipe work properly
 */
#Preview(traits: .fixedLayout(width: 300, height: 300)) {
   struct ContentView: View {
      @State var curPageIndex: Int = 0
      var body: some View {
         PageControllerView(dataSource: ["green", "blue", "red"], currentPage: $curPageIndex ) { identifier in // ["View 1", "View 2", "View 3"]
            var rootView: Color
            switch identifier {
            case "green":
               rootView = .green
            case "red":
               rootView = .red
            default:
               rootView = .blue
            }
            return rootView
         }
            .onChange(of: curPageIndex) { _, _ in // debugging to see that we get callbacks from the binding
               Swift.print("curPageIndex: \(curPageIndex)")
            }
      }
   }
   return ContentView()
}
#endif
