#! /bin/bash

value=./*.podspec
file=${value##*/}

echo "podspec:"  ${file}
#获取podspec 中版本号
version=`grep -m1 "s.version" ${file}|awk '{print $NF}'|sed "s/\'//g"`
echo "version:"  ${version}
#git提交
git add .
read -t 600 -p "修改内容[默认为${version}]:" diff
if [ -z ${diff} ];then  
diff=${version}
fi 
git commit -m ${diff}
git push
read -t 600 -p "版本内容[默认为${version}]:" diff
if [ -z ${diff} ];then  
diff=${version}
fi 
git tag -a ${version} -m ${diff}
git push origin ${version}
pod trunk push ${file}
