

import requests
from bs4 import BeautifulSoup,Tag,CData;
import pymysql
import  re

# 打开数据库连接
db = pymysql.connect("localhost", "root", "ZX532432339ZXzx", "python3_test")
# 使用 cursor() 方法创建一个游标对象 cursor
cursor = db.cursor()

for i in range(20):
    print('开始')

    r = requests.get(
        'https://www.qidian.com/free/all?chanId=21&subCateId=73&size=1&orderId=3&vip=hidden&update=2&style=1&pageSize=20&siteid=1&pubflag=0&hiddenField=1&page=%d' % (i+130))
    # 像目标url地址发送get请求，返回一个response对象
    # print(r.text) #r.text是http response的网页HTML
    print('连接Html完成')
    html_doc = r.text;

    soup = BeautifulSoup(html_doc, 'html.parser', from_encoding='utf-8')

    print('数据库存储')

    links = soup.find_all('a')
    # p_text = soup.find_all("a", class_="go-sub-type")
    # print(p_text)


    is_author = False
    count = 0
    name_text = ''
    url_text = ''
    author_text = ''
    for link in links:

        url_text = url = link['href']
        text = link.get_text()

        m = re.search('//book.qidian.com/info',url)
        author = re.search('//my.qidian.com/author',url)
        name_length = text.strip()==''

        # 开始记录数据
        start_flag = m and name_length

        if (author or m ) :
            if (not start_flag):
                # SQL 插入语句

                if (not is_author): # 第一次
                    is_author = True
                    name_text = text
                else:
                    is_author = False
                    author_text = text
                    print(name_text,author_text,url_text)
                    sql = "INSERT INTO qidian_web(book_name, book_url, author) VALUES('%s', '%s', '%s')" % (
                    name_text, url_text, author_text)

                    try:
                        # 执行sql语句
                        cursor.execute(sql)
                        # 执行sql语句
                        db.commit()
                    except:
                        # 发生错误时回滚
                        db.rollback()
                        print("失败")

                count = count+1;

                # if (count == 2):
                    # print(name_text,author_text,url_text)




print('结束')






# 关闭数据库连接
db.close()
