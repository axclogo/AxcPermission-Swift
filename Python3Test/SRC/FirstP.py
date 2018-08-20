
import requests
from bs4 import BeautifulSoup,Tag,CData;
import pymysql
import  re



# 打开数据库连接-- 求出处数据库链接
db = pymysql.connect("localhost", "root", "123456", "ask_source")
# 使用 cursor() 方法创建一个游标对象 cursor
cursor = db.cursor()

for i in range(2):  # 遍历多少页
    r = requests.get('https://www.gifjia5.com/tag/%E8%80%81%E5%8F%B8%E6%9C%BA/page' + '/%d/' % (i + 1))
    r.encoding = 'utf-8'
    # 像目标url地址发送get请求，返回一个response对象
    # print(r.text) #r.text是http response的网页HTML
    # 获取所有字段
    html_doc = r.text;
    # 设置解析对象
    soup = BeautifulSoup(html_doc, 'html.parser')
    # 页内列表格式为article
    articles = soup.find_all('article')
    # 遍历
    for article in articles:

        # 获取a单元的标签
        focusArray = article.find_all('a', class_='focus')
        focus = focusArray[0]
        # 获取img单元的标签
        imgArray = focus.find_all('img')
        img = imgArray[0]
        # 获取header单元的标签
        headerArray = article.find_all('header')
        header = headerArray[0]
        #########################################
        # 获取点击链接
        hrefUrl_str = focus['href']
        # 获取图片
        img_str = img['data-src']
        # 获取tag标签
        tag_a = header.find_all('a', class_='cat')
        tag_str = tag_a[0].get_text()
        # 获取标题
        title_a = header.find_all('h2')[0].find_all('a')[0]
        title_str = title_a.get_text()
        # 图片个数
        small_i = article.find_all('small', class_='text-muted')[0]
        small_str = small_i.get_text()
        # 日期
        date = article.find_all('time')[0]
        date_str = date.get_text()
        # 用户
        user = article.find_all('span', class_='author')[0]
        user_str = user.get_text()
        # 阅读数
        read = article.find_all('span', class_='pv')[0]
        read_str = read.get_text()
        # 评论
        comments_a = article.find_all('a', class_='pc')[0]
        comments_str = comments_a.get_text()
        # 评论链接
        comments_url = comments_a['href']
        # 赞
        like = article.find_all('span', class_='pv')[1]
        like_str = like.get_text()
        # 备注
        note = article.find_all('p', class_='note')[0]
        note_str = note.get_text()

        # print('标题:',title_str,'-- 图片个数:',small_str)
        # print('归类:',tag_str)
        # print('图片:',img_str)
        # print('链接:',hrefUrl_str)
        # print('日期:',date_str,'上传者:',user_str,read_str,like_str)
        # print('内容备注:',note_str)
        # print('==========分割==========')

        sql = "INSERT INTO source_list_copy1"
        list_pram = "(title, date, cover,tag,href_url,small_count,upload_user,read_str,comments,comments_url,like_str,note)"
        sql_values = "VALUES('%s', '%s', '%s','%s', '%s', '%s','%s', '%s', '%s','%s', '%s', '%s')" % \
                     (title_str, date_str, img_str,tag_str,hrefUrl_str,small_str,user_str,read_str,comments_str,comments_url,like_str,note_str)
        sql = sql + list_pram + sql_values

        print(sql_values)

        try:
            # 执行sql语句
            cursor.execute(sql)
            # 执行sql语句
            db.commit()
        except:
            # 发生错误时回滚
            db.rollback()
            print("失败")
            break
    print('当前第%d页'%(i+1))

print('结束')

# 关闭数据库连接
db.close()
