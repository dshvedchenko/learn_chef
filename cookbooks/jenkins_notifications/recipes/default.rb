#
# Cookbook Name:: jenkins_notifications
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# 1. Ensure /opt/notification-endpoint created
# 2. jar copied there
# 3. rc.d file copied to /etc/init.d
# 4. service jenkins-notification-endpoint created and enabled
# 5. /var/log/jenkins-notification-endpoint created
# 6. /etc/logrotate.d/jenkins-notification-endpoint created
