#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UnityAppController.h"
#import "UI/UnityView.h"
#import "UI/UnityViewControllerBase.h"
#import "JackpotWrapper.h"

@interface JRListener : NSObject <JackpotRisingWrapperDelegate>
@end

@implementation JRListener

- (void)contestStarted:(NSDictionary * _Nonnull)data{
    NSString* dicString = [data description];
    
    char* rawdata = (char*)malloc(strlen([dicString UTF8String])+1);
    strcpy(rawdata, [dicString UTF8String]);
    
    UnitySendMessage("JackpotRising", "ReceiveIOSData", rawdata);
}

- (void)locationFecthStatus:(BOOL)status{
    
}

- (void)sdkPopupCancelled{
    NSString* dicString = @"Cancelled";
    
    char* rawdata = (char*)malloc(strlen([dicString UTF8String])+1);
    strcpy(rawdata, [dicString UTF8String]);
    
    UnitySendMessage("JackpotRising", "SdkPopupCancelled", rawdata);
}

- (void) sdkFailedToInitialize:(NSString *)message{
    
}

- (void) initialPopupCancelled{
    
}

- (void)sdkClosed{
    
}

// Explicitly stored copies to ensure the data is being retained, but it still is nil when getting to SDK

NSString* CreateNSString (const char* string)
{
    if (string != nil)
        //return [[NSString alloc] initWithBytes:string length:sizeof(string) encoding:NSUTF8StringEncoding]; // Tried this as well, didn't work
        return [[[NSString alloc] initWithUTF8String: string] copy];
    else
        return [NSString stringWithUTF8String: ""];
}

// xCode to Unity native calls.
extern "C"
{
    static JackpotWrapper *instance;
    static NSString* storedClientID;
    static NSString* storedClientSecret;
    
    static char* copyOfClientID;
    static char* copyOfClientSecret;
    
    void _JPInit(const char* clientID, const char* clientSecret, BOOL isProd)
    {
        if (instance == nil){
            instance = [[JackpotWrapper alloc] init];
        }
        // C-string malloc for copy of id
        copyOfClientID = (char*)malloc(strlen(clientID)+1);
        strcpy(copyOfClientID, clientID);
        storedClientID     = CreateNSString(copyOfClientID);
        
        // C-string malloc for copy of secret
        copyOfClientSecret = (char*)malloc(strlen(clientSecret)+1);
        strcpy(copyOfClientSecret, clientSecret);
        storedClientSecret = CreateNSString(copyOfClientSecret);
        
        NSLog(@"clientid %@ ClientSecret %@", storedClientID, storedClientSecret);
        [instance initWithClientID:storedClientID clientSecret:storedClientSecret];
        instance.delegate = [JRListener alloc];
        
        [instance setSDKToTestMode: true];
    }
    
    void _JPStaging(BOOL isStaging) {
        //[[JackpotRising getInstance] setSDKToStaging:isStaging];
    }
    
    void _ShowJP()
    {
        //[[JackpotRising getInstance] showAlertForJr];
        [instance showSDK];
    }
    
    void _TestMode(BOOL mode){
        
    }
    
    void _SubmitScore(const int score)
    {
        //[[JackpotRising getInstance] submitScore:score];
        [instance submitScoreToSDK:score];
    }
    
    BOOL _IsContestStarted(){
        return [instance isContestRunningInSDK];
    }
    
}
@end
