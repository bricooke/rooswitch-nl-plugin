//
//  NLAction.h
//  NetworkLocation
//
//  Created by Chris Farber on 2/7/07.
//  Copyright 2007 Chris Farber. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class NLPlugin, OptionSheetController, Location;

/**
 * Every action must be a subclass of NLAction.
 * Methods you will need to implement:
 *      +actionID, +category, +title, -performAction, -cleanupAction
 * Usually, you will also want to override:
 *      -title, -optionDefaults
 */
@interface NLAction : NSObject {
    @private
    NLPlugin * plugin;
    NSMutableDictionary * plist;
}

/**
 * Returns the ID of the action.
 * The ID must be a string, and must be unique within your plugin. If your action
 * has options, then the ID is also assumed to be the filename of the nib containing
 * your options. MUST BE OVERRIDEN.
 * @see optionSheetController
 */
+ (NSString *)actionID;
/**
 * Returns the name of the category the action will appear under.
 * MUST BE OVERRIDEN.
 */
+ (NSString *)category;

/**
 * Returns the description the user will see when adding an action.
 * MUST BE OVERRIDEN.
 * Example: "Change the volume"
 */
+ (NSString *)title;

+ (id)actionWithPlist:(NSMutableDictionary *)entry;
+ (id)newActionInLocation:(Location *)location;

- (id)initWithPlist:(NSMutableDictionary *)entry;
- (id)initNewInLocation:(Location *)location;

/**
 * Gets the NSMutableDictionary of options
 */
- (NSMutableDictionary *)options;

- (NSNumber *)enabled;
- (void)setEnabled:(NSNumber *)enabled;

/**
 * Returns the parent instance of NLPlugin.
 */
- (NLPlugin *)plugin;
- (NSString *)pluginID;

- (void)triggerTitleUpdate;

/**
 * Let NetworkLocation know if this action has options.
 * The default implementation searches for a nib file matching the action's ID,
 * and returns an NSNumber containing YES if found. You only need to override this
 * method if your nib's filename does not match +(NSString *)actionID
 * @see actionID
 */
- (NSNumber *)hasOptions;

/**
 * In special cases, when bindings prove inadequate, you will need
 * to provide controller code for your option interface. To do this, you should
 * subclass OptionSheetController and override this method to return your subclass's
 * class. The default implementation of this method returns the class
 * OptionSheetController. The class returned by this method is instantiated and used
 * as the nib's owner.
 */
- (Class)optionSheetControllerClass;

/**
 * Instantiate and return an OptionSheetController. The default implementation of this
 * method uses the class returned by optionSheetControllerClass and instantiates it
 * using +(NSString)actionID as the nib name.
 * @see optionSheetControllerClass
 * @see actionID
 */
- (OptionSheetController *)optionSheetController;

/**
 * Return an NSDictionary containing default options. When the action is instantiated
 * as a new action, this method is invoked to get the defaults
 */
- (NSDictionary *)optionDefaults;

/**
 * This method returns a string describing the action for the user. It is displayed
 * in the list of actions in a location in the preferences. The default implementation
 * simply invokes +title
 */
- (NSString *)title;

/**
 * performAction is invoked by NetworkLocation when it wants the action to do its
 * stuff.
 * MUST BE OVERRIDEN.
 */
- (void)performAction;

/**
 * cleanupAction is invoked by NetworkLocation when it wants the action to clean up
 * after itself. In other words, if you want to undo anything done by your action,
 * such as set the system volume back to the value it was before performAction
 * changed it, this is the place to do it.
 * MUST BE OVERRIDEN.
 */
- (void)cleanupAction;

@end
