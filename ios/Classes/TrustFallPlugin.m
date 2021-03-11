#import "TrustFallPlugin.h"
#import "DTTJailbreakDetection.h"

@implementation TrustFallPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"trust_fall"
            binaryMessenger:[registrar messenger]];
  TrustFallPlugin* instance = [[TrustFallPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"isJailBroken" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self isJailBroken]]);
  } else if ([@"canMockLocation" isEqualToString:call.method]) {
    //For now we have returned if device is Jail Broken or if it's not real device. There is no
    //strong detection of Mock location in iOS
    result([NSNumber numberWithBool:([self isJailBroken] || ![self isRealDevice])]);
  } else if ([@"isRealDevice" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self isRealDevice]]);
  } else if ([@"getSignatureKeyHash" isEqualToString:call.method]) {
    result([self keyHash]);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (BOOL)isJailBroken{
    return [DTTJailbreakDetection isJailbroken];
}

- (BOOL) isRealDevice{
    return !TARGET_OS_SIMULATOR;
}

- (NSString *)keyHash {
    NSString* bundleContainerPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"_CodeSignature/CodeResources"];
    NSData* data = [[NSFileManager defaultManager] contentsAtPath:bundleContainerPath];
    NSPropertyListFormat format = NSPropertyListXMLFormat_v1_0;
    NSDictionary* dict = [NSPropertyListSerialization propertyListWithData:data
                                                                   options:NSPropertyListMutableContainersAndLeaves
                                                                    format:&format
                                                                     error:nil];
    NSData* val = [[dict objectForKey:@"files"] valueForKey:@"Frameworks/Flutter.framework/Info.plist"];
    return [val base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
