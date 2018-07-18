//
//  dataManager.h
//  anotherDBBasedtaskmngr
//
//  Created by Pavel Koka on 7/18/18.
//  Copyright © 2018 paul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskItem.h"
#import "dbManager.h"
#import "coreDataManager.h"

typedef enum {
    fromSqlDataBase,
    fromCoreData,
} DataFrom;

@interface dataManager : NSObject

@property(nonatomic, assign) DataFrom dataFrom;
@property(nonatomic, strong) NSMutableArray* dataContainerForView;


@property(nonatomic, strong) dbManager* SQLiteDataBase;
@property (nonatomic, strong) coreDataManager* coreDataBase;


-(id) initDefault;
-(id) initWithDataFrom:(DataFrom) dataFrom;

-(NSMutableArray*) downloadDataFromBase;

-(void) deliteItem:(TaskItem*) item;

-(void) addItem:(TaskItem*) item;

-(void) updateItem:(TaskItem*) item;

@end
