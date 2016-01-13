//
//  PasswordStorage.h
//  Calculator
//
//  Created by Corey Allen Pett on 11/15/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Passwords+CoreDataProperties.h"

@interface PasswordStorage : NSObject

@property (strong, nonatomic) NSMutableArray *userPasswords;
@property (strong, nonatomic) Passwords *selectedPassword;

-(void)fetchPasswords;

-(void)deletePassword:(long)index;

-(void)createPassword:(NSString *)title
             username:(NSString *)userName
             password:(NSString *)password
              website:(NSString *)website
                notes:(NSString *)notes;

-(void)savePassword:(NSString *)title
             username:(NSString *)userName
             password:(NSString *)password
              website:(NSString *)website
                notes:(NSString *)notes;

@end
