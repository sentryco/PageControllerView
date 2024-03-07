#if os(macOS)
import Cocoa
import AppKit
/**
 * A visual effect view that provides a translucent material to use as a background.
 * - Description: This class is a subclass of `NSVisualEffectView` and provides a configurable material and blending mode. It also overrides the `isFlipped` property to return `true`, indicating a top-left orientation.
 * - Remark: This view does not work with Auto Layout. Make sure the frame is set in layout in the superview.
 * - Remark: For more information on visual effects, see: https://mackuba.eu/2018/07/04/dark-side-mac-1/
 * - Fixme: Add more documentation to the class and its methods.
 */
open class EffectView: NSVisualEffectView {
   /**
    * Initializes a new instance of the `EffectView` with the given material, blending mode, and frame.
    * - Parameters:
    *   - material: The translucent material to use as a background.
    *   - blendingMode: The blending mode to use.
    *   - frame: The frame rectangle for the view.
    */
   public init(material: NSVisualEffectView.Material = .headerView, blendingMode: NSVisualEffectView.BlendingMode = .withinWindow, frame frameRect: NSRect) {
      super.init(frame: frameRect)
      self.config(material: material, blendingMode: blendingMode)
   }
   /**
    * Required initializer that is not implemented.
    * - Parameter coder: The coder to use for decoding the view.
    */
   @available(*, unavailable)
   public required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
/**
 * Configures the appearance of the `EffectView`.
 */
extension EffectView {
   /**
    * Configures the material and blending mode of the `EffectView`.
    * - Parameters:
    *   - material: The translucent material to use as a background.
    *   - blendingMode: The blending mode to use.
    */
   public func config(material: NSVisualEffectView.Material = .headerView, blendingMode: NSVisualEffectView.BlendingMode = .withinWindow) {
      self.material = material
      self.blendingMode = blendingMode
   }
}

#endif
