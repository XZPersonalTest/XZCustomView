//
//  XZEnum.h
//  XZCustomView
//
//  Created by LWX on 2017/10/26.
//  Copyright © 2017年 LWX. All rights reserved.
//

#ifndef EnjoySkyLine_XZEnum_h
#define EnjoySkyLine_XZEnum_h


//*******************************************************************************
/**
 * @brief XZCustomPickerViewType类型
 */
typedef NS_OPTIONS(NSUInteger, XZCustomPickerViewType)
{
    XZCustomPickerViewTypeGradeOneComponent           = 0,/**< 0：1个组 年级 */
    XZCustomPickerViewTypeClassOneComponent           = 1 << 0,/**< 1：1个组 班级*/
    XZCustomPickerViewTypeTwoComponent                = 1 << 1,/**< 2：2个组 */
    XZCustomPickerViewTypeThreeComponent              = 1 << 2,/**< 4：3个组 */
    XZCustomPickerViewTypeStageOneComponent           = 1 << 3,/**< 1：1个组 学段*/
    XZCustomPickerViewTypeStartDateOneComponent       = 1 << 4,/**< 1：1个组 入学年份*/
    XZCustomPickerViewTypeGradeOneComponentCreatClass = 1 << 5,/* 1 个组，根据学段选择年级*/
    XZCustomPickerViewTypeTeacherSubject = 1 << 6,/* 1 个组，选择所教科目*/
    XZCustomPickerViewTypeThreeComponentTeacherSubject = 1 << 7,/* 3 个组，选择所教科目／出版社／年级*/
    XZCustomPickerViewTypeThreeComponentDate           = 1 << 8,/* 3 个组，年-月-日8*/
};


#endif
