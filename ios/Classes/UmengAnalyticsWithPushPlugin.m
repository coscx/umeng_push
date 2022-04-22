#import "UmengAnalyticsWithPushPlugin.h"
#import "UmengAnalyticsPushIos.h"
#import <UMCommon/UMCommon.h>
#import <UMCommon/MobClick.h>
#import <UMPush/UMessage.h>

FlutterMethodChannel* methodChannel;
FlutterEventChannel* eventChannel;
FlutterEventSink _eventSink;
@implementation UmengAnalyticsWithPushPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  methodChannel = [FlutterMethodChannel methodChannelWithName:@"com.auwx.plugins/umeng_analytics_with_push" binaryMessenger:[registrar messenger]];
  UmengAnalyticsWithPushPlugin* instance = [[UmengAnalyticsWithPushPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:methodChannel];

  eventChannel = [FlutterEventChannel eventChannelWithName:@"com.auwx.plugins/umeng_analytics_with_push/stream" binaryMessenger:[registrar messenger]];
  [eventChannel setStreamHandler:instance];
}

- (FlutterError*)onListenWithArguments:(id)arguments eventSink:(FlutterEventSink)eventSink {
  _eventSink = eventSink;
  return nil;
}

- (FlutterError*)onCancelWithArguments:(id)arguments {
  _eventSink = nil;
  return nil;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"initUmeng" isEqualToString:call.method]) {
      [self initUmeng:call result:result];
  } else if ([@"initialize" isEqualToString:call.method]) {
      [self initialize:call result:result];
  }else if ([@"addPushTags" isEqualToString:call.method]) {
      [self addTags:call result:result];
  }else if ([@"getPushTags" isEqualToString:call.method]) {
      [self getTags:call result:result];
  }  else if ([@"removePushTags" isEqualToString:call.method]) {
      [self deleteTags:call result:result];
  } else if ([@"addPushAlias" isEqualToString:call.method]) {
      [self addAlias:call result:result];
  } else if ([@"putPushAlias" isEqualToString:call.method]) {
      [self setAlias:call result:result];
  } else if ([@"removePushAlias" isEqualToString:call.method]) {
      [self deleteAlias:call result:result];
  } else if ([@"onPageStart" isEqualToString:call.method]) {
      [self pageStart:call result:result];
  } else if ([@"onPageEnd" isEqualToString:call.method]) {
      [self pageEnd:call result:result];
  } else if ([@"onEvent" isEqualToString:call.method]) {
      [self event:call result:result];
  } else if ([@"deviceToken" isEqualToString:call.method]) {
    [self deviceToken:call result:result];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (void)event:(FlutterMethodCall*)call result:(FlutterResult)result {

    NSString* eventId = call.arguments[@"event"];
    NSString* label = call.arguments[@"params"];
    if (label == nil) {
        [MobClick event:eventId];
    } else {
        [MobClick event:eventId label:label];
    }
}

- (void)deviceToken:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
  NSString *device_token = [userDefault stringForKey: @"push_device_token"] ;
  result(device_token);
}

- (void)pageStart:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString* pageName = [call.arguments NSString*];
  [MobClick beginLogPageView:pageName];
}

- (void)pageEnd:(FlutterMethodCall*)call result:(FlutterResult)result {
  NSString* pageName = [call.arguments  NSString*];
  [MobClick endLogPageView:pageName];
}
- (void)initialize:(FlutterMethodCall *)call result:(FlutterResult)result {
  BOOL logEnabled = [call.arguments[@"logEnabled"] boolValue];
  BOOL pushEnabled = [call.arguments[@"pushEnabled"] boolValue];
  [UmengAnalyticsPushFlutterIos iosInit:logEnabled pushEnabled:pushEnabled];
  result(@"initialize");
}
- (void)addTags:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *tags = [call.arguments NSString*];
  [UMessage addTags:tags response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
  }];
}
- (void)getTags:(FlutterMethodCall *)call result:(FlutterResult)result {
  [UMessage getTags response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
  }];
}
- (void)deleteTags:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *tags = [call.arguments NSString*];
  [UMessage deleteTags:tags response:^(id  _Nonnull responseObject, NSInteger remain, NSError * _Nonnull error) {
  }];
}

- (void)addAlias:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *alias = call.arguments[@"alias-value"];
  NSString *type = call.arguments[@"alias-type"];
  [UMessage addAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
  }];
}

- (void)setAlias:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *alias = call.arguments[@"alias-value"];
  NSString *type = call.arguments[@"alias-type"];
  [UMessage setAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
  }];
}

- (void)deleteAlias:(FlutterMethodCall *)call result:(FlutterResult)result {
  NSString *alias = call.arguments[@"alias-value"];
  NSString *type = call.arguments[@"alias-type"];
  [UMessage removeAlias:alias type:type response:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
  }];
}

- (void)initUmeng:(FlutterMethodCall *)call result:(FlutterResult)result {
  BOOL logEnabled = [call.arguments[@"logEnabled"] boolValue];
  BOOL pushEnabled = [call.arguments[@"pushEnabled"] boolValue];
  [UmengAnalyticsPushFlutterIos iosInit:logEnabled pushEnabled:pushEnabled];
}

@end
