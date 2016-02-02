//
//  WebBrowserVC.m
//  
//
//  Created by Corey Allen Pett on 9/6/15.
//
//

#import "WebBrowserVC.h"

@interface WebBrowserVC () <UISearchBarDelegate, UIScrollViewDelegate, UIWebViewDelegate>

@end

@implementation WebBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //Center webview on the scrollview
    [[self.webPage scrollView] setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    self.addressBar.placeholder = @"Enter website name";
    self.addressBar.autocapitalizationType = NO;
    
    NSString *website = @"https://google.com";
    NSURL *url = [NSURL URLWithString:website];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webPage loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//"<" Button
- (IBAction)backButton:(id)sender
{
    [self.webPage goBack];
}
//">" Button
- (IBAction)forwardButton:(id)sender
{
    [self.webPage goForward];
}

//When user presses return, webpage is navigated to user selected website
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *newWebsite = [NSString stringWithFormat:@"https://%@", self.addressBar.text];
    NSURL *url = [NSURL URLWithString:newWebsite];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webPage loadRequest:request];
    [searchBar resignFirstResponder];
}

@end
