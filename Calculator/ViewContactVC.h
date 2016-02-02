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
@class AddContactVC;

@interface ViewContactVC : UIViewController

@property (strong, nonatomic) ContactStorage *contactStorage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *companyButton;
@property (weak, nonatomic) IBOutlet UIButton *mobileButton;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *workButton;
@property (weak, nonatomic) IBOutlet UIButton *emailButton;
@property (weak, nonatomic) IBOutlet UIButton *webpageButton;
@property (weak, nonatomic) IBOutlet UIButton *notesButton;

@end
