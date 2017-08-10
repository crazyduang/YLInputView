//
//  YLInputView.m
//  CMInputView
//
//  Created by 卢奕霖 on 17/8/10.
//  Copyright © 2017年 CrabMan. All rights reserved.
//

#import "YLInputView.h"

@interface YLInputView ()

/**
 *  UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
 */
@property (nonatomic, weak) UITextView *placeholderView;

/**
 *  文字高度
 */
@property (nonatomic, assign) NSInteger textH;

/**
 *  文字最大高度
 */
@property (nonatomic, assign) NSInteger maxTextH;
/**
 *  文本框最小高度
 */
@property (nonatomic, assign) NSInteger minTextH;


@end

@implementation YLInputView

- (UITextView *)placeholderView
{
    if (!_placeholderView ) {
        UITextView *placeholderView = [[UITextView alloc] initWithFrame:self.bounds];
        _placeholderView = placeholderView;
        //防止textView输入时跳动问题
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.font =  self.font;
        _placeholderView.textColor = self.textColor;
        _placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderView];
        _placeholderView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *views = @{@"placeholderView":self.placeholderView};
        NSString *vfl_H = @"H:|-0-[placeholderView]-0-|";
        NSString *vfl_W = @"V:|-0-[placeholderView]-0-|";
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_W options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl_H options:0 metrics:nil views:views]];
        
    }
    return _placeholderView;
}

/**
 *  根据最大的行数计算textView的最大高度
 *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
 *
 */
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    _maxNumberOfLines = maxNumberOfLines;
    /*
     round：如果参数是小数，则求本身的四舍五入。
     ceil：如果参数是小数，则求最小的整数但不小于本身.
     floor：如果参数是小数，则求最大的整数但不大于本身.
     Example:如何值是3.4的话，则-- round 3.000000  -- ceil 4.000000 -- floor 3.00000
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
}

/**
 *  通过设置placeholder设置私有属性placeholderView中的textColor
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderView.textColor = placeholderColor;
}
/**
 *  通过设置placeholder设置私有属性placeholderView中的textColor
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    
    self.placeholderView.text = placeholder;
}
/**
 *  通过设置_placeholderFont设置私有属性placeholderView中的Font
 */
- (void)setPlaceholderFont:(UIFont *)placeholderFont {
    
    _placeholderFont = placeholderFont;
    
    self.placeholderView.font = placeholderFont;
}
/**
 *  光标颜色 默认为蓝色
 */
- (void)setCursorColor:(UIColor *)cursorColor{
    _cursorColor = cursorColor;
    self.tintColor = cursorColor;
}

/**
 *  textView是否自适应高度 default is YES. 设置为NO maxNumberOfLines设置无效
 */
- (void)setIsAdapt:(BOOL)isAdapt{
    _isAdapt = isAdapt;
}
/**
 *  textView文本和placeholder的Inset
 */
- (void)setTextAndPlaceholderContainerInset:(UIEdgeInsets)textAndPlaceholderContainerInset{
    _textAndPlaceholderContainerInset = textAndPlaceholderContainerInset;
    self.textContainerInset = textAndPlaceholderContainerInset;
    self.placeholderView.textContainerInset = textAndPlaceholderContainerInset;
}


/** 初始化方法，用于从代码中载入的类实例 */
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}
/** 初始化方法，用于从代码中载入的类实例 */
- (instancetype)init{
    if (self = [super init]) {
        [self setup];
    }
    return self;
}
/** 初始化方法，用于从xib文件中载入的类实例 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self)
    {
        [self setup];
    }
    return self;
}
/** 设置一些默认初始属性值*/
- (void)setup
{
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
    self.font = [UIFont systemFontOfSize:14];
    //实时监听textView值得改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    _isAdapt = YES;
    _minTextH = self.bounds.size.height;
}



- (void)textDidChange
{
    // 根据文字内容决定placeholderView是否隐藏
    self.placeholderView.hidden = self.text.length > 0;
    
    if (self.isAdapt) {
        NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
        
        NSLog(@"%ld == %ld  == %ld", height, _maxTextH, _minTextH);
        if (_textH != height) { // 高度不一样，就改变了高度
            // 当高度大于最大高度时，需要滚动
            self.scrollEnabled = height > _maxTextH && _maxTextH > 0;
            
            _textH = height;
            
            //当不可以滚动（即 <= 最大高度）时，传值改变textView高度
            if (self.scrollEnabled == NO) {
                CGRect frame = self.frame;
                frame.size.height = height > _minTextH ? height : _minTextH;
                self.frame = frame;
                [self.superview layoutIfNeeded];
                self.placeholderView.frame = self.bounds;
                
            }
        }
    } else {
        self.scrollEnabled = YES;
    }
}





- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
