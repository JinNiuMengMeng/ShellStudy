#!/bin/sh

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

function install_mysql()
{
	# install mysql
	output "Installing mysql..."
	mysql_version=`mysql --version 2>>$log_file`
	if [[ $mysql_version =~ "5.7" ]]; then
		output "mysql $mysql_version already installed."
		return 0
	else
		chattr -i /etc/group
		chattr -i /etc/gshadow
		chattr -i /etc/passwd
		chattr -i /etc/shadow
		cd $PACKAGES_DIR
		[ -f $PACKAGES_DIR/mysql57-community-release-el7-8.noarch.rpm ] || wget http://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm --no-check-certificate
		rpm -ivh mysql57-community-release-el7-8.noarch.rpm
		yum -y install mysql-community-server
		yum -y install mysql-devel python-devel
	fi

	# start mysqld
	systemctl start mysqld
    if [ $? -eq 0 ]; then
            output "mysqld is successfully started"
            # install mysql-python dependency
    else
            output "mysqld failed to start."
            exit 1
    fi
    systemctl enable mysqld
    systemctl daemon-reload

	# update default root password for mysql
    default_password=`grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}'`
    # output "skip-grant-tables" >> /etc/my.cnf
    # service mysqld restart
    # sleep 3s
    mysql -uroot -p$default_password --connect-expired-password -e "set global validate_password_policy=0;"
    mysql -uroot -p$default_password --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
    # ALTER USER 'root'@'localhost' IDENTIFIED BY 'usky@456321';
    # SET PASSWORD FOR 'root'@'localhost' = PASSWORD('usky@456321');
    if [ $? -eq 0 ];then
        output "Default root password $default_password is successfully reset."
        # install mysql-python dependency
    else
        output "Failed to reset default root password."
        exit
    fi

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "create user 'usky'@'localhost' identified by '$MYSQL_USER_PASSWORD';grant all privileges on *.* to 'usky'@'localhost';"

    if [ $? -eq 0 ];then
            output "Created db user usky successfully."
            # install mysql-python dependency
    else
            output "Failed to create db user usky."
            exit
    fi

    mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "create database $DATABASE charset=utf8;"

}

install_mysql