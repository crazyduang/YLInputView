//
//  YLInputView.h
//  CMInputView
//
//  Created by 卢奕霖 on 17/8/10.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLInputView : UITextView

/**
 *  占位文字
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  占位符字体大小
 */
@property (nonatomic,strong) UIFont *placeholderFont;

/**
 *  textView最大行数
 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;
/**
 *  光标颜色
 */
@property (nonatomic, strong) UIColor *cursorColor;


/**
 *  textView是否自适应高度 default is YES. 设置为NO maxNumberOfLines设置无效
 */
@property (nonatomic, assign) BOOL isAdapt;

/**
 *  textView文本和placeholder的Inset
 */
@property(nonatomic, assign) UIEdgeInsets textAndPlaceholderContainerInset;



@end
