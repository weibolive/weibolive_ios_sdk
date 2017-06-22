//
//  WBIMPlaybackModel.h
//  SinaLiveSDK
//
//  Created by lizhi7 on 2016/11/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"
#import "WBIMPushMessageModel.h"

@interface WBIMPlaybackModel : WBIMBaseModel
@property (nonatomic, assign) long long startOffset; //开始时间偏移量，包含该秒消息
@property (nonatomic, assign) long long endOffset; //结束时间偏移量，包含该秒消息
@property (nonatomic, assign) long long segmentSize; //每个分段的大小
@property (nonatomic, strong) NSArray *messageList; //消息列表
@end


@interface WBIMPlaybackOffsetModel : WBIMBaseModel
@property (nonatomic, assign) long long offset; //时间偏移量
@property (nonatomic, strong) NSArray *offsetMessages;//同一时间下的消息数组
@end

@interface WBIMPlaybackMessage : WBIMBaseModel
@property (nonatomic, assign) WBIMMsgType type; //消息类型
@property (nonatomic, assign) long long messageId; //消息ID
@property (nonatomic, strong) WBIMUser *senderInfo; //发送方用户信息
@property (nonatomic, copy) NSString *content; //消息内容
@property (nonatomic, copy) NSString *extension; //消息扩展字段
@property (nonatomic, assign) long long timestamp; //时间戳
@property (nonatomic, assign) WBIMMsgFormmat formmat; //消息格式，分为普通消息和弹幕

@end
