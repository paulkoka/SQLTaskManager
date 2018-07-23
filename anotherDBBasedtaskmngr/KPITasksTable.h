//
//  KPITasksTable.h
//  anotherDBBasedtaskmngr
//
//  Created by Pavel Koka on 7/16/18.
//  Copyright © 2018 paul. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface KPITasksTable : NSManagedObject

@property (nonatomic, assign) int identifire;
@property (nonatomic, assign) int statement;

@property (nonatomic, copy) NSString* taskTitle;
@property (nonatomic, copy) NSString* taskSubtitle;
@property (nonatomic, copy) NSString* additionalInfo;

+(NSFetchRequest <KPITasksTable*> *) fetchRequest;
@end
