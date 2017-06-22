//
//  WBIMBundle.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"

@interface WBIMBundle : WBIMBaseModel

@property (nonatomic, copy) NSString *authorization;
@property (nonatomic, assign) NSInteger language;
@property (nonatomic, copy) NSString *userAgent;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *wm;
@property (nonatomic, assign) NSInteger pageDataVersion;
@property (nonatomic, assign) BOOL keyNeedSSL;//是否支持SSL

@end
