//
//  dbManager.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TaskItem.h"
#import "sqlite3.h"

static sqlite3* database;


@interface dbManager : NSObject
@property (nonatomic) NSString* pathToDB;

-(id) init;

-(NSMutableArray*) getDataFromDB;

-(void) addTask:(TaskItem*) item;

-(void) deliteTaskByIdentifire:(TaskItem*) item;


-(void) updateTaskItem:(TaskItem*) item;

@end
