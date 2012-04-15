//
//  shAntiFavoritesViewController.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shAntiFavoritesViewController : UITableViewController {
    UISegmentedControl  *m_sgmt_segmentedControl;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl   *sgmt_segmentedControl;

- (IBAction)indexDidChangeForSegmentedControl:(UISegmentedControl*)segmentedControl;

@end
