//
//  JarWithCoinsView.swift
//  JarTest
//
//  Created by Oleh Titov on 26.08.2022.
//

import SwiftUI

struct JarWithCoinsView: View {
    var progress : Double
    var jarWidth = 300.00
    var coinsWidth = 236.00
    var frameHeight = 320.00
    var coinsBottomPadding = 2
    var jarImage = "Jar-4"
    var body: some View {
        ZStack {
//            JarBlur()
            Ellipse()
                .fill(Color.clear)
                .background(.ultraThinMaterial.opacity(0.9))
                .frame(width: 230, height: 240)
                .clipShape(Ellipse())
                .cornerRadius(40)
                .offset(y: 50)
                .blur(radius: 20)
                    
            
            
            JarShadow(
                width: jarWidth,
                height: 40,
                blurRadius: 30,
                opacity: 0.4
            )
            .offset(y:160)
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    if progress == 0 {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: coinsWidth)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                    } else {
                        //Coins
                        Image(setImageName(for: progress))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: coinsWidth)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .padding(.bottom, 4)
                    }
                }
                
                //Glass Jar
                .overlay {
                    Image(jarImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .frame(width: jarWidth)
                }
            }
            .frame(height: frameHeight)
        }
        .accessibilityLabel(jarAccessibilityText())
    }
    
    func jarAccessibilityText() -> String {
        progress == 0.0 ? "Jar is empty" : "Jar is \(progress)% full"
    }
    
    func setImageName(for progress: Double) -> String {
        switch progress {
        case 0.01..<1.63:
            return "0_8"
        case 1.63..<3.26:
            return "1_63"
        case 3.26..<4.89:
            return "3_26"
        case 4.89..<6.52:
            return "4_89"
        case 6.52..<8.15:
            return "6_52"
        case 8.15..<9.78:
            return "8_15_corrected"
        case 9.78..<11.41:
            return "9_78"
        case 11.41..<13.04:
            return "11_41"
        case 13.04..<14.67:
            return "13_04"
        case 14.67..<16.3:
            return "14_67"
        case 16.3..<17.93:
            return "16_3"
        case 17.93..<19.56:
            return "17_93"
        case 19.56..<21.19:
            return "19_56"
        case 21.19..<22.82:
            return "21_19"
        case 22.82..<24.45:
            return "22_82"
        case 24.45..<26.08:
            return "24_45"
        case 26.08..<27.71:
            return "26_08"
        case 27.71..<29.34:
            return "27_71"
        case 29.34..<30.97:
            return "29_34"
        case 30.97..<32.6:
            return "30_97"
        case 32.6..<34.23:
            return "32_6"
        case 34.23..<35.86:
            return "34_23"
        case 35.86..<37.49:
            return "35_86"
        case 37.49..<39.12:
            return "37_49"
        case 39.12..<40.75:
            return "39_12"
        case 40.75..<42.38:
            return "40_57"
        case 42.38..<44.01:
            return "42_38"
        case 44.01..<45.64:
            return "44_01"
        case 45.64..<47.27:
            return "45_64"
        case 47.27..<48.9:
            return "47_27"
        case 48.9..<50.53:
            return "48_9"
        case 50.53..<52.16:
            return "50_53"
        case 52.16..<53.79:
            return "52_16"
        case 53.79..<55.42:
            return "53_79"
        case 55.42..<57.05:
            return "55_42"
        case 57.05..<58.68:
            return "57_05"
        case 58.68..<60.31:
            return "58_68"
        case 60.31..<61.94:
            return "60_31"
        case 61.94..<63.57:
            return "61.94"
        case 63.57..<65.2:
            return "63_57"
        case 65.2..<66.83:
            return "65_2"
        case 66.83..<68.46:
            return "66_83"
        case 68.46..<70.09:
            return "68_46"
        case 70.09..<71.72:
            return "70_09"
        case 71.72..<73.35:
            return "71_72"
        case 73.35..<74.98:
            return "73_35"
        case 74.98..<76.61:
            return "74_98"
        case 76.61..<78.24:
            return "76_61"
        case 78.24..<79.87:
            return "78_24"
        case 79.87..<81.5:
            return "79_87"
        case 81.5..<83.13:
            return "81_5"
        case 83.13..<84.76:
            return "83_13"
        case 84.76..<86.39:
            return "84_76"
        case 86.39..<88.02:
            return "86_39"
        case 88.02..<89.65:
            return "88_02"
        case 89.65..<91.28:
            return "89_65"
        case 91.28..<92.91:
            return "91_28"
        case 92.91..<94.54:
            return "92_91"
        case 94.54..<96.17:
            return "94_54"
        case 96.17..<97.8:
            return "96_17"
        case 97.8..<100:
            return "97_8"
        case 100:
            return "100"
        default:
            return "100"
        }
    }
}

struct JarWithCoinsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            JarBackgroundView()
            JarWithCoinsView(progress: 9)
        }
    }
}

struct JarBlur: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .fill(LinearGradient(colors: [Color.white.opacity(0.7), Color.white.opacity(0.1)], startPoint: .bottom, endPoint: .top))
            .frame(width: 220, height: 230)
            .cornerRadius(40)
            .blur(radius: 20, opaque: false)
            .opacity(0.8)
            .backgroundStyle(.regularMaterial)
//            .overlay {
//                Rectangle()
//                    .frame(width: 220, height: 80)
//                    .background(.ultraThinMaterial)
//                    .offset(y: 60)
//                    .blur(radius: 20)
//                    .opacity(0.8)
//            }
    }
}
