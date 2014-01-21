#! /bin/bash
############################
# by:simapple
# website:http://www.simapple.com
# version:0.1
############################

files_url=(https://pypi.python.org/packages/source/s/setuptools/setuptools-2.1.tar.gz#md5=2044725530450d0517393882dc4b7508 https://pypi.python.org/packages/source/p/pip/pip-1.5.tar.gz)
files=(setuptools pip)

packages_dir=/data/packages/temp/

if [ ! -d $packages_dir ] 
then
    mkdir -p $packages_dir
fi

downfile(){
    count=0
    for i in ${files_url[*]}
    do
	    wget $i -O $packages_dir${files[$count]}".tgz"
	    tar xvzf $packages_dir${files[$count]}".tgz" -C $packages_dir
	    count=$(($count + 1))
    done
}

installfile(){
    for z in $(ls $packages_dir)
    do
        pacname=$(tar tf $packages_dir/$z | head -1 | cut -d / -f 1)
        tar xvzf $packages_dir$z -C $packages_dir
	    python  $packages_dir$pacname/setup.py install
    done
}
downfile
installfile
echo -e "#############"
echo -e "#python   ok#"
echo -e "#############"
