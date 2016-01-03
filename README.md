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
cp ./build/dante-server\*deb .
</pre>
# 制作镜像
<pre>
sudo docker build -t dante .
</pre>
