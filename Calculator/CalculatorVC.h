//
//  ViewController.h
//  Calculator
//
//  Created by Corey Allen Pett on 7/1/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SettingsManager;
@class Calculator;

@interface CalculatorVC : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allButtons;
@property (weak, nonatomic) IBOutlet UILabel *clickMeLabel;
@property (weak, nonatomic) IBOutlet UILabel *calculatorOutputLabel;
@property (weak, nonatomic) IBOutlet UIButton *divisionButton;
@property (weak, nonatomic) IBOutlet UIButton *multiplicationButton;
@property (weak, nonatomic) IBOutlet UIButton *subtractionButton;
@property (weak, nonatomic) IBOutlet UIButton *additionButton;
@property (weak, nonatomic) IBOutlet UIButton *equalsButton;
@property (weak, nonatomic) IBOutlet UIButton *percentageButton;
@property (weak, nonatomic) IBOutlet UIButton *clearOutputButton;
@property (weak, nonatomic) IBOutlet UIButton *switchSignButton;
@property (weak, nonatomic) IBOutlet UIButton *decimalButton;
@property (weak, nonatomic) IBOutlet UIButton *zeroButton;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;
@property (weak, nonatomic) IBOutlet UIButton *fourButton;
@property (weak, nonatomic) IBOutlet UIButton *fiveButton;
@property (weak, nonatomic) IBOutlet UIButton *sixButton;
@property (weak, nonatomic) IBOutlet UIButton *sevenButton;
@property (weak, nonatomic) IBOutlet UIButton *eightButton;
@property (weak, nonatomic) IBOutlet UIButton *nineButton;

//Needed to not highlight button
@property (nonatomic) BOOL boolAdditionButton;
@property (nonatomic) BOOL boolSubtractionButton;
@property (nonatomic) BOOL boolDivisionButton;
@property (nonatomic) BOOL boolMultiplicationButton;

@end

