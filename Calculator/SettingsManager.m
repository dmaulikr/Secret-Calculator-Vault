//
//  Settings.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/19/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "SettingsManager.h"

@implementation SettingsManager

+ (SettingsManager *)sharedManager
{
    static SettingsManager *_manager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

//Create user password
-(void)createUserPassword:(NSString *)input
{
    //Set user password
    if (!self.userPassword) {
        self.userPassword = input;
        self.passwordState = 1;
        self.isPasswordCreated = NO;
    }
    //Confirm user password
    else if (self.userPassword){
        if([self.userPassword isEqualToString:input]) {
            self.isPasswordCreated = YES;
            self.passwordState = 2;
            [[NSUserDefaults standardUserDefaults]setValue:self.userPassword forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        //Incorrect confirmation
        else {
            self.userPassword = nil;
            self.isPasswordCreated = NO;
            self.passwordState = 0;
        }
    }
    [[NSUserDefaults standardUserDefaults] setInteger:_passwordState forKey:@"passwordState"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)resetUserPassword
{
    self.isPasswordCreated = NO;
    [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


//Allow access to the users vault
-(BOOL)unlockVaultLock:(NSString *)input
{
    if([self.userPassword isEqualToString:input]){
        return YES;
    }
    else{
        return NO;
    }
}

//Set lock based on users selection in settings
-(void)setVaultLockType:(NSString *)vaultLockType
{
    if([vaultLockType isEqualToString:@"calculatorButton"]){
        self.currentLock = 0;
    }
    if([vaultLockType isEqualToString:@"alphabeticalButton"]){
        self.currentLock = 1;
    }
    if([vaultLockType isEqualToString:@"numericalButton"]){
        self.currentLock = 2;
    }
    if([vaultLockType isEqualToString:@"patternButton"]){
        self.currentLock = 3;;
    }
    if ([vaultLockType isEqualToString:@"noneButton"]) {
        self.currentLock = 4;;
    }
    //Save
    [[NSUserDefaults standardUserDefaults]setInteger:self.currentLock forKey:@"currentLock"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(int)currentLock
{
    //Grab all of the data
    _currentLock = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLock"];
    _passwordState = [[NSUserDefaults standardUserDefaults] integerForKey:@"passwordState"];
    _userPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    if(!_userPassword) self.isPasswordCreated = NO;
    if(_userPassword) self.isPasswordCreated = YES;
    return _currentLock;
}

-(int)passwordState
{
    _passwordState = [[NSUserDefaults standardUserDefaults] integerForKey:@"passwordState"];
    NSLog(@"state = %d", _passwordState);
    return _passwordState;
}

@end
