//
//  NLTemplatePlugin.m
//  NLPluginTemplate
//
//  Created by Chris Farber on 2/9/07.
//  Copyright 2007 Brian Cooke. All rights reserved.
//

#import "rooSwitchPlugin.h"
#import "SwitchAction.h"

@implementation rooSwitchNLPlugin

- (NSArray *)actions
{
    if ([[NSWorkspace sharedWorkspace] fullPathForApplication:@"rooSwitch"])
    {
        return [NSArray arrayWithObjects:
            [rooSwitchSwitchAction class],
            nil];
    }
    else
    {
        // rooSwitch not installed
        return nil;
    }
}

@end
