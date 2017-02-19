# Install Tomcat 8

# Create a tomcat system user
useradd -m -r -s /bin/bash tomcat

# Download Tomcat
wget http://www.trieuvan.com/apache/tomcat/tomcat-8/v8.5.11/bin/apache-tomcat-8.5.11.tar.gz 

tar -xvzf /home/sbadmin/apache-tomcat-8.5.11.tar.gz -C /opt
rm -f /home/sbadmin/apache-tomcat-8.5.11.tar.gz

ln -s /opt/apache-tomcat-8.5.11 /opt/tomcat
chown -hR tomcat:tomcat /opt/tomcat /opt/apache-tomcat-8.5.11
chmod 775 /opt/tomcat/webapps

# Set up tomcat service
cat <<EOF > /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat8
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat

Environment=CATALINA_PID=/opt/tomcat/tomcat8.pid
Environment=TOMCAT_JAVA_HOME=/usr/bin/java
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment=CATALINA_OPTS=
Environment="JAVA_OPTS=-Dfile.encoding=UTF-8 -Dnet.sf.ehcache.skipUpdateCheck=true -XX:+UseConcMarkSweepGC -XX:+CMSClassUnloadingEnabled -XX:+UseParNewGC -XX:MaxPermSize=128m -Xms512m -Xmx1024m"

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

[Install]
WantedBy=multi-user.target
EOF

cat /etc/systemd/system/tomcat.service

# Enable tomcat to be started on boot
systemctl daemon-reload
systemctl restart tomcat
systemctl enable tomcat
