#!/bin/bash

##############################
#检测RPM安装方式的Apache主配置文件中的Timeout配置项信息
##############################

updatedb

ENV_PATH=../env_config

#判断是否存在Make编译安装的Apahce主配置文件，没有的话退出本脚本

locate   "httpd.conf"  |  grep  -i  "\/conf\/httpd\.conf$" |  grep  -v  "\/etc\/httpd\/conf\/httpd.conf" |  grep  -vi "\/doc"  |  grep  -vi  "\/share\/"  |  grep -vi  "ln*mp*"  

[ `echo  $?` == 0 ] ||  exit 1

#查看编译安装的apache的主配置文件的路径

CONF=`locate   "httpd.conf"  |  grep  -i  "\/conf\/httpd\.conf$" |  grep  -v  "\/etc\/httpd\/conf\/httpd.conf" |  grep  -vi "\/doc"  |  grep  -vi  "\/share\/"  |  grep -vi  "ln*mp*"  `

VALUE=`grep  -v  "^#"  $CONF |  grep  -i "Timeout " |  awk  '{print  $2}'`

#查看"Apache_Make_Timeout"所在的行号

LINE_NUM=`grep  -n  "Apache_Make_Timeout"   $ENV_PATH  |  awk -F:  '{print $1}'`

#在"Apache_Make_Timeout"行之后添加一行

sed  -ie  "/Apache_Make_Timeout/a \'Apache_Make_Timeout\':\'$VALUE\'" $ENV_PATH

#删除原来的"Apache_Make_Timeout"行

sed -i  ''$LINE_NUM'd'   $ENV_PATH



