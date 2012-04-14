//
//  BaseViewController.h
//  shAnti
//
//  Created by Jasjeet Gill on 4/14/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILoginView.h"
@interface BaseViewController : UIViewController
{
    UILoginView*            m_loginView;
}
@property (nonatomic, retain) UILoginView*              loginView;


- (void) authenticate:(BOOL)facebook 
          withTwitter:(BOOL)twitter 
     onFinishSelector:(SEL)sel 
       onTargetObject:(id)targetObject 
           withObject:(id)parameter;



@end
