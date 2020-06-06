# Cookbook Name:: sqpc_packages
# Recipe:: default
#
# Chef recipe to remove + install packages
# This assumes a RHEL/CentOS host...

# This is a trick to make it faster
installed_packages = `yum list installed`.split("\n").map{|line| line.split(".").first}
install_packages = ['sqpc_packages']['install']
remove_packages = ['sqpc_packages']['remove']

# Remove packages
remove_packages.each do |rpkg|
  if installed_packages.include?("#{rpkg}")
    package "#{rpkg}" do
      action :remove
    end
  end
end

# Install packages
install_packages.each do |ipkg,version|
  if "#{version}" == "latest" || "#{version}" == "upgrade"
    package "#{ipkg}" do
      action :upgrade
    end
  elsif version.nil? || version.empty?
    package "#{ipkg}" do
      action :install
    end
  else
    package "#{ipkg}" do
      action :install
      version "#{version}"
    end
  end
end

# EOF
