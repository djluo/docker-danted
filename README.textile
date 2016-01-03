使用ubuntu的源码包重新编译一下用到debian下

# 制作deb安装包
## 编译环境
<pre>
sudo docker build -t dante-build -f Dockerfile.build .
</pre>
## 正式编译
<pre>
sudo docker run -ti --rm  \
     -v $PWD/build:/build \
     -w /build  dante-build -f Dockerfile.build
</pre>
# 复制deb文件
<pre>
cp ./build/dante-server\*deb /path/to/localhost/
</pre>
# 制作镜像
<pre>
sudo docker build -t dante .
</pre>
# 受限帐号:
<pre>
sudo /usr/sbin/useradd -s /sbin/nologin -d /var/empty/danted danted
</pre>
# 开启：
<pre>
sudo docker run -d 127.0.0.1:8080:8080 \
     -e "TZ=Asia/Shanghai"  \
     -e "User_Id=${id -u danted}"   \
     -v ${current_dir}/logs/:/logs/ \
     -v ${current_dir}/conf/:/etc/danted/ \
     --name proxy danted
</pre>
# 添加用户:
<pre>
sudo docker exec -ti proxy add-user user1 123456
</pre>
# 测试:
<pre>
curl -U user1:123456 --socks5 127.0.0.1:8080 baidu.com
</pre>
