//
//  SecurityVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/19/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "SettingsManager.h"
#import "SecurityVC.h"
#import "CalculatorVC.h"
#import "NumericalVC.h"
#import "AlphabeticalVC.h"
#import "PatternVC.h"

@interface SecurityVC ()

@end

@implementation SecurityVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setCheckmark];
}

-(void)setCheckmark
{
    self.alphabeticalCheck.hidden = YES;
    self.numericalCheck.hidden = YES;
    self.patternCheck.hidden = YES;
    self.calculatorCheck.hidden = YES;
    self.noneCheck.hidden = YES;
    
    SetLockTypes lockTypes = [SettingsManager sharedManager].currentLock;
    switch (lockTypes)
    {
        case calculatorLock:
        {
            self.calculatorCheck.hidden = NO;
            break;
        }
            
        case alphabeticalLock:
        {
            self.alphabeticalCheck.hidden = NO;
            break;
        }
            
        case numericalLock:
        {
            self.numericalCheck.hidden = NO;
            break;
        }
            
        case patternLock:
        {
            self.patternCheck.hidden = NO;
            break;
        }
            
        case none:
        {
            self.noneCheck.hidden = NO;
            break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)alphabeticalButton:(id)sender
{
    [[SettingsManager sharedManager] setVaultLockType:@"alphabeticalButton"];
    [SettingsManager sharedManager].changeVaultLock = YES;
    [self setCheckmark];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlphabeticalVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"alphabeticalLock"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)numericalButton:(id)sender
{
    [[SettingsManager sharedManager] setVaultLockType:@"numericalButton"];
    [SettingsManager sharedManager].changeVaultLock = YES;
    [self setCheckmark];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NumericalVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"numericalLock"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)patternButton:(id)sender
{
//    [self.userSettings setLock:@"patternButton"];
//    [SettingsManager sharedManager].changeVaultLock = YES;
//    [self setCheckmark];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PatternVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"patternLock"];
//    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
//    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)calculatorButton:(id)sender
{
    [[SettingsManager sharedManager] setVaultLockType:@"calculatorButton"];
    [SettingsManager sharedManager].changeVaultLock = YES;
    [self setCheckmark];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CalculatorVC *viewController = [storyboard instantiateViewControllerWithIdentifier:@"calculatorLock"];
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
}

- (IBAction)noneButton:(id)sender
{
    [[SettingsManager sharedManager] setVaultLockType:@"noneButton"];
    [self setCheckmark];
}

- (IBAction)changePasswordButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [[UIViewController alloc] init];
    SetLockTypes lockTypes = [SettingsManager sharedManager].currentLock;
    switch (lockTypes)
    {
        case calculatorLock:
        {
            viewController = (CalculatorVC *)viewController;
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"calculatorLock"];
            break;
        }
            
        case alphabeticalLock:
        {
            viewController = (AlphabeticalVC *)viewController;
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"alphabeticalLock"];
            break;
        }
            
        case numericalLock:
        {
            viewController = (NumericalVC *)viewController;
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"numericalLock"];
            break;
        }
            
        case patternLock:
        {
            viewController = (PatternVC *)viewController;
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"patternLock"];
            break;
        }
            
        case none:
        {
            //tell user she/he has no lock
            break;
        }
    }
    
    [SettingsManager sharedManager].changeVaultLock = YES;
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
    
}
@end
