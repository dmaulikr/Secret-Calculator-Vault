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

//Used to let the user create password
static int createPasswordCount = 0;

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
    
    // Do any additional setup after loading the view.
    self.digitInputTextView.delegate = self;
    [self.digitInputTextView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSLog(@"textview = %@", self.digitInputTextView.text);
    if(self.digitInputTextView.text.length == 1){
        self.firstDigit.text = @"・";
    }
    else if(self.digitInputTextView.text.length == 2){
        self.firstDigit.text = @"・";
        self.secondDigit.text = @"・";
    }
    else if(self.digitInputTextView.text.length == 3){
        self.firstDigit.text = @"・";
        self.secondDigit.text = @"・";
        self.thirdDigit.text = @"・";
    }
    else if(self.digitInputTextView.text.length == 4){
        self.firstDigit.text = @"・";
        self.secondDigit.text = @"・";
        self.thirdDigit.text = @"・";
        self.fourthDigit.text = @"・";
        
        if([SettingsManager sharedManager].isPasswordCreated && [[SettingsManager sharedManager] unlockVaultLock:self.digitInputTextView.text]){
            if([SettingsManager sharedManager].lockVaultLock){
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            else {
                [self performSegueWithIdentifier:@"UnlockNumericalVault" sender:self];
            }
        }
        
        else if(![SettingsManager sharedManager].isPasswordCreated){
            [[SettingsManager sharedManager] createUserPassword:self.digitInputTextView.text];
            if (createPasswordCount == 0){
                self.instructionLabel.text = @"Confirm Passcord";
                self.digitInputTextView.text = @"";
                self.firstDigit.text = @"-";
                self.secondDigit.text = @"-";
                self.thirdDigit.text = @"-";
                self.fourthDigit.text = @"-";
                createPasswordCount++;
            }
            else if (createPasswordCount == 1 && [SettingsManager sharedManager].isPasswordCreated){
                createPasswordCount++;
                NSLog(@"Segue! password created");
                if([SettingsManager sharedManager].changeVaultLock){
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
                else {
                [self performSegueWithIdentifier:@"UnlockNumericalVault" sender:self];
                }
            }
            
            else {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                NSLog(@"Incorrect");
                self.instructionLabel.text = @"Create Passcode";
                createPasswordCount = 0;
                self.digitInputTextView.text = @"";
                self.firstDigit.text = @"-";
                self.secondDigit.text = @"-";
                self.thirdDigit.text = @"-";
                self.fourthDigit.text = @"-";
                [SettingsManager sharedManager].isPasswordCreated = NO;
                [SettingsManager sharedManager].userPassword = nil;
            }
        }
        
        else {
            self.digitInputTextView.text = @"";
            self.firstDigit.text = @"-";
            self.secondDigit.text = @"-";
            self.thirdDigit.text = @"-";
            self.fourthDigit.text = @"-";
        }
    }
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
