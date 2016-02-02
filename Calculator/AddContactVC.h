//
//  AddContactVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 1/19/16.
//  Copyright © 2016 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contacts+CoreDataProperties.h"
@class ContactStorage;
@class ViewContactVC;

@interface AddContactVC : UIViewController

@property (strong, nonatomic) ContactStorage *contactStorage;

@property (weak, nonatomic) IBOutlet UITextField *firstNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *companyTextfield;
@property (weak, nonatomic) IBOutlet UITextField *mobileNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *homeNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *workNumberTextfield;
@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;
@property (weak, nonatomic) IBOutlet UITextField *webpageTextfield;
@property (weak, nonatomic) IBOutlet UITextField *notesTextfield;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
