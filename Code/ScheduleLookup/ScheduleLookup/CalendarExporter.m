//
//  CalendarExporter.m
//  ScheduleLookup
//
//  Created by CSSE Department on 5/1/12.
//  Copyright (c) 2012 Rose-Hulman Institute of Technology. All rights reserved.
//

#import "CalendarExporter.h"
#import <EventKit/EventKit.h>


@implementation CalendarExporter

- (void) initiateExportWithSchedule: (Schedule*) schedule OnDate:(NSDate*) start Until:(NSDate*) end
{
    for (ClassSchedule *sched in schedule.schedule)
    {
        [self exportSingleClassToCalendar:sched From:start Until:end];
    }
}

- (void) exportSingleClassToCalendar:(ClassSchedule *)schedule From:(NSDate*) startDate Until:(NSDate*) endDate
{
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    
    EKEvent *event = [EKEvent eventWithEventStore:eventStore];
    NSMutableArray* daysOfWeek = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [schedule getClassDays].length; i++)
    {
        NSString* dayCode = [NSString stringWithFormat:@"%C",[[schedule getClassDays] characterAtIndex:i]];
        if([dayCode isEqualToString:@"M"])
        {
            [daysOfWeek addObject:[NSNumber numberWithInt:2]];
        }
        else if([dayCode isEqualToString:@"T"])
        {
            [daysOfWeek addObject:[NSNumber numberWithInt:3]];
        }
        else if([dayCode isEqualToString:@"W"])
        {
            [daysOfWeek addObject:[NSNumber numberWithInt:4]];
        }
        else if([dayCode isEqualToString:@"R"])
        {
            [daysOfWeek addObject:[NSNumber numberWithInt:5]];
        }
        else if([dayCode isEqualToString:@"F"])
        {
            [daysOfWeek addObject:[NSNumber numberWithInt:6]];
        }
    }
    

    [event setTitle:schedule.Course];
    [event setLocation:schedule.getLocation];
    [event setStartDate:startDate];
    [event setEndDate:endDate];
    [event setCalendar:[eventStore defaultCalendarForNewEvents]];
    
    NSError *err;
    [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
    
    NSLog(@"Exported event: %@", schedule.Course);
    
    
}

@end