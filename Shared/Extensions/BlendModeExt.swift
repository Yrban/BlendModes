//
//  BlendModeExt.swift
//  BlendingModes
//
//  Created by Developer on 10/2/21.
//

import SwiftUI

extension BlendMode: @retroactive CaseIterable {
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
        case .normal:
            return "Normal family — the source layer simply replaces the destination with no mathematical interaction. There is no blending calculation: the top layer sits on top. This is the baseline from which every other blend mode is a departure. Understanding Normal first makes it easier to reason about what the other modes are actually changing."
        case .multiply:
            return "Darken family — the result is always at most as dark as the darker of the two inputs; applying any darken-family mode can only preserve or reduce brightness. Multiply treats color values as fractions (0–1) and multiplies them together. Since both values are ≤ 1, the product is always ≤ either input. White is the identity element — blending with white changes nothing — while black always produces black. The classic use is a Venn-diagram overlap where shared areas become richer and darker, ideal for shadows and tinted glass."
        case .darken:
            return "Darken family — the result is always at most as dark as the darker input. Darken selects the minimum value per channel between the two layers: whichever pixel component is darker wins. Unlike Multiply it doesn't create new intermediate values — it only picks between existing ones. The overlap shows the darker of the two with no blending in between, making it useful for dropping out light backgrounds."
        case .colorBurn:
            return "Darken family — the result is always at most as dark as the darker input. Color Burn darkens more aggressively than Multiply by inverting the bottom layer, dividing by the top layer, then inverting again. This pushes contrast toward the bottom layer's color. The darker the bottom, the stronger the effect. Blending with white has no effect; near-black tops produce dramatic, high-contrast darkening."
        case .plusDarker:
            return "Darken family — the result is always at most as dark as the darker input. Plus Darker is the most aggressive darken mode: it subtracts each layer's value from 1, sums the results, then subtracts from 1 with a floor of black. The result compresses toward black faster than Multiply or Darken, making it useful for deep shadow overlays."
        case .screen:
            return "Lighten family — the result is always at least as bright as the lighter of the two inputs; applying any lighten-family mode can only preserve or increase brightness. Screen is the mathematical inverse of Multiply: both layers are inverted, multiplied together, then inverted again. Black is the identity element — blending with black changes nothing — while white always produces white. Overlapping areas become brighter, not darker, making it the natural mode for light effects and glows."
        case .lighten:
            return "Lighten family — the result is always at least as bright as the lighter input. Lighten selects the maximum value per channel between the two layers: whichever component is lighter wins. It is the direct complement of Darken and similarly does not create new intermediate values. The overlap shows only the lighter of the two, making it useful for dropping out dark backgrounds."
        case .colorDodge:
            return "Lighten family — the result is always at least as bright as the lighter input. Color Dodge divides the bottom layer by the inverse of the top layer, brightening the bottom to reflect the top layer's color. Brighter tops cause more extreme lightening. Blending with black has no effect; near-white tops can blow out to white entirely. It is the aggressive lightening counterpart to Color Burn."
        case .plusLighter:
            return "Lighten family — the result is always at least as bright as the lighter input. Plus Lighter simply adds the pixel values of both layers together and clamps the result at white. It is the brightest possible blend mode — the direct additive inverse of Plus Darker — making it ideal for glow, light-leak, and additive lighting effects where you want pure accumulation."
        case .overlay:
            return "Contrast family — these modes simultaneously darken dark areas and lighten light areas, increasing overall contrast by combining Multiply and Screen. Overlay lets the destination (bottom) layer control which operation applies: where the destination is dark (< 50% gray), Multiply darkens further; where it is light (> 50% gray), Screen lightens further. This preserves the destination's highlights and shadows while the source layer's colors are overlaid on top."
        case .softLight:
            return "Contrast family — darkens darks and lightens lights to increase contrast. Soft Light is a gentler version of Overlay, producing a diffuse, photographic quality similar to a soft indirect spotlight. Like Overlay it switches between darkening and lightening based on the source brightness, but the transitions are smoother and the effect never reaches pure black or white. Use it when Overlay feels too harsh."
        case .hardLight:
            return "Contrast family — darkens darks and lightens lights to increase contrast. Hard Light is Overlay with the source and destination roles swapped: the source (top) layer controls whether Multiply or Screen applies, rather than the destination. This makes the top layer the 'light source' painting contrast onto the scene. The result is as intense as Overlay but gives you control from the top layer instead of the bottom."
        case .difference:
            return "Inversion family — these modes highlight what is different between two layers by subtracting one from the other. Difference takes the absolute value of the subtraction, so identical pixels become black and maximally different (complementary) pixels become bright. Black is the identity element — blending with black changes nothing. White inverts the layer beneath entirely. The result is often vivid and unintuitive, useful for alignment checks or psychedelic color effects."
        case .exclusion:
            return "Inversion family — highlights differences between layers. Exclusion produces a result very similar to Difference, but the midtone values are softer and more desaturated rather than vibrantly contrasting. Pure black and pure white behave identically to Difference (no change vs. full inversion), but everything in between is gentler. Use Exclusion when Difference feels too harsh or garish."
        case .hue:
            return "Component family — these modes decompose both layers into HSL (Hue, Saturation, Luminosity) components and recombine one component from the source with the remaining two from the destination. Hue takes the hue angle of the source layer and pairs it with the saturation and luminosity of the destination. The result shifts the perceived color of the destination without changing how vivid or bright it is."
        case .saturation:
            return "Component family — mixes one HSL component from the source with the other two from the destination. Saturation takes the saturation (vividness) of the source layer and pairs it with the hue and luminosity of the destination. Use it to pump up or drain color intensity without shifting hues. Applying a gray source layer (zero saturation) fully desaturates the destination while keeping its tonal structure intact."
        case .color:
            return "Component family — mixes one HSL component from the source with the other two from the destination. Color combines the hue and saturation of the source with the luminosity of the destination, effectively colorizing the destination while preserving its grayscale tonal values. This is the classic 'tint a black-and-white image' blend mode. It is the exact inverse of Luminosity."
        case .luminosity:
            return "Component family — mixes one HSL component from the source with the other two from the destination. Luminosity takes the brightness of the source layer and pairs it with the hue and saturation of the destination. The destination keeps its color while its light-and-dark structure is replaced by the source's. This is the exact inverse of Color."
        case .destinationOut:
            return "Compositing family — these modes operate on the alpha (transparency) channel, not just the RGB values, implementing Porter-Duff compositing operations. Destination Out produces a mask: the destination layer is kept only where it is not overlapped by the source. Where the source is opaque, the destination is erased. Use it to punch holes or clip shapes out of layers using another layer as a stencil."
        case .destinationOver:
            return "Compositing family — Porter-Duff alpha compositing operations. Destination Over reverses the visual stacking order: the destination layer appears on top of the source, as if it had been drawn after it. Despite the source being the layer that carries the blend mode, the destination wins visually wherever both are opaque. Use it to place content behind an existing layer without reordering the layer stack."
        case .sourceAtop:
            return "Compositing family — Porter-Duff alpha compositing operations. Source Atop composites the source on top of the destination but clips the source to the destination's alpha shape. Where the destination is transparent, the source is invisible even if it is fully opaque — the destination's outline masks the source. Use it to texture or color a shape defined by the layer below."
        default:
            return ""
        }
    }
}
