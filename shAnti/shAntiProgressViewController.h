//
//  shAntiProgressViewController.h
//  shAnti
//
//  Created by Jordan Gurrieri on 4/15/12.
//  Copyright (c) 2012 Blue Label Solutions LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface shAntiProgressViewController : BaseViewController < NSFetchedResultsControllerDelegate, UITableViewDelegate, UITableViewDataSource > {
    UITableView         *m_tbl_progress;
}

@property (nonatomic, retain) NSFetchedResultsController*   frc_meditationInstances;

@property (nonatomic, retain) IBOutlet UITableView          *tbl_progress;

@end
