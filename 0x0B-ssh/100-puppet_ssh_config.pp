# Define the user and private key path
$ssh_user = 'root'
$private_key_path = '/home/root/.ssh/school'

# Create the ~/.ssh directory if it doesn't exist
file { '/home/root/.ssh':
  ensure => directory,
  mode   => '0700',
  owner  => $ssh_user,
  group  => $ssh_user,
}

# Create the SSH client configuration file
file { '/home/root/.ssh/config':
  ensure  => present,
  content => "
    Host 212815-web-01
      HostName 54.152.59.63
      User ubuntu
      IdentityFile $private_key_path
      PasswordAuthentication no
  ",
  mode    => '0600',
  owner   => $ssh_user,
  group   => $ssh_user,
}
