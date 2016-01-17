//
//  NumericalVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/20/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingsManager;

@interface NumericalVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *instructionLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstDigit;
@property (weak, nonatomic) IBOutlet UILabel *secondDigit;
@property (weak, nonatomic) IBOutlet UILabel *thirdDigit;
@property (weak, nonatomic) IBOutlet UILabel *fourthDigit;
@property (weak, nonatomic) IBOutlet UITextView *digitInputTextView;

@end
