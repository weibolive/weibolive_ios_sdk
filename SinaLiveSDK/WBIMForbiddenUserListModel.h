//
//  WBIMForbiddenUserListModel.h
//  SinaLiveSDK
//
//  Created by songxiangwu on 2016/7/7.
//  Copyright © 2016年 atom. All rights reserved.
//

#import "WBIMBaseModel.h"

@interface WBIMForbiddenUserListModel : WBIMBaseModel

@property (nonatomic, strong) NSArray *members; //WBIMUser类型数组，只包含uid，nickname，avatar，level，silenceTime

@end
