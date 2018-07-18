//
//  TaskItem.h
//  anotherDBBasedtaskmngr
//
//  Created by paul on 11/07/2018.
//  Copyright © 2018 paul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskItem : NSObject

@property (nonatomic, assign) int identifire;
@property (nonatomic) BOOL state;

@property (nonatomic, copy) NSString* titleName;
@property (nonatomic, copy) NSString* subtitleName;
@property (nonatomic, copy) NSString* additonalonfo;

-(id) initWithUniqeId:(int) identifire withState:(BOOL) state title:(NSString*) title subtitle:(NSString*) subtitle additionalInformation:(NSString*)additionalInformation;

-(id)initWithCustomId;

@end
