//
//  shAntiMeditateViewController.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shAntiMeditateViewController : UITableViewController {
    UITableView     *m_tbl_meditate;
    
    NSArray         *m_deepBreathing;
    NSArray         *m_bobyScan;
    NSArray         *m_groupMeditation;
}

@property (nonatomic, retain) IBOutlet UITableView*     tbl_meditate;

@property (nonatomic, retain) NSArray*     deepBreathing;
@property (nonatomic, retain) NSArray*     bobyScan;
@property (nonatomic, retain) NSArray*     groupMeditation;

@end
