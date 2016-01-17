//
//  SecurityVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/19/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CalculatorVC;
@class NumericalVC;
@class AlphabeticalVC;
@class PatternVC;

@interface SecurityVC : UIViewController

@property (weak, nonatomic) IBOutlet UISwitch *breakInSwitch;
@property (weak, nonatomic) IBOutlet UIImageView *alphabeticalCheck;
@property (weak, nonatomic) IBOutlet UIImageView *numericalCheck;
@property (weak, nonatomic) IBOutlet UIImageView *patternCheck;
@property (weak, nonatomic) IBOutlet UIImageView *calculatorCheck;
@property (weak, nonatomic) IBOutlet UIImageView *noneCheck;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;

@end
