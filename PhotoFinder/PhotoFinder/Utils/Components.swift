//
//  Components.swift
//  PhotoFinder
//
//  Created by Martin Balbas, Juan Santiago (Cognizant) on 12/5/17.
//  Copyright © 2017 Martin Balbas, Juan Santiago (Cognizant). All rights reserved.
//

import UIKit

struct Components {
    
    struct Image {
        static var Placeholder = #imageLiteral(resourceName: "placeholder")
    }
    
    struct Font {
        
        private static var RegularFontName: String  { return "ProximaNova-Regular" }
        private static var BoldFontName: String     { return "ProximaNova-Bold" }
        private static var SemiBoldFontName: String { return "ProximaNova-Semibold" }
        private static var LightFontName: String    { return "ProximaNova-Light" }
        
        private static var SmallFontSize: CGFloat   { return 14 }
        private static var MediumFontSize: CGFloat  { return 18 }
        private static var LargeFontSize: CGFloat   { return 24 }
     
        static var BoldSmall: UIFont            { return UIFont(name: BoldFontName, size: SmallFontSize)! }
        static var BoldMedium: UIFont           { return UIFont(name: BoldFontName, size: MediumFontSize)! }
        static var BoldLarge: UIFont            { return UIFont(name: BoldFontName, size: LargeFontSize)! }
        
        static var SemiBoldSmall: UIFont        { return UIFont(name: SemiBoldFontName, size: SmallFontSize)! }
        static var SemiBoldMedium: UIFont       { return UIFont(name: SemiBoldFontName, size: MediumFontSize)! }
        static var SemiBoldLarge: UIFont        { return UIFont(name: SemiBoldFontName, size: LargeFontSize)! }

        static var LightSmall: UIFont           { return UIFont(name: LightFontName, size: SmallFontSize)! }

        static var RegularSmall: UIFont         { return UIFont(name: RegularFontName, size: SmallFontSize)! }
        static var RegularMedium: UIFont        { return UIFont(name: RegularFontName, size: MediumFontSize)! }
        
    }
    
}
