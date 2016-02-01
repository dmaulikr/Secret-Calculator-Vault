//
//  NumericalVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/20/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "NumericalVC.h"
#import "SettingsManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface NumericalVC () <UITextViewDelegate>

@end

@implementation NumericalVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.digitInputTextView.delegate = self;
    [self.digitInputTextView becomeFirstResponder];
    
    if([SettingsManager sharedManager].isPasswordCreated){
        self.instructionLabel.text = @"Enter Passcode";
    }
    else{
        self.instructionLabel.text = @"Create Passcode";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

typedef enum {
    oneDigitSelected = 1,
    twoDigitSelected,
    threeDigitSelected,
    fourDigitSelected
} NumericalDigitSelection;

-(void)textViewDidChange:(UITextView *)textView
{
    CreatePassword passwordState;
    if(![SettingsManager sharedManager].isPasswordCreated)
        passwordState = [SettingsManager sharedManager].passwordState;
    else
        passwordState = 2;
    
    NumericalDigitSelection digitCount = self.digitInputTextView.text.length;
    switch (digitCount)
    {
        case oneDigitSelected:
        {
            self.firstDigit.text = @"・";
            break;
        }
        case twoDigitSelected:
        {
            self.firstDigit.text = @"・";
            self.secondDigit.text = @"・";
            break;
        }
        case threeDigitSelected:
        {
            self.firstDigit.text = @"・";
            self.secondDigit.text = @"・";
            self.thirdDigit.text = @"・";
            break;
        }
        case fourDigitSelected:
        {
            self.firstDigit.text = @"・";
            self.secondDigit.text = @"・";
            self.thirdDigit.text = @"・";
            self.fourthDigit.text = @"・";
            
            switch (passwordState)
            {   //Create a new password
                case createPassword:
                {
                    [[SettingsManager sharedManager] createUserPassword:self.digitInputTextView.text];
                    self.instructionLabel.text = @"Confirm Passcord";
                    self.digitInputTextView.text = @"";
                    self.firstDigit.text = @"-";
                    self.secondDigit.text = @"-";
                    self.thirdDigit.text = @"-";
                    self.fourthDigit.text = @"-";
                    break;
                }
                //Confirm a new password
                case confirmPassword:
                {
                    [[SettingsManager sharedManager] createUserPassword:self.digitInputTextView.text];
                    //Correct confirmation
                    if([SettingsManager sharedManager].isPasswordCreated) {
                        if([SettingsManager sharedManager].changeVaultLock) {
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                        else {
                            [self performSegueWithIdentifier:@"UnlockNumericalVault" sender:self];
                        }
                    }
                    //Incorrect confirmation
                    else {
                        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                        NSLog(@"Incorrect");
                        self.instructionLabel.text = @"Create Passcode";
                        self.digitInputTextView.text = @"";
                        self.firstDigit.text = @"-";
                        self.secondDigit.text = @"-";
                        self.thirdDigit.text = @"-";
                        self.fourthDigit.text = @"-";
                    }
                    break;
                }
                //Password is created
                case createdPassword:
                {
                    //Correct Password
                    if ([[SettingsManager sharedManager] unlockVaultLock:self.digitInputTextView.text]) {
                        //Segue back to settings
                        if([SettingsManager sharedManager].lockVaultLock){
                            [self dismissViewControllerAnimated:YES completion:nil];
                        }
                        //Segue to vault
                        else {
                            [self performSegueWithIdentifier:@"UnlockNumericalVault" sender:self];
                        }
                    }
                    //Incorrect Password
                    else {
                        self.instructionLabel.text = @"Enter Passcode";
                        self.digitInputTextView.text = @"";
                        self.firstDigit.text = @"-";
                        self.secondDigit.text = @"-";
                        self.thirdDigit.text = @"-";
                        self.fourthDigit.text = @"-";
                    }
                    break;
                }
            }
            break;
        }
    }
}


@end
