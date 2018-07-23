//
//  TaskItem.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    undone = 0,
    done
} stateInt;

@interface TaskItem : NSObject

@property (nonatomic, assign) int identifire;
@property (nonatomic, assign) int state;

@property (nonatomic, copy) NSString* titleName;
@property (nonatomic, copy) NSString* subtitleName;
@property (nonatomic, copy) NSString* additonalonfo;

-(id) initWithUniqeId:(int) identifire withState:(int) state title:(NSString*) title subtitle:(NSString*) subtitle additionalInformation:(NSString*)additionalInformation;

-(id)initWithCustomId;

@end
