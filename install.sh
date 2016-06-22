# Settings
  # nginx version
  nginx=stable

# Prep ubunutu
echo "---! Set time zone"
  dpkg-reconfigure tzdata

echo
echo
echo "---! Installing some required packages (git curl libcurl3 ntp)"
  apt-get update
  apt-get -y install git unzip curl libcurl3 ntp

# Install nginx
echo
echo
echo -n "---? Install nginx [y/n]:"
read -r nginx_install
if [ "${nginx_install}" == "y" ]; then

  echo
  echo
  echo "---! Installing nginx"
  useradd -s /bin/false nginx
  add-apt-repository ppa:nginx/$nginx
  apt-get update
  apt-get -y install nginx
  chmod -R 755 /var/log/nginx
  echo "---! Installing nginx_ensite_dissite"
  cd ~
  git clone https://github.com/perusio/nginx_ensite.git
  cd ~/nginx_ensite
  sudo make install

fi

# Install PHP-FPM
echo
echo
echo -n "---? Install php5-fpm [y/n]:"
read -r php5_fpm_install
if [ "${php5_fpm_install}" == "y" ]; then

  echo
  echo
  echo "---! Installing php5-fpm"
  apt-get -y install php5 php5-fpm php5-mhash php5-mcrypt php5-curl php5-cli php5-mysql php5-gd php5-intl php5-xsl php-soap

  echo
  echo
  echo "---! Configuring php5-mcrypt"
  php5enmod mcrypt

  service php5-fpm restart

fi

# Install webmin
echo
echo
echo -n "---? Install Webmin [y/n]:"
read -r webmin_install
if [ "${webmin_install}" == "y" ]; then

  echo "---! Installing Webmin"
  echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee -a /etc/apt/sources.list
  wget -q http://www.webmin.com/jcameron-key.asc -O- | sudo apt-key add -
  apt-get update
  apt-get -y install webmin
  ufw allow 10000

fi

# Install some magento specific tools

# Restart everything
service php5-fpm restart
service nginx restart