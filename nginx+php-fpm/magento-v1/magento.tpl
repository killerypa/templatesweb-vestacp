# Template Updated At 2019-04-17

upstream php_backend_%domain_idn%_%web_port% {
	server %backend_lsnr%;
	#server %backend_lsnr% backup;
}

server {
    listen      %ip%:%web_port%;
    server_name %domain_idn% %alias_idn%;
    root        %docroot%;
    index       index.html index.php index.htm;
    access_log  /var/log/nginx/domains/%domain%.log combined;
    access_log  /var/log/nginx/domains/%domain%.bytes bytes;
    error_log   /var/log/nginx/domains/%domain%.error.log error;

    #ssl			on;
    #ssl_certificate      %ssl_pem%;
    #ssl_certificate_key  %ssl_key%;

    #rewrite ^/(.*\.php)(/)(.*)$ /$1?file=/$3 last;
    rewrite ^/(.*\.php)(/)(.*)$ /$1$3 last;

    include     %home%/%user%/conf/web/nginx.%domain_idn%.conf_letsencrypt*;

    location = /favicon.ico {
        log_not_found off;
        access_log off;
    }

    location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
    }

    # Very rarely should these ever be accessed outside of your lan
    location ~* \.(txt|log)$ {
        allow 192.168.0.0/16;
        deny all;
    }

    location /downloader {
		if ($request_uri = '') {
			return http://www.urbandictionary.com/define.php?term=smartass;
		}
    }

	location ~ \..*/.*\.php$ {
		return 403;
	}

	client_max_body_size 500M;

    if ($http_user_agent ~* (netcrawl|npbot|malicious|apache-httpclient|JoeDog|Siege|foo|bar|apache)) {
        return 403;
    }

    ##
    # Rewrite for versioned CSS+JS via filemtime
    ##
	rewrite ^(.+)\.(\d+)\.(css|js)$ $1.$3 last;

	location ~* ^.+\.(css|js)$ {
        expires 31536000s;
        access_log off;
        log_not_found off;
        add_header Pragma public;
        add_header Cache-Control "max-age=31536000, public";
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
    }

	##
    # Aggressive caching for static files
    # If you alter static files often, please use 
    # add_header Cache-Control "max-age=31536000, public, must-revalidate, proxy-revalidate";
    ##
    
	location ~* \.(asf|asx|wax|wmv|wmx|avi|bmp|class|divx|doc|docx|eot|exe|gif|gz|gzip|ico|jpg|jpeg|jpe|mdb|mid|midi|mov|qt|mp3|m4a|mp4|m4v|mpeg|mpg|mpe|mpp|odb|odc|odf|odg|odp|ods|odt|ogg|ogv|otf|pdf|png|pot|pps|ppt|pptx|ra|ram|svg|svgz|swf|tar|t?gz|tif|tiff|ttf|wav|webm|wma|woff|wri|xla|xls|xlsx|xlt|xlw|zip)$ {
        expires 31536000s;
        access_log off;
        log_not_found off;
        add_header 'Access-Control-Allow-Origin' '*';
        add_header 'Access-Control-Allow-Methods' 'GET, POST, OPTIONS';
        add_header 'Access-Control-Allow-Headers' 'DNT,X-CustomHeader,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type';
        add_header Pragma public;
        add_header Cache-Control "max-age=31536000, public";
    }
  
    ## These locations would be hidden by .htaccess normally
    
	location ^~ /app/                { deny all; }
    location ^~ /includes/           { deny all; }
    location ^~ /lib/                { deny all; }
    location ^~ /import/             { deny all; }
    location ^~ /media/downloadable/ { deny all; }
    location ^~ /pkginfo/            { deny all; }
    location ^~ /report/config.xml   { deny all; }
    location ^~ /var/                { deny all; }
  
	## Allow admins only to view export folder
	
	location /var/export/ { 
        auth_basic           "Restricted";			## Message shown in login window
        auth_basic_user_file htpasswd;				## See /etc/nginx/htpassword
        autoindex            on;
    }
  
    # Block access to "hidden" files and directories whose names begin with a
    # period. This includes directories used by version control systems such
    # as Subversion or Git to store control files.
    
	location ~ (^|/)\. {
        return 403;
    }

	## Forward paths like /js/index.php/x.js to relevant handler

	location ~ .php/ { 
        rewrite ^(.*.php)/ $1 last;
    }
	
	## Magento uses a common front handler
	location @handler { 
		rewrite / /index.php;
	}

    location / {
        try_files /maintenance.html index.html $uri $uri/ @handler; ## If missing pass the URI to Magento's front handler
        expires 30d;												## Assume all files are cachable

		location ~* ^.+\.(jpeg|jpg|png|gif|bmp|ico|svg|css|js)$ {
            expires     max;
        }

        location ~ [^/]\.php(/|$) {
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            if (!-f $document_root$fastcgi_script_name) {
                return  404;
            }

            #fastcgi_pass    %backend_lsnr%;
            fastcgi_pass    php_backend_%domain_idn%_%web_port%;
            fastcgi_index   index.php;
            fastcgi_param	SCRIPT_FILENAME $request_filename;
            fastcgi_intercept_errors on;
            include         /etc/nginx/fastcgi_params;
        }
    }

    error_page  403 /error/404.html;
    error_page  404 /error/404.html;
    error_page  500 502 503 504 /error/50x.html;

    location /error/ {
        alias   %home%/%user%/web/%domain%/document_errors/;
    }

    location ~* "/\.(htaccess|htpasswd)$" {
        deny    all;
        return  404;
    }

    location /vstats/ {
        alias   %home%/%user%/web/%domain%/stats/;
        include %home%/%user%/conf/web/%domain%.auth*;
    }

    include     /etc/nginx/conf.d/phpmyadmin.inc*;
    include     /etc/nginx/conf.d/phppgadmin.inc*;
    include     /etc/nginx/conf.d/webmail.inc*;

    include     %home%/%user%/conf/web/nginx.%domain_idn%.conf*;
}
