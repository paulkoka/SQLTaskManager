//
//  coreDataManager.h
//  anotherDBBasedtaskmngr
//
//  Created by Pavel Koka on 7/17/18.
//  Copyright © 2018 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KPITasksTable.h"
#import "AppDelegate.h"
#import "TaskItem.h"

@interface coreDataManager : NSObject

@property(nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) AppDelegate* appDelegate;
@property(nonatomic, strong) NSMutableArray* dataContainer;


-(void) addItem:(TaskItem*)item;

- (void)deleteTaskWithID:(TaskItem *)item;

- (void)editTask:(TaskItem *)item;

- (NSMutableArray*)loadTasks;

@end
