//
//  ViewContactVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 1/19/16.
//  Copyright © 2016 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts+CoreDataProperties.h"
@class ContactStorage;

@interface ViewContactVC : UIViewController

@property (strong, nonatomic) ContactStorage *contactStorage;

@end
