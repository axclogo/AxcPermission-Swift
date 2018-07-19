#coding=utf-8

# 分割用的
def segmentation():
    print "\n ###################### \n"


def PrintStringTest():
    firstString = 'Python'
    print '遍历打印字符串'
    # 说明是个数组，可以直接通过下标取值
    for letter in firstString:
        print 'currun :', letter
    segmentation()

    print '字符串常规处理'
    print '根据下标截取某一段:',firstString[1:4]
    print '设置为开头大写:','axc5324'.capitalize()
    print '获取字符串长度:',len('asdasd123748912374890akldjfh')
    print '将字符全转换小写','AXCLOGO-axclogo'.lower()
    print '将字符全转换大写','axclogo'.upper()
    print '大小写互转:','AXCLOGO-axclogo'.swapcase()
    print '把 将字符串中的 str1 替换成 str2,如果 max 指定，则替换不超过 max 次:','axc5324123123'.replace('5324', 'logo' )
    segmentation()

    print '字符串切割成数组'
    cutString = 'AxcLogo is Programmer. His GitHub:https://github.com/axclogo He released the library: AxcAE_TabBar、AxcAEKit、AxcUIKit'
    charArray = cutString.split('is')
    print '单个字符切割',charArray;

    import re
    print '多个字符切割',re.split('is| |Axc',cutString);
    print '数组组合成字符串'
    print 'is'.join(charArray)
    segmentation()
