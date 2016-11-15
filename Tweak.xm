#import <objc/runtime.h>
#import <substrate.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

BOOL (*original_textFieldShouldReturn)(id self, SEL _cmd, UITextField *textField);
//static IMP original_textFieldShouldReturn;

BOOL replaced_textFieldShouldReturn(id self, SEL _cmd, UITextField *textField){
    NSLog(@"text: %@ ", textField.text);
    textField.text = @"hahaha";
//    UITextField * newTextField = [[UITextField alloc]init];
//    newTextField.text = @"111111";
    (*original_textFieldShouldReturn)(self,_cmd, textField);
    NSLog(@"text: %@",textField.text);
    return NO;
//    return original_textFieldShouldReturn(self, _cmd, textField);
}

%ctor
{
    int numClasses = objc_getClassList(NULL, 0);
    
    Class* list = (Class*)malloc(sizeof(Class) * numClasses);
    objc_getClassList(list, numClasses);    
    
    for (int i = 0; i < numClasses; i++)
    {
        //&&[[list[i] description] isEqualToString:@"ClientSideInjectionDetailsVC"]

        if (class_conformsToProtocol(list[i], @protocol(UITextFieldDelegate)) && 
            class_getInstanceMethod(list[i], @selector(textFieldShouldReturn:)) )
        {
            NSLog(@" textField :%@",list[i]);
            MSHookMessageEx(list[i], @selector(textFieldShouldReturn:), 
                            (IMP)&replaced_textFieldShouldReturn, 
                            (IMP*)&original_textFieldShouldReturn);
        }
    }
    
    free(list); 
}

