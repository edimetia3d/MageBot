#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#include Utils.ahk

global screen_ratio:=A_ScreenWidth/3840 ; Assume we are using 4K 16:9 display

^!u::
    MyLog("ExitApp")
    ExitApp
return

^!t::AutoLoginAndAFK()

AutoLoginAndAFK(){
    global screen_ratio
    Loop{
        battlenet_id:=WinExist("ahk_exe Battle.net.exe")
        if !battlenet_id{
            MsgBox, Battlenet not open;
            MyLog("BattleNet checking failed")
            return
        }
        MyLog("BattleNet checking passed")
        
        if (IsWowOpened()=0){
            MyLog("Wow not running, re-openning")
            WinRestore, ahk_id %battlenet_id%
            WinActivate, ahk_id %battlenet_id%
            WinMaximize , ahk_id %battlenet_id%
            Sleep, 5000
            
            MouseClick, left, MyMul(772,screen_ratio), MyMul(1948,screen_ratio),1,100 ; //Click Battle net start
            MyLog("Start wow clicked")
            Sleep 20000
            
            if (IsWowOpened() = 0){
                MyLog("Wow still not running, retry")
                continue
            }
            
            ActiveWowWindow()
            
            MyLog("Character login clicked")
            MouseClick, left, MyMul(1917,screen_ratio), MyMul(1977,screen_ratio),1,100 ; //Click Login        
            Sleep 20000    
        }
        MyLog("Wow running, go to afkloop")
        StartAFKLoop()
        MyLog("afk loop ended")
        }
}

StartAFKLoop(){
    counter:=0
    ActiveWowWindow()
    ResetCmdStr()
    SendCmd("/run SetBinding(""CTRL-8"",""MACRO Update_WF_Macro"")SaveBindings(2)")
    SendCmd("/run SetBinding(""CTRL-9"",""MACRO Make_Water"")SaveBindings(2)")
    SendCmd("/run SetBinding(""CTRL-0"",""MACRO Make_Food"")SaveBindings(2)")
    SendCmd("/tradeDispenser toggle") ; toggle on
    MyLog("Init IPC done")
    Loop{
        ActiveWowWindow()
        
        if (AreWeConnected()=0){
            MyLog("Connection Checking failed, quit")
            Process, Close, WowClassic.exe
            Sleep 10000
            return 
        }		
        
        if( Mod(counter,30) = 0 ){
            Send, {Space}
            Sleep 1000
            SendCmd("/stand")
            Send, ^8 ; update water make macro
            Sleep 1000
            Send, ^9 ; make water
            Sleep 4000
            Send, ^0 ; make food
            Sleep 4000
            SendCmd("/use 魔法晶水")
            SendCmd("/use 魔法甜面包")
            MyLog("New food done")
        }
        
        if( Mod(counter,600) = 0 ){
            PostNoticeString()
        }
        
        ProcessIPCCmd()
        
        SendCmd("/run AcceptTrade()")
        Sleep 1000
        counter:=counter+1
    }
}

AreWeConnected(){
    global screen_ratio
    if (IsWowOpened() = 1){
        ActiveWowWindow()
        ; if (MySearchImgAndClick("connection.png") = 1){
        ;     return 1
        ; }
        return 1        
    }
    return 0
}

ActiveWowWindow(){
    wow_id:=WinExist("ahk_exe WowClassic.exe")
    WinRestore, ahk_id %wow_id%
    WinActivate, ahk_id %wow_id%
}

IsWowOpened(){
    if WinExist("ahk_exe WowClassic.exe"){
        return 1
    }
    return 0
}

ResetCmdStr(){
    SendCmd("/run setglobal(""my_cmd_str"",""default_none"")")
}

GetCmdStr(){
    clipboard:="default_none"
    SendCmd("/run local LibCopyPaste = LibStub(""LibCopyPaste-1.0"");LibCopyPaste:Copy(""SunZi"", my_cmd_str)")
    Sleep 500
    Send, ^c
    Sleep 500
    Send, {Esc}
    cmd_str:=clipboard
    return  %cmd_str%
}

SendCmd(cmd_str){
    clipboard := cmd_str
    Send, {Enter}
    Sleep 100
    Send, ^v
    Sleep 100
    Send, {Enter}
    
}
    
PutItemToWindow(item_name){
    cmd_str := "/run local cc=0;for i=0,4 do for x=1,GetContainerNumSlots(i) do y=GetContainerItemLink(i,x) if y then if (GetItemInfo(y)) == '" item_name "' then UseContainerItem(i,x);cc=cc+1;if cc>=3 then return end end end end end"
    SendCmd(cmd_str)
}
    
DestoryAllItem(item_name){
    cmd_str := "/run for i=0,4 do for x=1,GetContainerNumSlots(i) do y=GetContainerItemLink(i,x) if y then if (GetItemInfo(y)) == '" item_name "' then PickupContainerItem(i,x); DeleteCursorItem() end end end end"
    SendCmd(cmd_str)
}

MakeOneBatchFood(levlel_str){
    water_cast:=""
    food_cast:=""
    water_name:=""
    food_name:=""
    GetCastName(levlel_str,water_cast,food_cast)
    GetFoodName(levlel_str,water_name,food_name)
    SendCmd("/stand")
    SendCmd("/cast " water_cast)
    Sleep 4000
    SendCmd("/cast " food_cast)
    Sleep 4000
    PutItemToWindow(water_name)
    PutItemToWindow(food_name)
}
    
DestoryRemainedItem(levlel_str){
    water_name:=""
    food_name:=""
    GetFoodName(levlel_str,water_name,food_name)
    DestoryAllItem(water_name)
    if (food_name != "魔法甜面包"){
        DestoryAllItem(food_name)
    }
}
    
TryMakeCustomFood(levlel_str){

    water_cast:=""
    food_cast:=""
    GetCastName(levlel_str,water_cast,food_cast)
    if(water_cast = "null"){
        SendCmd("/p 参数错误")
        return
    }
    SendCmd("/run CancelTrade()")
    SendCmd("/p 请10秒内交易我,然后等待我提示时再确认交易")
    SendCmd("/tradeDispenser toggle")
    Sleep 10000

    MakeOneBatchFood(levlel_str)
    MakeOneBatchFood(levlel_str)
    MakeOneBatchFood(levlel_str)
    
    Sleep 500
    SendCmd("/run AcceptTrade()")
    SendCmd("/p 定制食物完成,请立刻确认交易,仅等待10秒")
    Sleep 10000
    DestoryRemainedItem(levlel_str)
    SendCmd("/tradeDispenser toggle")
}

TryToOpenPortal(cmd_str){
    SendCmd("/run SendChatMessage(""剩余""..((GetItemCount(17032)))..""个传送门符文"",""PARTY"")")
    SendCmd("/stand")
    Switch cmd_str{
        Case "c铁门":
            SendCmd("/cast 传送门：铁炉堡")
        Case "c暴风门":
            SendCmd("/cast 传送门：暴风城")
        Case "c精灵门":
            SendCmd("/cast 传送门：达纳苏斯")
        Default:
            SendCmd("/p 未识别指令")
            return
    }
    Sleep 11000
}

ProcessIPCCmd(){
    cmd_str:=GetCmdStr()
    if (cmd_str = "default_none"){
        return
    }
    SendCmd("/p 指令已收到")
    if (InStr(cmd_str,"定制")){
        TryMakeCustomFood(cmd_str)
    }
    if (InStr(cmd_str,"门")){
        TryToOpenPortal(cmd_str)
    }
    if (InStr(cmd_str,"chelp")){
        PostHelpString()
    }
    ResetCmdStr()
    SendCmd("/p 指令已完成")
}

PostNoticeString(){
    SendCmd("/g 公会法师上线了,密我暗号进组")
}

PostHelpString(){
    SendCmd("/p 开门:请在小队频道打 c铁门 c精灵门 c暴风门, 之后等我开门即可")
    SendCmd("/p 吃喝:请在小队频道打 c定制-5 c定制-15 c定制-25 c定制-35 c定制-45 选择你要的等级")
    SendCmd("/p 请等我提示 指令已完成时 再输入新的指令")
}

GetCastName(level,ByRef water_cast,ByRef food_cast){
    Switch level
    {
        Case "c定制-45":
            water_cast:= "造水术(等级 6)"
            food_cast:= ""
        Case "c定制-35":
            water_cast:= "造水术(等级 5)"
            food_cast:= "造食术(等级 5)"
        Case "c定制-25":
            water_cast:= "造水术(等级 4)"
            food_cast:= "造食术(等级 4)"
        Case "c定制-15":
            water_cast:= "造水术(等级 3)"
            food_cast:= "造食术(等级 3)"
        Case "c定制-5":
            water_cast:= "造水术(等级 2)"
            food_cast:= "造食术(等级 2)"
        Default:
            water_cast:= "null"
            food_cast:= "null"
    }
}
    
GetFoodName(level,ByRef water_name,ByRef food_name){
    Switch level{
    Case "c定制-45":
        water_name:= "魔法苏打水"
        food_name:= "魔法甜面包"
    Case "c定制-35":
        water_name:= "魔法矿泉水"
        food_name:= "魔法酵母"
    Case "c定制-25":
        water_name:= "魔法泉水"
        food_name:= "魔法粗面包"
    Case "c定制-15":
        water_name:= "魔法纯净水"
        food_name:= "魔法黑面包"
    Case "c定制-5":
        water_name:= "魔法淡水"
        food_name:= "魔法面包"
    Default:
        water_name:= "null"
        food_name:= "null"
    }
}
