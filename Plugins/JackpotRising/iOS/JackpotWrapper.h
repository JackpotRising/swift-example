//
//  JackpotWrapper.h
//  Unity-iPhone
//
//  Created by Prethush on 06/01/17.
//
//

#import <Foundation/Foundation.h>

/**
 *  Wrapper delegate for the SDK delegate
 */
@protocol JackpotRisingWrapperDelegate <NSObject>

- (void)contestStarted:(NSDictionary *)data;
- (void)locationFecthStatus:(BOOL)status;
- (void)initialPopupCancelled;
- (void)sdkClosed;
- (void)sdkFailedToInitialize:(NSString *)message;

@end
/**
 Class that wraps JackpotRising SDK from Objective-C++
 */
@interface JackpotWrapper : NSObject

/**
 *  Variable to set SDK delegate from Wrapper class
 */
@property(nonatomic, strong)id <JackpotRisingWrapperDelegate> delegate;
/**
 *  Method to initialize sdk with client ID and secret from developer dashboard
 *
 *  @param clientID     client Id string
 *  @param clientSecret client secret string
 */
- (void)initWithClientID:(NSString*)clientID clientSecret:(NSString*)clientSecret;
/**
 *  Methot to point SDK to test mode. In test mode, SDK will not ask for user location
 *
 *  @param testMode Boolean status. True will point sdk to test mode.
 */
- (void)setSDKToTestMode:(BOOL)testMode;
/**
 *  Method to start the SDK
 */
- (void)showSDK;
/**
 *  Method to submit a score to SDK once a contest starts running
 *
 *  @param score user score
 */
- (void)submitScoreToSDK:(NSInteger)score;
/**
 *  Method to check the contest running status
 *
 *  @return contest running status Boolean
 */
- (BOOL)isContestRunningInSDK;
@end
