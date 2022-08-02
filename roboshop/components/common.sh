#!/bin/bash


## validating the root user

User_id=$(id -u) ## to validiate its as root user 

if [ $User_id -ne 0 ] ; then
    echo -e "\e[31m You need to run it as a root user \e[0m"
    exit 1
fi

## fuction to check if the execution of command is sucessfull
stat(){
    if [ $1 -eq 0 ] ; then
    echo -e "\e[32m SUCCESS \e[0m"
else
    echo -e "\e[31m FAILURE \e[0m"
fi
}


## installing nodejs function

NODEJS() {
    echo -n "Configuring nodejs Repo: "
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $LOGFILE
    stat $?

    echo -n "Installing nodejs: "
    yum install nodejs -y &>> LOGFILE
    stat $?
}

## user creation function
## creating user(roboshop) if it doesnot exists only if it doesnot exists 
CREATE_USER(){
    echo -n "Creating the $USER user: "
    id $USER &>> $LOGFILE || useradd $USER
    stat $?
}

## downloading the repo component function
DOWNLOAD_EXTRACT(){
    echo -n "Downloading the $COMPONENT Repo: "
    curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>> $LOGFILE
    stat $?

    ## if the file exists ain re run it will trow an error 
    echo -n "Performing cleanup: "
    cd /home/$USER && rm -rf $COMPONENT
    stat $?

    echo -n "Extracting $COMPONENT : "
    cd /home/roboshop
    unzip -o /tmp/$COMPONENT.zip &>> $LOGFILE
    mv $COMPONENT-main $COMPONENT && chown -R  $USER:$USER $COMPONENT    ### chown USER:GROUP FILE changing the ownership to robosho from root
    cd /home/roboshop/$COMPONENT
    stat $?
}

### npm install function
NPM_INSTALL() {
    echo -n "Installing $COMPONENT: "
    npm install &>> $LOGFILE
    stat $?
}

### configuring the dns / ips in services
CONFIG_SERVICE(){
    ### # Update MONGO_DNSNAME with MongoDB Server IP
    echo -n "configuring the $COMPONENT: "
    sed -i -e 's/MONGO_DNSNAME/mongodb.robooutlet.internal/' systemd.service
    sed -i -e 's/REDIS_ENDPOINT/redis.robooutlet.internal/' -e 's/MONGO_ENDPOINT/mongodb.robooutlet.internal/' systemd.service
    sed -i -e 's/REDIS_ENDPOINT/redis.robooutlet.internal/' -e 's/CATALOGUE_ENDPOINT/catalogue.robooutlet.internal/' systemd.service
    sed -i -e 's/CARTENDPOINT/cart.robooutlet.internal/' -e 's/DBHOST/mysql.robooutlet.internal/' systemd.service
    sed -i -e 's/CARTHOST/cart.robooutlet.internal/' -e 's/USERHOST/user.robooutlet.internal/' -e 's/AMQPHOST/rabbitmq.robooutlet.internal/' systemd.service
    mv /home/roboshop/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service
    stat $?
}

### starting the service 
STARTING_SERV(){
    echo -n "Starting $COMPONENT service: "
    systemctl daemon-reload &>> $LOGFILE
    systemctl restart $COMPONENT &>> $LOGFILE
    systemctl enable $COMPONENT &>> $LOGFILE
    stat $?

    systemctl status $COMPONENT -l
}


MAVEN() {
   
    echo -n "Installing maven: "
    yum install maven -y &>> $LOGFILE
    stat $?
}

MVN_INSTALL(){
    echo -n "Installing $COMPONENT: "
    mvn clean package &>> $LOGFILE
    mv target/$COMPONENT-1.0.jar $COMPONENT.jar
    stat $?

}

PYTHON_INST(){
    echo -n "Install python 3: "
    yum install python36 gcc python3-devel -y &>> $LOGFILE
    stat $?
}

PAYMENT_INST(){
    echo -n "Installing $COMPONENT: "
    cd /home/roboshop/payment 
    pip3 install -r requirements.txt &>> $LOGFILE
    stat $?

}
