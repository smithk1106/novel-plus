## MacOS

### Prepare
- homebrewでのmavenのインストール
参考： https://qiita.com/toranoko92114/items/0ce47d3a63147ce3df00
```sh
brew install maven
mvn -v
```

### Install Mysql & Redis
```sh
docker compose build
docker compose up
docker compose down

# 参考
docker compose ps --services
docker compose exec (サービス名) /bin/bash
# docker build ./doc/sql/Dockerfile -t mysql8:mysql8
# docker image ls
# docker run -it {IMAGE ID}
# docker container ls

mysql -h localhost -pDemo_20250808 --default-character-set=utf8 novel_plus

mysql -h localhost -pDemo_20250808 --default-character-set=utf8 novel_plus < novel_plus.sql
mysqldump -h localhost -pDemo_20250808 --no-data novel_plus > /var/lib/mysql/novel_plus_20250815.sql
mysqldump -h localhost -pDemo_20250808 novel_plus > /var/lib/mysql/novel_plus_20250818.sql
```

**SQL**
```sql
alter table chapter drop `order`;
alter table chapter add `order1` BIGINT(20) NOT NULL DEFAULT 0 COMMENT '章节顺序';
select id, book_id, title, word_count, order1 from chapter order by book_id, order1;
```

### Install Maven
- homebrewでのmavenのインストール
参考： https://qiita.com/toranoko92114/items/0ce47d3a63147ce3df00
```sh
brew install maven
mvn -v
```

### Install Java
- Download JDK
    - URL: https://www.oracle.com/jp/java/technologies/downloads/#jdk21-mac


### 源码打包
```sh
mvn clean package -Dmaven.test.skip=true
mvn package -Dmaven.test.skip=true
```

### 爬虫程序安装（novel-crawl）
1. 复制文件
```sh
cp novel-crawl/target/build/novel-crawl.zip /服务器主页目录/
cd /服务器主页目录/
unzip novel-crawl.zip
```

2. 修改配置文件
    - config/shardingsphere-jdbc.yml：配置 MySQL
    - config/application.yml：配置 Redis 和管理员账号

3. 如有需要，配置代理 IP
  https://www.xxyopen.com/2022/07/18/doc/novel-plus/proxy.html

4. 启动爬虫
```sh
bin/novel-crawl.sh start
bin/novel-crawl.sh status
#bin/novel-crawl.sh stop
#bin/novel-crawl.sh restart
```

### 后台程序安装（novel-admin）
1. 将打包生成的 novel-admin.zip（位于 novel-admin/target/build/）复制到 novel-admin 的服务器安装目录（如 /www/wwwroot/novel-plus/novel-admin）并解压
```sh
unzip novel-admin.zip
```

2. 修改配置文件：
    - config/shardingsphere-jdbc.yml：配置 MySQL
    - config/application.yml：配置 Redis

3. 启动后台程序：
```sh
bin/novel-admin.sh start
```

4. 浏览器访问
  http://<服务器IP>:8088
  登录用户: admin
  密码: novel_admin -> d656b543bd0f964cd32132fd472d6637
  登录用户2: manager / novel_manager -> 1acb54599592260f4d99610a3616fcb4


### 前台程序安装（novel-front）
1. 将打包生成的 novel-front.zip（位于 novel-front/target/build/）复制到 novel-front 的服务器安装目录（如 /www/wwwroot/novel-plus/novel-front）并解压
```sh
unzip novel-front.zip
```

2. 修改配置文件
    - config/shardingsphere-jdbc.yml：配置 MySQL
    - config/application.yml：配置 Redis 和图片保存目录

3. 启动前台程序
```sh
bin/novel-front.sh start
```

4. 浏览器访问
  http://<服务器IP>:8085


### Tools
1. phpMyAdmin 5.2
Url: http://wdllstudio.lan:9981/phpMyAdmin/
ID: manager / SupAdmin_202508

2. SQLs
- Command
```sh
mysql -h localhost -pDemo_20250808 --default-character-set=utf8 novel_plus
mysqldump -h localhost -pDemo_20250808 --no-data novel_plus > /share/novel_plus_schema.sql
mysqldump -h localhost -pDemo_20250808 novel_plus > /share/novel_plus_20250830.sql
```

- SQL
```sql
-- Add DB Users
create user 'novel_manager'@'%' identified by 'Demo_20251010';
grant all on novel_plus.* to 'novel_manager'@'%';

use novel_plus;

-- Modify table
alter table `book` add `book_name_alias` varchar(200) NOT NULL COMMENT '小说别名' after `book_name`;
alter table `book` add `crawl_book_url` varchar(250) DEFAULT NULL COMMENT '抓取的源站小说URL' after `crawl_book_id`;

-- Delete book and related data
delete from book_content0 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content1 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content2 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content3 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content4 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content5 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content6 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content7 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content8 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_content9 where index_id in (select id from book_index where book_id='1957084299154362411');
delete from book_index where book_id='1957084299154362411';
delete from book where id='1957084299154362411';
delete from book_comment_reply where comment_id in (select id from book_comment where book_id='1957084299154362411');
delete from book_comment where book_id='1957084299154362411';
delete from user_read_history where book_id='1957084299154362411';
delete from user_bookshelf where book_id='1957084299154362411';

-- Clear tables
truncate table news;
truncate table sys_dict;
truncate table sys_gen_columns;

-- Count words
select book_id, sum(word_count) as book_word_count from book_index group by book_id order by book_id;
```
