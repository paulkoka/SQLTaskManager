//
//  dbManager.m
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import "dbManager.h"

static NSString* const DB_NAME = @"tasks.db";

@implementation dbManager

-(id) init{
    if ((self = [super init])) {
        [self createDB];
    }
    return self;
}

-(void) createDB{
    NSString* pathToDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    _pathToDB = [pathToDocuments stringByAppendingPathComponent:DB_NAME];
    
    
    if (sqlite3_open([_pathToDB UTF8String], &database) == SQLITE_OK) {

        char* errMSG;
        
        // const char* sql_stmt = "drop table todoList";
        
        const char* sql_stmt = "create table if not exists todoList (identifire INTEGER NOT NULL, statement INTEGER, TaskTitle TEXT, taskSubtitle TEXT, additionalInfo TEXT)";
        
        if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMSG) == SQLITE_OK) {
         
        }
        
    }
    
    sqlite3_close(database);
    
};



-(NSMutableArray*) getDataFromDB{
    
    NSMutableArray* dataContainer = [NSMutableArray array];
    
    if (sqlite3_open([_pathToDB UTF8String], &database) == SQLITE_OK)
    {
        sqlite3_stmt *stmt;
        NSString* query = @"SELECT * from todoList";
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &stmt, NULL) == SQLITE_OK) {

            while (sqlite3_step(stmt) == SQLITE_ROW) {
                
                TaskItem* item = [self addSeparateItemOnStatement:stmt];
                [dataContainer addObject:item];
                
            }
        }
    }
    return dataContainer;
}


-(void) addTask:(TaskItem*) item{
    if (sqlite3_open([_pathToDB UTF8String], &database) == SQLITE_OK) {
       
        char* errMSG;
        
        NSString* quiery = [NSString stringWithFormat:@"INSERT INTO todoList (statement, identifire, TaskTitle, taskSubtitle, additionalInfo) VALUES ('%d', '%d', '%@', '%@', '%@')", item.state, item.identifire, item.titleName, item.subtitleName, item.additonalonfo];
        
        if (sqlite3_exec(database, [quiery UTF8String], NULL, NULL, &errMSG)== SQLITE_OK) {
            
        }
        
    }
    sqlite3_close(database);
};


-(void) deliteTaskByIdentifire:(TaskItem*) item{
    if (sqlite3_open([_pathToDB UTF8String], &database) == SQLITE_OK) {
        char* errMSG;
        
        NSString* quiery = [NSString stringWithFormat:@"DELETE FROM todoList WHERE identifire = '%d'", item.identifire];
        
        sqlite3_exec(database, [quiery UTF8String], NULL, NULL, &errMSG);
        
    }
    sqlite3_close(database);
};


-(TaskItem*) addSeparateItemOnStatement:(sqlite3_stmt *) stmt{
    int uniqueID = sqlite3_column_int(stmt, 0);
    int state = (sqlite3_column_int(stmt, 1) == 0);
    char* titleChar = (char *) sqlite3_column_text(stmt, 2);
    char* subtitleChar = (char *) sqlite3_column_text(stmt, 3);
    char* additionalInfoChar = (char *) sqlite3_column_text(stmt, 4);
    
    NSString* title = [NSString string];
    NSString* subtitle = [NSString string];
    NSString* additionalInfo = [NSString string];
    
    
    if (titleChar) {
        title = [[NSString alloc] initWithUTF8String:titleChar];
    }
    if (subtitleChar) {
        subtitle = [[NSString alloc] initWithUTF8String: subtitleChar];
    }
    
    if (additionalInfoChar) {
        additionalInfo = [[NSString alloc] initWithUTF8String:additionalInfoChar];
    }
    
    TaskItem* item = [[TaskItem alloc]  initWithUniqeId:uniqueID withState:state title:title subtitle:subtitle additionalInformation:additionalInfo];
    
    return item;
}


-(void) updateTaskItem:(TaskItem*) item{
    
    if (sqlite3_open([_pathToDB UTF8String], &database) == SQLITE_OK) {
        
        char* errMSG;
        
        NSString* quiery = [NSString stringWithFormat:@"update todoList SET statement = '%d', taskTitle = '%@', taskSubtitle = '%@', additionalInfo = '%@' WHERE identifire = '%d'", item.state, item.titleName, item.subtitleName, item.additonalonfo,  item.identifire];
        
        sqlite3_exec(database, [quiery UTF8String], NULL, NULL, &errMSG);
     }
    sqlite3_close(database);
};


@end
