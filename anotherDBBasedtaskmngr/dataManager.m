//
//  dataManager.m
//  anotherDBBasedtaskmngr
//
//  Created by Pavel Koka on 7/18/18.
//  Copyright © 2018 paul. All rights reserved.
//


#import "dataManager.h"

@implementation dataManager

#pragma MARK - common Methods

-(id) initDefault{
    _dataFrom = fromSqlDataBase;
    if ((self = [super init])) {
        [self initSQLite];
        [self initCoreData];
    }
    return self;
}

-(id) initWithDataFrom:(DataFrom) dataFrom{
    _dataFrom = dataFrom;
    if ((self = [super init])) {
        [self initSQLite];
        [self initCoreData];
    }
    return self;
}

-(NSMutableArray*) downloadDataFromBase{
    if (_dataFrom == fromCoreData) {
       
        
        
        
        return [self downloadDataFromCoreData];
    }
    else{
    return [self downloadDataFromSQLite];
    }
}

-(void) deliteItem:(TaskItem*) item{
    
   
    
    [self deliteItemFromSQLite:item];
    [self deliteItemFromCoreData:item];
};

-(void) addItem:(TaskItem*) item{
    [self addItemToSQLite:item];
    [self addItemToCoreData:item];
};

-(void) updateItem:(TaskItem*) item{
    [self updateTaskItemInSQLite:item];
    [self updateTaskItemInCoreData:item];
};


#pragma MARK - Methods for SQLite


- (void)initSQLite{
    
    self.SQLiteDataBase = [[dbManager alloc] init];
    
};

-(NSMutableArray*) downloadDataFromSQLite{
    return [NSMutableArray arrayWithArray:[self.SQLiteDataBase getDataFromDB]];
}



-(void) deliteItemFromSQLite:(TaskItem*) item{
    [self.SQLiteDataBase deliteTaskByIdentifire:item];
}


-(void) addItemToSQLite:(TaskItem *)item{
    [self.SQLiteDataBase addTask:item];
}


-(void) updateTaskItemInSQLite:(TaskItem*) item{
    [self.SQLiteDataBase updateTaskItem:item];
}

#pragma MARK - Methods for CoreData

- (void)initCoreData{
    
    self.coreDataBase = [[coreDataManager alloc] init];
    [self.coreDataBase loadTasks];
    
};

-(NSMutableArray*) downloadDataFromCoreData{
    return [NSMutableArray arrayWithArray:[self.coreDataBase loadTasks]];
}



-(void) deliteItemFromCoreData:(TaskItem*) item{
    [self.coreDataBase deleteTaskWithID:item];
}


-(void) addItemToCoreData:(TaskItem *)item{
    [self.coreDataBase addItem:item];
}


-(void) updateTaskItemInCoreData:(TaskItem*) item{
    [self.coreDataBase editTask:item];
}

@end
