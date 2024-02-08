<!-- # this is apparently needed to connect mariaDB https://kinsta.com/blog/mariadb-docker/ -->

<!-- listen = 127.0.0.1:3306
listen.backlog = -1
pm = dynamic
pm.max_children = 9
pm.start_servers = 3
pm.min_spare_servers = 2
pm.max_spare_servers = 4
pm.max_requests = 10000
request_slowlog_timeout = 5s
slowlog = /var/log/$pool.log.slow
request_terminate_timeout = 300s
rlimit_files = 131072
rlimit_core = unlimited
catch_workers_output = yes
env[HOSTNAME] = $HOSTNAME
env[TMP] = /tmp
env[TMPDIR] = /tmp
env[TEMP] = /tmp -->




define('DB_NAME', 'wordpress');

define('DB_USER', 'wordpress’);

define('DB_PASSWORD', '');

define('DB_HOST', 'http://localhost:3306’);