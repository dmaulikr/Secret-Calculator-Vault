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
    }
    //Confirm user password
    else if (self.userPassword){
        if([self.userPassword isEqualToString:input]) {
            self.isPasswordCreated = YES;
            [[NSUserDefaults standardUserDefaults]setValue:self.userPassword forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
//        else {
//            self.userPassword = nil;
//        }
    }
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

//Check if password is set and retrieve it
-(void)retrieveUserPassword
{
    self.userPassword = [[NSUserDefaults standardUserDefaults] stringForKey:@"password"];
    if(!self.userPassword) {
        self.isPasswordCreated = NO;
    }
    else {
        self.isPasswordCreated = YES;
    }
}

//Check was lock is selected
-(void)retrieveCurrentLock
{
    self.currentLock = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLock"];
    // Set lock to calculator if no lock chosen
    if(!self.currentLock){
        self.currentLock = 0;
        [[NSUserDefaults standardUserDefaults]setInteger:self.currentLock forKey:@"currentLock"];
        [[NSUserDefaults standardUserDefaults] synchronize];
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

-(NSString *)userPassword
{
    if(!_userPassword) _userPassword = [[NSString alloc] init];
    [self retrieveUserPassword];
    return _userPassword;
}

-(int)currentLock
{
    [self retrieveCurrentLock];
    return self.currentLock;
}

@end
