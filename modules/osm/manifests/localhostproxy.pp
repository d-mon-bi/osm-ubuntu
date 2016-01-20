class osm::localhostproxy{
   $proxycfg = "server {
        listen 8888;
        server_name localhost;
        sendfile off;
        location / {
                proxy_pass http://127.0.0.1:3000;
        }
}"

	file { '/etc/nginx/sites-available/nginx_vhost':
		content => "$proxycfg",
	}

	file {'/etc/nginx/sites-enabled/nginx_vhost': 
        	ensure => 'link', 
        	target => '/etc/nginx/sites-available/nginx_vhost',
		require => File['/etc/nginx/sites-available/nginx_vhost']; 
	}
}