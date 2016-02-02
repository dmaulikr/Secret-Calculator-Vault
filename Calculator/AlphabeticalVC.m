//
//  AlphabeticalVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/25/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "AlphabeticalVC.h"
#import "SettingsManager.h"
#import <AudioToolbox/AudioToolbox.h>


@interface AlphabeticalVC () <UITextFieldDelegate>

@end

@implementation AlphabeticalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([SettingsManager sharedManager].isPasswordCreated){
        self.instructionLabel.text = @"Enter Passcode";
    }
    else{
        self.instructionLabel.text = @"Create Passcode";
    }
    
    self.inputTextfield.delegate = self;
    [self.inputTextfield becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    CreatePassword passwordState;
    if (![SettingsManager sharedManager].isPasswordCreated)
        passwordState = [SettingsManager sharedManager].passwordState;
    else
        passwordState = 2;
    
    switch (passwordState) {
        case createPassword:
        {
            [[SettingsManager sharedManager] createUserPassword:self.inputTextfield.text];
            self.instructionLabel.text = @"Confirm Passcord";
            self.inputTextfield.text = @"";
            break;
        }
        case confirmPassword:
        {
            [[SettingsManager sharedManager] createUserPassword:self.inputTextfield.text];
            //Correct confirmation
            if([SettingsManager sharedManager].isPasswordCreated) {
                if([SettingsManager sharedManager].changeVaultLock){
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else{
                    [self performSegueWithIdentifier:@"UnlockAlphabeticalVault" sender:self];
                }
            }
            //Incorrect confirmation
            else {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                self.instructionLabel.text = @"Create Passcode";
                self.inputTextfield.text = @"";
            }
            break;
        }
        case createdPassword:
        {
            //Correct password
            if([[SettingsManager sharedManager] unlockVaultLock:self.inputTextfield.text]) {
                //Segue back to settings
                if([SettingsManager sharedManager].lockVaultLock){
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                //Segue to vault
                else{
                    [self performSegueWithIdentifier:@"UnlockAlphabeticalVault" sender:self];
                }
            }
            //Incorrect password
            else {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                NSLog(@"Incorrect Password");
                self.instructionLabel.text = @"Enter Passcode";
                self.inputTextfield.text = @"";
            }
        }
    }
    return NO;
}


@end
