//
//  BlendModeExt.swift
//  BlendingModes
//
//  Created by Developer on 10/2/21.
//

import SwiftUI

extension BlendMode: CaseIterable {
    public static var allCases: [BlendMode]{
        [.color, .colorBurn, .colorDodge, .darken, .destinationOut, .destinationOver, .difference, .exclusion, .hardLight, .hue, .lighten, .luminosity, .multiply, .normal, .overlay, .plusDarker, .plusLighter, .saturation, .screen, .softLight, .sourceAtop]
    }
    
    var description: String {
        switch self {
        case .color:
            return ".color"
        case .colorBurn:
            return ".colorBurn"
        case .colorDodge:
            return ".colorDodge"
        case .darken:
            return ".darken"
        case .destinationOut:
            return ".destinationOut"
        case .destinationOver:
            return ".destinationOver"
        case .difference:
            return ".difference"
        case .exclusion:
            return ".exclusion"
        case .hardLight:
            return ".hardLight"
        case .hue:
            return ".hue"
        case .lighten:
            return ".lighten"
        case .luminosity:
            return ".luminosity"
        case .multiply:
            return ".multiply"
        case .normal:
            return ".normal"
        case .overlay:
            return ".overlay"
        case .plusDarker:
            return ".plusDarker"
        case .plusLighter:
            return ".plusLighter"
        case .saturation:
            return ".saturation"
        case .screen:
            return ".screen"
        case .softLight:
            return ".softLight"
        case .sourceAtop:
            return ".sourceAtop"
        default:
            return ""
        }
    }

    var anchor: Int {
        switch self {
        case .color:
            return 1
        case .colorBurn:
            return 2
        case .colorDodge:
            return 3
        case .darken:
            return 4
        case .destinationOut:
            return 5
        case .destinationOver:
            return 6
        case .difference:
            return 7
        case .exclusion:
            return 8
        case .hardLight:
            return 9
        case .hue:
            return 10
        case .lighten:
            return 11
        case .luminosity:
            return 12
        case .multiply:
            return 13
        case .normal:
            return 14
        case .overlay:
            return 15
        case .plusDarker:
            return 16
        case .plusLighter:
            return 17
        case .saturation:
            return 18
        case .screen:
            return 19
        case .softLight:
            return 20
        case .sourceAtop:
            return 21
        default:
            return 1
        }
    }

    var longDescription: String {
        switch self {
        case .color:
            return "The Color blend mode is a combination of Hue and Saturation. It uses the luminance values of the background with the hue and saturation values of the source image. This mode preserves the gray levels in the image. You can use this mode to color monochrome images or to tint color images."
        case .colorBurn:
            return "The Color Burn blend mode divides the inverted bottom layer by the top layer, and then inverts the result. This darkens the top layer increasing the contrast to reflect the color of the bottom layer. The darker the bottom layer, the more its color is used. Blending with white produces no difference. When top layer contains a homogeneous color, this effect is equivalent to changing the black point to the inverted color. This is considered a darkening blend mode."
        case .colorDodge:
            return "The Color Dodge blend mode divides the bottom layer by the inverse of top layer. This lightens the bottom layer depending on the value of the top layer: the brighter the top layer, the more its color affects the bottom layer. This brightens the background image samples to reflect the source image samples. Source image sample values that specify black do not produce a change.Blending any color with white gives white. Blending with black does not change the image. This is considered a lightening blend mode."
        case .darken:
            return "The Darken blend mode creates a pixel that contains the darkest color between the layered pixels. This creates the composite image samples by choosing the darker samples (either from the source image or the background). The result is that the background image samples are replaced by any source image samples that are darker. Otherwise, the background image samples are left unchanged."
        case .destinationOut:
            return "The Destination Out blend mode is a masking blend mode that keeps the layer where it isn't overlapped."
        case .destinationOver:
            return "The Destination Over blend mode keeps the layer that is drawn behind the existing canvas content."
        case .difference:
            return "The Difference blend mode subtracts either the source image sample color from the background image sample color, or the reverse, depending on which sample has the greater brightness value. Source image sample values that are black produce no change; white inverts the background color values."
        case .exclusion:
            return "The Exclusion blend mode produces an effect similar to that produced by Difference, but with lower contrast. Source image sample values that are black don’t produce a change; white inverts the background color values."
        case .hardLight:
            return "The Hard Light blend mode is a combination of Multiply and Screen. Hard Light either multiplies or screens colors, depending on the source image sample color. If the source image sample color is lighter than 50% gray, the background is lightened, similar to screening. If the source image sample color is darker than 50% gray, the background is darkened, similar to multiplying. If the source image sample color is equal to 50% gray, the source image is not changed. Image samples that are equal to pure black or pure white result in pure black or white. The overall effect is similar to what you’d achieve by shining a harsh spotlight on the source image. Use this to add highlights to a scene. This blend mode increases contrast."
        case .hue:
            return "The Hue blend mode uses the luminance and saturation values of the background with the hue of the source image."
        case .lighten:
            return "The Lighten blend mode has the opposite action of Darken. It selects the maximum of each component from the layered pixels. This creates the composite image samples by choosing the lighter samples (either from the source image or the background). The result is that the background image samples are replaced by any source image samples that are lighter. Otherwise, the background image samples are left unchanged."
        case .luminosity:
            return "The Luminosity blend mode uses the hue and saturation of the background with the luminance of the source image. This mode creates an effect that is inverse to the effect created by the Color blend mode."
        case .multiply:
            return "The Multiply blend mode multiplies the source with the background. This results in colors that are at least as dark as the contributing sample colors. Essentially, this multiplies colors as the numbers between 0 and 1 for each pixel from the top layer with the values for the corresponding pixel from the bottom layer. This will always result in a darker picture since any pixel less than 1 multiplied by another pixel will be a smaller, or darker, number. Therefore, blending with white returns a color between, and blending with black, always returns black. This blend mode is the opposite of Screen. This is considered a darkening blend mode."
        case .normal:
            return "The Normal blend mode is the default mode. This uses the topmost pixel color and does not blend it with anything below."
        case .overlay:
            return "The Overlay blend mode combines Multiply and Screen blend modes. The parts of the top layer where the base layer is light become lighter, the parts where the base layer is dark become darker. It either multiplies or screens the source image samples with the background image samples, depending on the background color. The result is to overlay the existing image samples while preserving the highlights and shadows of the background. The background color mixes with the source image to reflect the lightness or darkness of the background. This blend mode increases contrast."
        case .plusDarker:
            return "The Plus Darker blend mode subtracts the value of each layer from 1, sums these results and the subtracts the sum from 1 with a floor of 0. This is considered a darkening blend mode."
        case .plusLighter:
            return "The Plus Lighter blend mode sums pixel values of each layer, with a ceiling of 1. This is considered a lightening blend mode."
        case .saturation:
            return "The Saturation blend mode uses the luminance and hue values of the background with the saturation of the source image. Areas of the background that have no saturation (that is, pure gray areas) don’t produce a change."
        case .screen:
            return "The Screen blend mode the values of the pixels in the two layers are inverted, multiplied, and then inverted again. This yields the opposite effect to multiply, and results in a brighter picture. This blend mode is the opposite of Multiply. This is considered a lightening blend mode."
        case .softLight:
            return "The Soft Light blend mode darkens or lightens colors, depending on the source image sample color. If the source image sample color is lighter than 50% gray, the background is lightened, similar to dodging. If the source image sample color is darker than 50% gray, the background is darkened, similar to burning. If the source image sample color is equal to 50% gray, the background is not changed. Image samples that are equal to pure black or pure white produce darker or lighter areas, but do not result in pure black or white. The overall effect is similar to what you’d achieve by shining a diffuse spotlight on the source image. Use this to add highlights to a scene. This blend mode increases contrast."
        case .sourceAtop:
            return "The Source Atop and blend mode combines the alpha channels of the source and destination images, before blending the source on top of the destination."
        default:
            return ""
        }
    }
}
