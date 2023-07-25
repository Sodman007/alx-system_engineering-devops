# Define a custom type for managing the SSH client configuration
define ssh_config_entry(
  $ensure = present,
  $key,
  $value,
) {
  file_line { "ssh_config_${title}":
    path  => '/etc/ssh/ssh_config', # Adjust the path if your SSH client configuration file is located elsewhere.
    line  => "${key} ${value}",
    match => "^\\s*${key}\\s+.*",
  }
}

# Configure SSH to use the private key ~/.ssh/school
ssh_config_entry { 'identity_file':
  key   => 'IdentityFile',
  value => '~/.ssh/school',
}

# Disable password authentication
ssh_config_entry { 'password_authentication':
  key   => 'PasswordAuthentication',
  value => 'no',
}
