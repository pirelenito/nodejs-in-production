bash 'swap' do
  user 'root'
  cwd '/tmp'
  not_if 'swapon -s | grep /swapfile'
  code <<-EOH
    dd if=/dev/zero of=/swapfile bs=1024 count=2048k
    chown root:root /swapfile
    chmod 0600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    echo '/swapfile       none    swap    sw    0    0' >> /etc/fstab
  EOH
end
