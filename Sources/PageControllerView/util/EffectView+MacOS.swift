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
    * - Description: Creates an instance of `EffectView` with customizable visual effect material, blending mode, and initial frame size. This initializer allows for easy setup of the view's appearance right upon creation.
    * - Parameters:
    *   - material: The translucent material to use as a background.
    *   - blendingMode: The blending mode to use.
    *   - frame: The frame rectangle for the view.
    */
   public init(material: NSVisualEffectView.Material = .headerView, blendingMode: NSVisualEffectView.BlendingMode = .withinWindow, frame frameRect: NSRect) {
      super.init(frame: frameRect) // Calls the superclass initializer with the specified frame rectangle for the view.
      self.config( // Configures the visual effect view with the specified material and blending mode.
         material: material, // Sets the visual effect material for the EffectView
         blendingMode: blendingMode // Sets the blending mode for the EffectView
      )
   }
   /**
    * Required initializer that is not implemented.
    * - Description: This initializer is unavailable because `EffectView` cannot be instantiated from a coder. Attempting to do so will result in a runtime error.
    * - Parameter coder: The coder to use for decoding the view.
    */
   @available(*, unavailable)
   public required init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
}
/**
 * Configures the appearance of the `EffectView`
 */
extension EffectView {
   /**
    * Configures the material and blending mode of the `EffectView`
    * - Description: Configures the `EffectView` with a specified material and blending mode to customize its appearance. The material determines the kind of translucent background used, while the blending mode defines how the view's content blends with the background.
    * - Fixme: ⚠️️ Add support for isEmphasized
    * - Parameters:
    *   - material: The translucent material to use as a background
    *   - blendingMode: The blending mode to use
    */
   public func config(material: NSVisualEffectView.Material = .headerView, blendingMode: NSVisualEffectView.BlendingMode = .withinWindow) {
      self.material = material
      self.blendingMode = blendingMode
   }
}
/**
 * Const
 */
extension EffectView {
   /**
    * Defines the configuration for the `EffectView`
    * - Description: Defines the configuration for the `EffectView`, including the material and blending mode.
    */
   public typealias Config = (
      material: NSVisualEffectView.Material, // The visual effect material used for the background of the EffectView.
      blendingMode: NSVisualEffectView.BlendingMode // The blending mode that determines how the EffectView's content blends with its background.
   )
   /**
    * The default configuration for the `EffectView`
    */
   public static let defaultConfig: Config = (
      material: .underWindowBackground, // Sets the visual effect material to appear behind the window.
      blendingMode: .withinWindow // Sets the blending mode to blend within the window.
   )
}
#endif
