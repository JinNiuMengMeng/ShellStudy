#!/bin/bash
PACKAGES_DIR=/tmp/packages

function install_pip()
{
	echo "Installing pip tool..."
	[ -f $PACKAGES_DIR/get-pip.py ] || wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py
	$PACKAGES_DIR/Python-2.7.15/bin/python $PACKAGES_DIR/get-pip.py
	if [ $? -eq 0 ]; then
	     echo "pip upgrade complete"
	else
	     echo "pip upgrade failed"
	fi
	rm -rf /usr/bin/pip; ln -s /usr/local/python2.7.15/bin/pip2.7 /usr/bin/pip
	echo "Pip tool is successfully installed in /usr/bin/pip."
}

function install_python()
{
    # install python dependencies
    echo "Installing python dependencies openssl openssl-devel zlib-devel gcc..."
    yum install openssl openssl-devel zlib-devel gcc -y

    [ -f $PACKAGES_DIR/Python-2.7.15.tgz ] || wget http://softrepo.uskycdn.com/third_party/python/Python-2.7.15.tgz --no-check-certificate
    rm -rf $PACKAGES_DIR/Python-2.7.15; cd $PACKAGES_DIR && tar xf Python-2.7.15.tgz && cd Python-2.7.15

    echo "python 2.7.15 will be installed in /usr/local/Python2.7.15"
    mkdir -p /usr/local/python2.7.15

    # add zlib compiling option
    sed -i '467c zlib zlibmodule.c -I$(prefix)/include -L$(exec_prefix)/lib -lz' Modules/Setup.dist

    # sed '467s/^#//g' Modules/Setup.dist
    echo "Compile and install python2.7.15..."
    ./configure --prefix=/usr/local/python2.7.15
    make && make install
    if [ $? -eq 0 ]; then
         echo "Python2.7.15 upgrade complete. Please run command 'python -V"
    else
         echo "Python2.7.15 upgrade failed!"
    fi

    echo "Creating new python link, updating yum and urlgrabber-ext-down..."
    rm -rf /usr/bin/python; ln -s /usr/local/python2.7.15/bin/python /usr/bin/python
    rm -rf /usr/bin/python2.7.5; ln -s /usr/bin/python2.7 /usr/bin/python2.7.5

    install_pip
    s=`grep '#!' /usr/bin/yum`
    if [[ ! $s =~ "python2.7.5" ]]; then
        sed -i -r "1s/python.+?[0-9]$/python2.7.5/g" /usr/bin/yum
    fi
    s=`grep '#!' /usr/libexec/urlgrabber-ext-down`
    if [[ ! $s =~ "python2.7.5" ]]; then
        sed -i -r '1s/python.+?[0-9]$/python2.7.5/g' /usr/libexec/urlgrabber-ext-down
    fi

    export PATH=$PATH:/usr/local/python2.7.15/bin
    echo "Python 2.7.15 is successfully installed."
}

function check_python()
{
    python_version=`python -V 2>&1`
    if [[ $python_version =~ "Python 2.7.15" ]]; then
        echo "python version is already 2.7.15, no need to upgrade!"
    else
        echo "The current version is not 2.7 and is being updated..."
        if [ -f /usr/local/python2.7.15/bin/python ]; then
            rm -rf /usr/bin/python; ln -s /usr/local/python2.7.15/bin/python /usr/bin/python
            rm -rf /usr/bin/python2.7.5; ln -s /usr/bin/python2.7 /usr/bin/python2.7.5
	        echo "Python update success..."
        else
            return 0
        fi
    fi
    return 1
}

if check_python; then
    install_python
fi
