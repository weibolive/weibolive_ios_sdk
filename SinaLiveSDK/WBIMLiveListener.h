//
//  WBIMLiveListener.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBIMPushMessageModel, WBIMJoinRoomModel;

@protocol WBIMLiveListener <NSObject>

@optional
- (void)didPushConnectionConnect;
- (void)didPushConnectionDisconnect:(NSInteger)errCode errMsg:(NSString *)errMsg;
@required
- (void)onNewMessage:(WBIMPushMessageModel *)msg requestId:(NSString *)requestId errCode:(NSInteger)errCode errMsg:(NSString *)errMsg;

@end
