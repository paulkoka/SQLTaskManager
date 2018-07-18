//
//  LIstOfAllTasks.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "editingTaskViewController.h"
#import "TaskItem.h"
#import "dataManager.h"

@interface LIstOfAllTasks : UIViewController <UITableViewDelegate, UITableViewDataSource, editingTaskViewControllerProtocol>
@property (weak, nonatomic) IBOutlet UITableView *listOfTasks;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNew;
@property (weak, nonatomic) IBOutlet UISegmentedControl *DataFromSetControl;

- (IBAction)DataFromSet:(id)sender;


@property (nonatomic, strong) dataManager* database;


@property (strong, nonatomic) NSMutableArray* datacontainer;

@property (nonatomic) TaskItem* recordToEdit;

- (IBAction)addNewRecord:(id)sender;

-(void) loadData;

-(void)editingInfoWasFinished;

@end
