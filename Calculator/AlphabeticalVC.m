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

static int createPasswordCount = 0;

@implementation AlphabeticalVC

- (void)viewDidLoad {
    [super viewDidLoad];

    if([SettingsManager sharedManager].changeVaultLock){
        [[SettingsManager sharedManager] resetUserPassword];
    }
    
    if([SettingsManager sharedManager].isPasswordCreated){
        self.instructionLabel.text = @"Enter Passcode";
    }
    else{
        self.instructionLabel.text = @"Create Passcode";
        createPasswordCount = 0;
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
    if([SettingsManager sharedManager].isPasswordCreated && [[SettingsManager sharedManager] unlockVaultLock:self.inputTextfield.text]){
        if([SettingsManager sharedManager].changeVaultLock){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else{
            [self performSegueWithIdentifier:@"UnlockAlphabeticalVault" sender:self];
        }
    }
    
    else if(![SettingsManager sharedManager].isPasswordCreated){
        [[SettingsManager sharedManager] createUserPassword:self.inputTextfield.text];
        if (createPasswordCount == 0){
            self.instructionLabel.text = @"Confirm Passcord";
            self.inputTextfield.text = @"";
            createPasswordCount++;
        }
        else if (createPasswordCount == 1 && [SettingsManager sharedManager].isPasswordCreated){
            createPasswordCount++;
            NSLog(@"Segue! password created");
            if([SettingsManager sharedManager].changeVaultLock){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
            [self performSegueWithIdentifier:@"UnlockAlphabeticalVault" sender:self];
            }
        }
        else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
            NSLog(@"Incorrect");
            self.instructionLabel.text = @"Create Passcode";
            createPasswordCount = 0;
            self.inputTextfield.text = @"";
            [SettingsManager sharedManager].isPasswordCreated = NO;
            [SettingsManager sharedManager].userPassword = nil;
        }
    }
    return NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
