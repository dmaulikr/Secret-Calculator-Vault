//
//  PhotoTVC.h
//  Calculator
//
//  Created by Corey Allen Pett on 10/13/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album+CoreDataProperties.h"
#import "Photo+CoreDataProperties.h"

@interface PhotoTVC : UITableViewController

@property (strong, nonatomic) NSMutableArray *userAlbums;

@end
