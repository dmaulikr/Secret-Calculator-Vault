//
//  Settings.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/19/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingsManager : NSObject

+ (SettingsManager *)sharedManager;

@property (strong, nonatomic) NSString *userPassword;
@property (nonatomic) int currentLock;
@property (nonatomic) int passwordState;
@property (nonatomic) BOOL isPasswordCreated;


@property (nonatomic) BOOL changeVaultLock;
@property (nonatomic) BOOL lockVaultLock;


-(BOOL)unlockVaultLock:(NSString *)input;
-(void)setVaultLockType:(NSString *)vaultLockType;
-(void)createUserPassword:(NSString *)input;
-(void)resetUserPassword;

typedef enum {
    calculatorLock = 0,
    alphabeticalLock,
    numericalLock,
    patternLock,
    none
} SetLockTypes;

typedef enum {
    createPassword = 0,
    confirmPassword,
    createdPassword,
} CreatePassword;

@end
