%hook ClientSideInjectionDetailsVC 

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    textField.text = @"111111";
    %orig;
//    [NSThread sleepForTimeInterval:2];
//    textField.text = @"222222";
//    %orig;
//    [NSThread sleepForTimeInterval:2];
    textField.text = @"<script>alert(1)</script>";
    
    return %orig;
//    [NSThread sleepForTimeInterval:2];
    textField.text = @"333333";
    %orig;
    
    return NO;
}

%end // end hook