#!/bin/bash

DATABASE="spm"
MYSQL_USER="usky"
MYSQL_USER_PASSWORD="usky@123456"
MYSQL_ROOT_PASSWORD="usky@456321"
MYSQL_REPL_USER='repl_user'
MYSQL_REPL_USER_PASSWORD='usky@123456'
WORKSPACE_DIR=/usr/local/spm-api
MISC_DIR=$WORKSPACE_DIR/misc
INSTALL_DIR=$MISC_DIR/install
PACKAGES_DIR=/tmp/packages
WORKSPACE_DIR=/usr/local/spm-api
LOG_DIR=$WORKSPACE_DIR/var/log
log_file="$LOG_DIR/spm-api-install.log"

function install_mysql()
{
    # install mysql
    echo "Installing mysql..."
    mysql_version=`mysql --version 2>>$log_file`
    if [[ $mysql_version =~ "5.7" ]]; then
        echo "mysql $mysql_version already installed."
        return 0
    else
        chattr -i /etc/group
        chattr -i /etc/gshadow
        chattr -i /etc/passwd
        chattr -i /etc/shadow
        cd $PACKAGES_DIR
        [ -f $PACKAGES_DIR/mysql57-community-release-el7-8.noarch.rpm ] || wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm --no-check-certificate
        rpm -ivh mysql57-community-release-el7-8.noarch.rpm
        yum -y install mysql-community-server mysql-devel python-devel
    fi

    # start mysqld
    systemctl start mysqld
    if [ $? -eq 0 ]; then
        echo "mysqld is successfully started"
        # install mysql-python dependency
    else
        echo "mysqld failed to start."
        exit 1
    fi
    systemctl enable mysqld
    systemctl daemon-reload

    # update default root password for mysql
    default_password=`grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}'`
    # echo "skip-grant-tables" >> /etc/my.cnf
    # service mysqld restart
    # sleep 3s
    mysql -uroot -p$default_password --connect-expired-password -e "set global validate_password_policy=0;" >& /dev/null
    mysql -uroot -p$default_password --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >& /dev/null
    # ALTER USER 'root'@'localhost' IDENTIFIED BY 'usky@456321';
    # SET PASSWORD FOR 'root'@'localhost' = PASSWORD('usky@456321');
    if [ $? -eq 0 ];then
        echo "Default root password $default_password is successfully reset."
        # install mysql-python dependency
    else
        echo "Failed to reset default root password."
        exit
    fi

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "create user 'usky'@'localhost' identified by '$MYSQL_USER_PASSWORD';grant all privileges on *.* to 'usky'@'localhost';" >& /dev/null

    if [ $? -eq 0 ]; then
        echo "Created db user usky successfully."
        # install mysql-python dependency
    else
        echo "Failed to create db user usky."
        exit
    fi

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "create database $DATABASE charset=utf8;" >& /dev/null

}


function uninstall_mysql()
{
    # uninstall mysql
    command_test=`rpm -qa | grep mysql`
    for line in $command_test; do
        yum remove -y $line
    done
    yum  -y remove mysql-client mysql-server mysql-common mysql-devel >& /dev/null
    rm -rf /var/lib/mysql* /etc/my.cnf /var/log/mysql*
}

#uninstall_mysql
install_mysql