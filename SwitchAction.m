//
//  NLTestAction.m
//  NLPluginTemplate
//
//  Created by Chris Farber on 2/9/07.
//  Copyright 2007 Brian Cooke. All rights reserved.
//

#import "SwitchAction.h"
#import "SwitchActionOptionSheetController.h"

@implementation rooSwitchSwitchAction

/*  The action ID only has to be unique within the scope of the bundle.
    By default, NLAction will assume the action ID to be the name of the nib
    containing the option sheet.
*/
+ (NSString *)actionID
{
    return @"SwitchAction";
}

/* the category that the action will appear in in the "add action" sheet
*/
+ (NSString *)category
{
    return @"rooSwitch";
}

/* the name that will appear in the "add action" sheet
*/
+ (NSString *)title
{
    return @"Switch Profiles";
}

- (NSDictionary *)optionDefaults
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
        @"", @"application",
        @"default", @"profile",
        nil];
}

/*  this method is invoked to get a description of the action to show in the
    location's list of actions
*/
- (NSString *)title
{
    return [NSString stringWithFormat:@"Switch \"%@\" to profile \"%@\"",
        [[[self valueForKeyPath:@"options.application"] lastPathComponent] stringByDeletingPathExtension],
        [self valueForKeyPath:@"options.profile"]];
}

/* actually do the action
*/
- (void)performAction
{
    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:[NSString stringWithFormat:@""
        "tell application \"rooSwitch\" to tell document \"%@\" to tell profile \"%@\" to make active with allow quit\n",
        [[self valueForKeyPath:@"options.application"] lastPathComponent],
        [self valueForKeyPath:@"options.profile"]]];
    NSLog(@"%@", [script source]);
    [script executeAndReturnError:nil];
}

/*  perform cleanup when leaving the location or quitting the application
    this method must be defined, even if it does not do anything.
*/
- (void)cleanupAction
{
    
}

/* Returns the overridden thingy */
- (Class)optionSheetControllerClass
{
    return [SwitchActionOptionSheetController class];
} 

@end
