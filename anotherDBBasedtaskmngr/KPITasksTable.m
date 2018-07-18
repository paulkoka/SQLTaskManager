//
//  KPITasksTable.m
//  anotherDBBasedtaskmngr
//
//  Created by Pavel Koka on 7/16/18.
//  Copyright © 2018 paul. All rights reserved.
//

#import "KPITasksTable.h"

@implementation KPITasksTable

@dynamic identifire;
@dynamic statement;

@dynamic taskTitle;
@dynamic taskSubtitle;
@dynamic additionalInfo;

+(NSFetchRequest <KPITasksTable*> *) fetchRequest{
    return  [NSFetchRequest fetchRequestWithEntityName:@"KPITasksTable"];
};

@end

