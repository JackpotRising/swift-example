//
//  JackpotWrapper.m
//  Unity-iPhone
//
//  Created by Prethush on 06/01/17.
//
//

#import "JackpotWrapper.h"
@import JackpotRising;
/**
 *  Interface extension to implement JackpotRising Delegate
 */
@interface JackpotWrapper() <JackpotRisingDelegate>

@end
/**
 Class that wraps JackpotRising SDK from Objective-C++
 */
@implementation JackpotWrapper
{
    JackpotRising *_sdkInstance;
}
@synthesize delegate;
/**
 *  Private method to get the SDK instance. Used internally
 *
 *  @return SDK static instance
 */
- (JackpotRising*)getSDKInstance{
    if (_sdkInstance == nil) {
        _sdkInstance = [JackpotRising sharedInstance];
    }
    return _sdkInstance;
}

/**
 *  Method to initialize sdk with client ID and secret from developer dashboard
 *
 *  @param clientID     client Id string
 *  @param clientSecret client secret string
 */
- (void)initWithClientID:(NSString*)clientID clientSecret:(NSString*)clientSecret{
    
    if (clientID == NULL) {
        clientID = @"";
    }
    
    if (clientSecret == NULL) {
        clientSecret = @"";
    }
    
    [[self getSDKInstance] initWithClientCredentials:clientID clientSecret:clientSecret];
    [self getSDKInstance].delegate = self;
}
/**
 *  Methot to point SDK to test mode. In test mode, SDK will not ask for user location
 *
 *  @param testMode Boolean status. True will point sdk to test mode.
 */
- (void)setSDKToTestMode:(BOOL)testMode{
    [[self getSDKInstance] testMode:testMode];
}
/**
 *  Method to start the SDK
 */
- (void)showSDK{
    [[self getSDKInstance] showSDK:true];
}
/**
 *  Method to submit a score to SDK once a contest starts running
 *
 *  @param score user score
 */
- (void)submitScoreToSDK:(NSInteger)score{
    [[self getSDKInstance] submitScore:score];
}
/**
 *  Method to check the contest running status
 *
 *  @return contest running status Boolean
 */
- (BOOL)isContestRunningInSDK{
    return  [[self getSDKInstance] isContestRunning];
}

#pragma mark JackpotRising Delegate methods

- (void)contestStarted:(NSDictionary *)data{
    [delegate contestStarted:data];
}

- (void)locationFecthStatus:(BOOL)status{
    [delegate locationFecthStatus:status];
}

- (void)initialPopupCancelled{
    [delegate initialPopupCancelled];
}

- (void)sdkClosed{
    [delegate sdkClosed];
}

- (void)sdkFailedToInitialize:(NSString *)message{
    [delegate sdkFailedToInitialize:message];
}
@end
