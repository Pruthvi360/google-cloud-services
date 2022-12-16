sudo vim /etc/hosts          > copy and paste below hosts

127.0.0.1 localhost

10.182.0.3 ansible-controller.example.com ansible-local-host-1
10.182.0.4 ansible-local-host-1.example.com ansible-local-host-1
10.182.0.2 ansible-local-host-2.example.com ansible-local-host-2
34.125.87.128 ansible-controller.example.com ansible-controller
34.125.243.114 ansible-local-host-1.example.com ansible-local-host-1
34.125.16.79 ansible-local-host-2.example.com ansible-local-host-2
34.125.87.128 ansible-controller.example.com ansible-controller

To cache the key and verify have ssh access

ssh ansible-controller
ssh ansible-local-host-1
ssh ansible-local-host-2

To set default config_path 

ansible-config init --disabled -t all > ansible.cfg

vim ansible.cfg

[defaults]

# some basic default values...

#inventory      = /etc/ansible/hosts
#library        = /usr/share/my_modules/
#module_utils   = /usr/share/my_module_utils/
#remote_tmp     = ~/.ansible/tmp
#local_tmp      = ~/.ansible/tmp
#plugin_filters_cfg = /etc/ansible/plugin_filters.yml
#forks          = 5
#poll_interval  = 15
#sudo_user      = root
#ask_sudo_pass = True
#ask_pass      = True
#transport      = smart
#remote_port    = 22
#module_lang    = C
#module_set_locale = False
#gathering = implicit
#gather_subset = all
# gather_timeout = 10
# inject_facts_as_vars = True
#roles_path    = /etc/ansible/roles
#host_key_checking = False
#stdout_callback = skippy
#callback_whitelist = timer, mail
#task_includes_static = False
#handler_includes_static = False
#error_on_missing_handler = True
#sudo_exe = sudo
#sudo_flags = -H -S -n
#timeout = 10
#remote_user = root
#log_path = /var/log/ansible.log
#module_name = command
#executable = /bin/sh
#hash_behaviour = replace
#private_role_vars = yes
#jinja2_extensions = jinja2.ext.do,jinja2.ext.i18n
#private_key_file = /path/to/file
#vault_password_file = /path/to/vault_password_file
#ansible_managed = Ansible managed
#display_skipped_hosts = True
#display_args_to_stdout = False
#error_on_undefined_vars = False
#system_warnings = True
#deprecation_warnings = True
# command_warnings = False


#action_plugins     = /usr/share/ansible/plugins/action
#become_plugins     = /usr/share/ansible/plugins/become
#cache_plugins      = /usr/share/ansible/plugins/cache
#callback_plugins   = /usr/share/ansible/plugins/callback
#connection_plugins = /usr/share/ansible/plugins/connection
#lookup_plugins     = /usr/share/ansible/plugins/lookup
#inventory_plugins  = /usr/share/ansible/plugins/inventory
#vars_plugins       = /usr/share/ansible/plugins/vars
#filter_plugins     = /usr/share/ansible/plugins/filter
#test_plugins       = /usr/share/ansible/plugins/test
#terminal_plugins   = /usr/share/ansible/plugins/terminal
#strategy_plugins   = /usr/share/ansible/plugins/strategy


#strategy = free
#bin_ansible_callbacks = False
#nocows = 1
#cow_selection = default
#cow_selection = random
#nocolor = 1
#fact_caching = memory
#fact_caching_connection=/tmp
#retry_files_enabled = False
#retry_files_save_path = ~/.ansible-retry
#no_log = False
#no_target_syslog = False
#allow_world_readable_tmpfiles = False
#var_compression_level = 9
#module_compression = 'ZIP_DEFLATED'
#max_diff_size = 1048576
#merge_multiple_cli_flags = True
#show_custom_stats = True
#inventory_ignore_extensions = ~, .orig, .bak, .ini, .cfg, .retry, .pyc, .pyo
#network_group_modules=eos, nxos, ios, iosxr, junos, vyos
#allow_unsafe_lookups = False
#any_errors_fatal = False


[inventory]
# enable inventory plugins, default: 'host_list', 'script', 'auto', 'yaml', 'ini', 'toml'
#enable_plugins = host_list, virtualbox, yaml, constructed

#ignore_extensions = .pyc, .pyo, .swp, .bak, ~, .rpm, .md, .txt, ~, .orig, .ini, .cfg, .retry
#ignore_patterns=
#unparsed_is_failed=False


[privilege_escalation]
#become=True
#become_method=sudo
#become_user=root
#become_ask_pass=False


[paramiko_connection]
#record_host_keys=False
#pty=False
#look_for_keys = False
#host_key_auto_add = True


[connection]

# Example:
# control_path_dir = /tmp/.ansible/cp
#control_path_dir = ~/.ansible/cp

#
# Example:
# control_path = %(directory)s/%%h-%%r
#control_path =

#pipelining = False

#   * smart = try sftp and then try scp [default]
#   * True = use scp only
#   * False = use sftp only
#scp_if_ssh = smart

#   * sftp  = use sftp to transfer files
#   * scp   = use scp to transfer files
#   * piped = use 'dd' over SSH to transfer files
#   * smart = try sftp, scp, and piped, in that order [default]
#transfer_method = smart

#sftp_batch_mode = False

#usetty = True

#retries = 3

[persistent_connection]

#connect_timeout = 30

#command_timeout = 30

[accelerate]
#accelerate_port = 5099
#accelerate_timeout = 30
#accelerate_connect_timeout = 5.0
#accelerate_daemon_timeout = 30
#accelerate_multi_key = yes

[selinux]

#libvirt_lxc_noseclabel = yes

[colors]
#highlight = white
#verbose = blue
#warn = bright purple
#error = red
#debug = dark gray
#deprecate = purple
#skip = cyan
#unreachable = red
#ok = green
#changed = yellow
#diff_add = green
#diff_remove = red
#diff_lines = cyan


[diff]

# always = no
# context = 3

vim inventory

ansible-local-host-1
ansbile-local-host-2
ansible-controller


