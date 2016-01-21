//
//  ViewController.m
//  Calculator
//
//  Created by Corey Allen Pett on 7/1/15.
//  Copyright (c) 2015 Corey Allen Pett. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "CalculatorVC.h"
#import "Calculator.h"
#import "SettingsManager.h"

@interface CalculatorVC ()

@property (strong, nonatomic) Calculator *calculator;

@end

@implementation CalculatorVC

//Used to let the user create password
static int createPasswordCount = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Darken all the buttons when pressed
    for (UIButton *button in self.allButtons){
        [button setBackgroundImage:[self imageWithColor:[UIColor colorWithWhite:0.0 alpha:0.1]] forState:UIControlStateHighlighted];
    }
    
    //Used to help user create his/her password
    if ([SettingsManager sharedManager].changeVaultLock){
        [[SettingsManager sharedManager] resetUserPassword];
    }
    if(![SettingsManager sharedManager].userPassword) {
        createPasswordCount = 0;
        self.calculatorOutputLabel.text = @"Choose Password";
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Instructions"
                                      message:@"Type in a password then press '%' to continue. \n\n Once password is confirmed, you will use '%' to gain access to your secret folder."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"I UNDERSTAND" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       {
                                           
                                       }];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else {
        self.clickMeLabel.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//The operators on the calculator
#pragma  mark - Operator Buttons

//"AC-C" Button
- (IBAction)clearOutputButton:(UIButton *)sender
{
    [self unselectAllOperators];
    [self.calculator clearCalculator];
    [self updateUI];
}

//"+/-" Button
- (IBAction)switchOutputSigns:(UIButton *)sender
{
    [self.calculator switchSignNumber:[self anyOperatorsSelected]];
    [self updateUI];
}

//"%" Button
- (IBAction)percentage:(UIButton *)sender
{
    //The if the password on the calculator is not set, let user create one logic
    //ISPASSWORDCREATED???
    if (![SettingsManager sharedManager].isPasswordCreated){
        [[SettingsManager sharedManager] createUserPassword:self.calculator.outputAsString];
        [self.calculator clearCalculator];
        if (createPasswordCount == 0){
            self.calculatorOutputLabel.text = @"Confirm Password";
            createPasswordCount++;
        }
        else if (createPasswordCount == 1 && [SettingsManager sharedManager].isPasswordCreated) {
            if([SettingsManager sharedManager].changeVaultLock){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else{
                self.clickMeLabel.hidden = YES;
                self.calculatorOutputLabel.text = @"Enjoy :)";
                createPasswordCount++;
            }
        }
        else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            self.calculatorOutputLabel.text = @"Incorrect - Try Again";
            createPasswordCount = 0;
            [self.calculator clearCalculator];
            [SettingsManager sharedManager].isPasswordCreated = NO;
            [SettingsManager sharedManager].userPassword = nil;
        }
    }
    else if ([[SettingsManager sharedManager] unlockVaultLock:self.calculator.outputAsString]) {
        self.clickMeLabel.hidden = YES;
        if([SettingsManager sharedManager].lockVaultLock){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [self performSegueWithIdentifier:@"UnlockCalculatorVault" sender:self];
        }
    }
    else {
        [self.calculator concatDecimal:1
                    isOperatorSelected:[self anyOperatorsSelected]];
        [self updateUI];
    }
}

//"/" Button
- (IBAction)divide:(UIButton *)sender
{
    [self unselectAllOperators];
    //Select operator when pressed
    if (!self.boolDivisionButton){
        self.boolDivisionButton = YES;
        [[self.divisionButton layer] setBorderWidth:2];
    }
    [self.calculator selectOperator:@"/"];
    [self highlightButton:sender selected:self.boolDivisionButton];
    [self updateUI];
}

//"X" Button
- (IBAction)multiply:(UIButton *)sender
{
    [self unselectAllOperators];
    //Select operator when pressed
    if (!self.boolMultiplicationButton){
        self.boolMultiplicationButton = YES;
        [[self.multiplicationButton layer] setBorderWidth:2];
    }
    [self.calculator selectOperator:@"*"];
    [self highlightButton:sender selected:self.boolMultiplicationButton];
    [self updateUI];
}

//"-" Button
- (IBAction)subtract:(UIButton *)sender
{
    [self unselectAllOperators];
    //Select operator when pressed
    if(!self.boolSubtractionButton){
        self.boolSubtractionButton = YES;
        [[self.subtractionButton layer] setBorderWidth:2];
    }
    [self.calculator selectOperator:@"-"];
    [self highlightButton:sender selected:self.boolSubtractionButton];
    [self updateUI];
}

//"+" Button
- (IBAction)add:(UIButton *)sender
{
    [self unselectAllOperators];
    //Select operator when pressed
    if(!self.boolAdditionButton) {
        self.boolAdditionButton = YES;
        [[self.additionButton layer] setBorderWidth:2];
    }
    [self.calculator selectOperator:@"+"];
    [self highlightButton:sender selected:self.boolAdditionButton];
    [self updateUI];
}

//"=" Button
- (IBAction)equals:(UIButton *)sender
{
    [self unselectAllOperators];
    [self.calculator performCalculation];
    [self updateUI];
}

//Concats numbers to display and calculate numbers
#pragma mark - Number Buttons

//"9" Button
- (IBAction)nine:(UIButton *)sender
{
    [self.calculator concatNumber:@"9"
               isOperatorSelected:[self anyOperatorsSelected]];
    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"8" Button
- (IBAction)eight:(UIButton *)sender
{
    [self.calculator concatNumber:@"8"
               isOperatorSelected:[self anyOperatorsSelected]];
    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"7" Button
- (IBAction)seven:(UIButton *)sender
{
    [self.calculator concatNumber:@"7"
               isOperatorSelected:[self anyOperatorsSelected]];
    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"6" Button
- (IBAction)six:(UIButton *)sender
{
    [self.calculator concatNumber:@"6"
               isOperatorSelected:[self anyOperatorsSelected]];
    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"5" Button
- (IBAction)five:(UIButton *)sender
{
    [self.calculator concatNumber:@"5"
               isOperatorSelected:[self anyOperatorsSelected]];
    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"4" Button
- (IBAction)four:(UIButton *)sender
{
    [self.calculator concatNumber:@"4"
               isOperatorSelected:[self anyOperatorsSelected]];

    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"3" Button
- (IBAction)three:(UIButton *)sender
{
    [self.calculator concatNumber:@"3"
               isOperatorSelected:[self anyOperatorsSelected]];

    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"2" Button
- (IBAction)two:(UIButton *)sender
{
    [self.calculator concatNumber:@"2"
               isOperatorSelected:[self anyOperatorsSelected]];

    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"1" Button
- (IBAction)one:(UIButton *)sender
{
    [self.calculator concatNumber:@"1"
               isOperatorSelected:[self anyOperatorsSelected]];

    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"0" Button
- (IBAction)zero:(UIButton *)sender
{
    [self.calculator concatNumber:@"0"
               isOperatorSelected:[self anyOperatorsSelected]];

    [self updateUI];
    [self unselectHighlightOnOperators];
}

//"." Button
- (IBAction)decimalPoint:(UIButton *)sender
{
    [self.calculator concatDecimal:0
                isOperatorSelected:[self anyOperatorsSelected]];
    [self updateUI];
    [self unselectHighlightOnOperators];
}

//Checks to see if any operators are chosen
-(BOOL)anyOperatorsSelected
{
    if (self.boolDivisionButton == YES
        || self.boolMultiplicationButton == YES
        || self.boolAdditionButton == YES
        || self.boolSubtractionButton == YES) {
        return YES;
    }
    return NO;
}

//Removes borders on all operators
//Used when a digit button is selected so we still know what operator was previously selected
-(void)unselectHighlightOnOperators
{
    [[self.divisionButton layer] setBorderWidth:0];
    
    [[self.multiplicationButton layer] setBorderWidth:0];
    
    [[self.additionButton layer] setBorderWidth:0];
    
    [[self.subtractionButton layer] setBorderWidth:0];
}

//Removes borders and sets operator to not selected
//Used when another operator button is selected
-(void)unselectAllOperators
{
    self.boolDivisionButton= NO;
    [[self.divisionButton layer] setBorderWidth:0];
    
    self.boolMultiplicationButton = NO;
    [[self.multiplicationButton layer] setBorderWidth:0];
    
    self.boolAdditionButton = NO;
    [[self.additionButton layer] setBorderWidth:0];
    
    self.boolSubtractionButton = NO;
    [[self.subtractionButton layer] setBorderWidth:0];
}

//Called to update string display on calculator
-(void)updateUI
{
    //Formats display string to show commas, scientific notation, etc.
    self.calculatorOutputLabel.text = [self.calculator formatStringToDisplay:[self anyOperatorsSelected]];
    
    if ([self.calculator.outputAsString isEqualToString:@"0"]){
        //Used to rid of the animation from switching the title of the button
        [UIView setAnimationsEnabled:NO];
        [self.clearOutputButton setTitle:@"AC" forState:UIControlStateNormal];
        [UIView setAnimationsEnabled:YES];
    }
    else {
        [UIView setAnimationsEnabled:NO];
        [self.clearOutputButton setTitle:@"C" forState:UIControlStateNormal];
        [UIView setAnimationsEnabled:YES];
    }
}

//Outlines operator button's when selected
-(void)highlightButton:(UIButton *)sender selected:(BOOL)selected
{
    if (selected){
    [[sender layer] setBorderWidth:1.5];
    }
    else {
    [[sender layer] setBorderWidth:0.0f];
    }
}

//Convert button color to an image to allow highlighted state on button to darken when pressed
- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//Create calculator object
-(Calculator *) calculator
{
    if(!_calculator) _calculator = [[Calculator alloc] init];
    return _calculator;
}

@end
