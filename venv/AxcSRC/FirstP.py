#coding=utf-8


import AxcPythonTools
import TestFile


# 分割用的
def segmentation():
    print "\n ###################### \n"

print "==== Hello, Python! ====";
segmentation()

print '打印数组'
firstArray = ['banana', 'apple', 'mango'];
print firstArray;
segmentation()

print '遍历数组'
for fruit in firstArray:
    print 'cuuu :', fruit
segmentation()

firstDictionary = {'Alice': '2341', 'Beth': '9102', 'Cecil': '3258'}
print '打印字典'
print firstDictionary;
segmentation()

print '遍历字典'
for (key,value) in firstDictionary.items() :
    print 'KEY:',key,'---','VALUE:',value;
segmentation()

print '字符串处理'
TestFile.StringTestFile.PrintStringTest();
# AxcPythonTools.AxcRegularClass.function()



