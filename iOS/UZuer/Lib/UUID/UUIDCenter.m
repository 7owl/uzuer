#import "UUIDCenter.h"
#import <SSKeychain/SSKeychain.h>
#import "MD5.h"

@implementation UUIDCenter

//获取uuid
+(NSString*)uuid{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    
    NSString *resultString;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        resultString=[NSString stringWithFormat:@"iPad-%@",result];
    }
    else{
        resultString=[NSString stringWithFormat:@"iPhone-%@",result];
    }
    return resultString;
}


+(NSString *)UUID
{
    NSString *gettedUUID=[SSKeychain passwordForService:@"com.uc108.mobile.gamecenter" account:@"uuid"];//取出
    if  ([gettedUUID length]==0) {
        //不存在uuid，说明是首次使用
        gettedUUID=[self uuid];//获取uuid
        [SSKeychain setPassword:gettedUUID forService:@"com.uc108.mobile.gamecenter" account:@"uuid"];
    }
    return gettedUUID;
}

@end
