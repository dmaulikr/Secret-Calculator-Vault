//
//  WebBrowserVC.h
//  
//
//  Created by Corey Allen Pett on 9/6/15.
//
//

#import <UIKit/UIKit.h>

@interface WebBrowserVC : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webPage;
@property (weak, nonatomic) IBOutlet UISearchBar *addressBar;

@end
