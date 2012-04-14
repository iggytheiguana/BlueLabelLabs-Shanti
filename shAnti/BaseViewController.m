//
//  BaseViewController.m
//  shAnti
//
//  Created by Jasjeet Gill on 4/14/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import "BaseViewController.h"

#define kSELECTOR   @"selector"
#define kTARGETOBJECT   @"targetobject"
#define kPARAMETER   @"parameter"

@implementation BaseViewController
@synthesize loginView = m_loginView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) authenticate:(BOOL)facebook 
          withTwitter:(BOOL)twitter 
     onFinishSelector:(SEL)sel 
       onTargetObject:(id)targetObject 
           withObject:(id)parameter 
{
    
    
    
    NSMutableDictionary* userInfo = nil;
    if (targetObject != nil) {
        userInfo = [[NSMutableDictionary alloc]init ];
        //we stuff in the callback parameters into the user info, we will
        //use these when dealing with the callback
        NSValue* selectorValue = [NSValue valueWithPointer:sel];
        [userInfo setValue:selectorValue forKey:kSELECTOR];
        [userInfo setValue:targetObject forKey:kTARGETOBJECT];
        [userInfo setValue:parameter forKey:kPARAMETER];
    }
    
    Callback* onSucccessCallback = [[Callback alloc]initWithTarget:self withSelector:@selector(onLoginComplete:) withContext:userInfo];
    Callback* onFailCallback = [[Callback alloc]initWithTarget:self withSelector:@selector(onLoginFailed:) withContext:userInfo];
    
    [userInfo release];
    
    [self.view addSubview:self.loginView];
    [self.loginView authenticate:facebook withTwitter:twitter onSuccessCallback:onSucccessCallback onFailCallback:onFailCallback];
    [onSucccessCallback release];
    [onFailCallback release];
}

@end
