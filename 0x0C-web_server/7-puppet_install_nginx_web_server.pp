# nginx_config.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx site
file { '/etc/nginx/sites-available/default':
  content => "
    server {
      listen 80 default_server;
      listen [::]:80 default_server;
      root /var/www/html;
      index index.html;
      server_name _;

      location /redirect_me {
        return 301 https://www.example.com;
      }

      location / {
        try_files \$uri \$uri/ =404;
      }
    }
  ",
  require => Package['nginx'],
}

# Create a simple HTML file with "Hello World!" message
file { '/var/www/html/index.html':
  content => "<!DOCTYPE html>
<html>
<head>
<title>Hello World!</title>
</head>
<body>
<h1>Hello World!</h1>
</body>
</html>",
  require => Package['nginx'],
}

# Ensure Nginx service is running and enabled
service { 'nginx':
  ensure => running,
  enable => true,
  require => File['/etc/nginx/sites-available/default', '/var/www/html/index.html'],
}
