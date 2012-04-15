//
//  shAntiMeditateViewController.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventKitUI/EKEventEditViewController.h"


@interface shAntiMeditateViewController : UITableViewController < EKEventEditViewDelegate >{
    UISegmentedControl  *m_sgmt_segmentedControl;
    UITableView         *m_tbl_meditate;
    
    NSMutableArray         *m_deepBreathing;
    NSMutableArray         *m_bobyScan;
    NSMutableArray         *m_groupMeditation;
}

@property (nonatomic, retain) IBOutlet UISegmentedControl   *sgmt_segmentedControl;
@property (nonatomic, retain) IBOutlet UITableView          *tbl_meditate;

@property (nonatomic, retain) NSMutableArray     *deepBreathing;
@property (nonatomic, retain) NSMutableArray     *bobyScan;
@property (nonatomic, retain) NSMutableArray     *groupMeditation;

- (IBAction)indexDidChangeForSegmentedControl:(UISegmentedControl*)segmentedControl;

@end
