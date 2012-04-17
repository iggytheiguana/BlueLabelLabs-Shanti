//
//  shAntiGroupsViewController.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/15/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface shAntiGroupsViewController : BaseViewController < NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate > {
    UITableView         *m_tbl_groups;
}

@property (nonatomic, retain) NSFetchedResultsController*   frc_meditationInstances;

@property (nonatomic, retain) IBOutlet UITableView          *tbl_groups;

@end
