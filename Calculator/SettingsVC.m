//
//  SettingsVC.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/9/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingsManager.h"
#import "CalculatorVC.h"
#import "NumericalVC.h"
#import "AlphabeticalVC.h"
#import "PatternVC.h"

@interface SettingsVC ()

@end

@implementation SettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)lockButton:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [[UIViewController alloc] init];
    lockTypes = [SettingsManager sharedManager].currentLock;
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
    
    [SettingsManager sharedManager].lockVaultLock = YES;
    [viewController setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:viewController animated:YES completion:nil];
    
}

enum lockTypes
{
    calculatorLock = 0,
    alphabeticalLock,
    numericalLock,
    patternLock,
    none
}lockTypes;


@end
