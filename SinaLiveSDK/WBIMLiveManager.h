//
//  WBIMLiveManager.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBIMLiveListener.h"
#import "WBIMBaseRequest.h"
#import "WBIMBundle.h"
#import "WBIMUser.h"
#import "WBIMJoinRoomModel.h"
#import "WBIMRoomUserListModel.h"
#import "WBIMForbiddenUserListModel.h"
#import "WBIMPushMessageModel.h"
#import "WBIMPlaybackModel.h"
#import "WBIMSendGiftModel.h"
#import "WBIMSendMessageModel.h"

@interface WBIMLiveManager : NSObject

+ (instancetype)sharedInstance;
- (void)registerWithBundle:(WBIMBundle *)bundle user:(WBIMUser *)user;
- (void)test_configHost:(NSString *)host port:(uint16_t)port;
- (void)updateUser:(WBIMUser *)user;
- (void)changeUser:(WBIMUser *)user bundle:(WBIMBundle *)bundle;
- (void)addListener:(id<WBIMLiveListener>)listener;
- (void)removeListener:(id<WBIMLiveListener>)listener;
- (BOOL)isPushConnectionAlive;
- (NSString *)currentSDKVersion;

- (void)joinLiveRoom:(WBIMJoinRoomRequest *)request succ:(void (^)(NSString *requestId, WBIMJoinRoomModel *response))succ fail:(void (^)(NSString *requestId, NSInteger code, NSString *msg))fail;
- (void)exitLiveRoom:(WBIMExitRoomRequest *)request succ:(void (^)(NSString *requestId))succ fail:(void (^)(NSString *requestId, NSInteger code, NSString *msg))fail;
@end






