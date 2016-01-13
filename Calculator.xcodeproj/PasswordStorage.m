//
//  PasswordStorage.m
//  Calculator
//
//  Created by Corey Allen Pett on 11/15/15.
//  Copyright © 2015 Corey Allen Pett. All rights reserved.
//

#import "PasswordStorage.h"

@implementation PasswordStorage

-(void)fetchPasswords
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Passwords"];
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES]];
    self.userPasswords = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    NSLog(@"userpasswords = %@", self.userPasswords);
}

-(void)deletePassword:(long)index
{
    NSManagedObjectContext *context = [self managedObjectContext];
    [context deleteObject:[self.userPasswords objectAtIndex:index]];
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
        return;
    }
    [self.userPasswords removeObjectAtIndex:index];
}

-(void)createPassword:(NSString *)title
             username:(NSString *)userName
             password:(NSString *)password
              website:(NSString *)website
                notes:(NSString *)notes
{
    NSManagedObjectContext *context = [self managedObjectContext];
    // Create a new managed object
    Passwords *newPassword = [NSEntityDescription insertNewObjectForEntityForName:@"Passwords" inManagedObjectContext:context];
    newPassword.date = [NSDate date];
    newPassword.notes = notes;
    newPassword.username = userName;
    newPassword.password = password;
    newPassword.title = title;
    newPassword.website = website;

    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    NSLog(@"password = %@", newPassword);

}

-(void)savePassword:(NSString *)title
             username:(NSString *)userName
             password:(NSString *)password
              website:(NSString *)website
                notes:(NSString *)notes
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    self.selectedPassword.title = title;
    self.selectedPassword.username = userName;
    self.selectedPassword.password = password;
    self.selectedPassword.website = website;
    self.selectedPassword.notes = notes;
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}


//Set up NSManagedObject for CoreData material
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(NSMutableArray *)userPasswords
{
    if(!_userPasswords) _userPasswords = [[NSMutableArray alloc] init];
    return _userPasswords;
}

@end
