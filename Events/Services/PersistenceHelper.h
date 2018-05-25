//
//  PersistenceHelper.h
//  Events
//
//  Created by C4Q on 5/25/18.
//  Copyright © 2018 Alex Paul. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Event.h"

@interface PersistenceHelper: NSObject

+(instancetype)shared;
-(NSArray*)getFavoriteEvents;
-(BOOL)saveEvent:(Event *) event;

@end
