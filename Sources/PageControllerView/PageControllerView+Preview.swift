#if os(macOS)
import SwiftUI
import AppKit
/**
 * Preview
 * - Important: ⚠️️ Preview doesn't work properly with swiping, so run the app to see the swipe work properly
 * - Note: Because of github action we can't currently use more modern: #Preview(traits: .fixedLayout(width: 300, height: 300)) {
 * - Fixme: ⚠️️ Add darkmode to the preview
 * - Fixme: ⚠️️ Use modern preview syntax once github allows it
 */
struct PageControl_Previews: PreviewProvider {
   struct ContentView: View {
      @State var curPageIndex: Int = 0
      var body: some View {
         let dataSource = ["green", "blue", "red"]
         return PageControllerView(dataSource: dataSource, currentPage: $curPageIndex ) { identifier in // ["View 1", "View 2", "View 3"]
            var rootView: Color
            switch identifier {
            case "green":
               rootView = .green
            case "red":
               rootView = .red
            default:
               rootView = .blue
            }
            return AnyView(rootView)
         }
            .onChange(of: curPageIndex) { _, _ in // debugging to see that we get callbacks from the binding
               Swift.print("curPageIndex: \(curPageIndex)")
            }
      }
   }
   static var previews: some View {
      return ContentView()
         .frame(width: 300, height: 300)
   }
}
#endif
