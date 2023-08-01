# 2-puppet_custom_http_response_header.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Create a custom Nginx configuration file for the custom HTTP response header
file { '/etc/nginx/conf.d/custom_header.conf':
  content => "
    server {
      listen 80 default_server;
      listen [::]:80 default_server;
      root /var/www/html;
      index index.html;
      server_name _;

      location / {
        try_files \$uri \$uri/ =404;
      }

      # Add custom HTTP response header
      add_header X-Served-By \$hostname;
    }
  ",
  require => Package['nginx'],
}

# Remove default Nginx configuration files
file { '/etc/nginx/sites-enabled/default':
  ensure => absent,
}

# Restart Nginx service to apply the changes
service { 'nginx':
  ensure => running,
  enable => true,
  require => File['/etc/nginx/conf.d/custom_header.conf'],
}
