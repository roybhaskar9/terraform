sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo echo 'deb https://pkg.jenkins.io/debian-stable binary/' | tee -a /etc/apt/sources.list
sudo apt-get update
sudo apt-get install jenkins
sudo service jenkins start
echo "Jenkins Login username is admin and password is:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
