#!/bin/bash

for ((i=0;i<8;i++))
do
        tput sc; tput civis                     # 记录光标位置,及隐藏光标
        tput blink; tput setf $i                # 文本闪烁,更改文本颜色
        echo -ne $(date +'%Y-%m-%d %H:%M:%S')   # 显示时间
        sleep 1
        tput rc                                 # 恢复光标到记录位置
done

tput el; tput cnorm   
