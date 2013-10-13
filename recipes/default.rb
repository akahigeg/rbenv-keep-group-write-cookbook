#
# Cookbook Name:: rbenv-force-owner
# Recipe:: default
#

include_recipe "yum::repoforge"
include_recipe "incron::default"
include_recipe "rbenv::default"
include_recipe "rbenv-install-rubies"

versions_dir = "#{node[:rbenv][:root]}/versions"
versions = [node[:rbenv_install_rubies][:global_version]] + node[:rbenv_install_rubies][:other_versions]

keep_owner_command = "chown -R #{node[:rbenv][:user]}:#{node[:rbenv][:group]} #{versions_dir}"
keep_group_write_command = "chmod g+w -R #{versions_dir}"

# incron
mask_for_gem = "IN_CREATE,IN_DELETE"

versions.each do |v|
  if v =~ /^2.0/
    watch_dir = "#{versions_dir}/#{v}/lib/ruby/gems/2.0.0/gems"
  elsif v =~ /^1.9/
    watch_dir = "#{versions_dir}/#{v}/lib/ruby/gems/1.9.1/gems"
  else
    # "only support 1.9.x and 2.0.0"
    next
  end

  incron_d "keep_rbenv_versions_owner_for_#{v}" do
    path watch_dir
    mask mask_for_gem
    command keep_owner_command
  end

  incron_d "keep_rbenv_versions_group_write_for_#{v}" do
    path watch_dir
    mask mask_for_gem
    command keep_group_write_command
  end
end

# initialize owner and permission
execute "exec_keep_owner_command" do
  command keep_owner_command
end

execute "exec_keep_group_write_command" do
  command keep_group_write_command
end
