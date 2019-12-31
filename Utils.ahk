global start_date:=A_Now

MyMul(x,y){
    ret:=x * y
    return ret
}

MySearchImgAndClick(img_name,click:=0){
    ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %img_name%
    if (ErrorLevel = 0){
        if (%click%=1){
            MouseClick, left, %FoundX%, %FoundY%,1,100
        }
        return 1
    }
    return 0
}

MyHoldPress(one_button){
    Random, presstime , 200, 800
    Send {%one_button% down}
    Sleep presstime
    Send {%one_button% up}
}

MyLog(str){
    global start_date
    FileAppend, [%A_Hour%:%A_Min%:%A_Sec%]: %str%.`n, log_%start_date%.txt
}