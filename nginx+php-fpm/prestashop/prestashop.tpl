server {
    listen      %ip%:%web_port%;
    server_name %domain_idn% %alias_idn%;
    root        %docroot%;
    index       index.php index.html index.htm;
    access_log  /var/log/nginx/domains/%domain%.log combined;
    access_log  /var/log/nginx/domains/%domain%.bytes bytes;
    error_log   /var/log/nginx/domains/%domain%.error.log error;

  rewrite ^/api/?(.*)$ /webservice/dispatcher.php?url=$1 last;
  rewrite ^/([a-z0-9]+)\-([a-z0-9]+)(\-[_a-zA-Z0-9-]*)/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1-$2$3.jpg last;
  rewrite ^/([0-9]+)\-([0-9]+)/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1-$2.jpg last;
  rewrite ^/([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$1$2.jpg last;
  rewrite ^/([0-9])([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$2/$1$2$3.jpg last;
  rewrite ^/([0-9])([0-9])([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$2/$3/$1$2$3$4.jpg last;
  rewrite ^/([0-9])([0-9])([0-9])([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$2/$3/$4/$1$2$3$4$5.jpg last;
  rewrite ^/([0-9])([0-9])([0-9])([0-9])([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$2/$3/$4/$5/$1$2$3$4$5$6.jpg last;
  rewrite ^/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$2/$3/$4/$5/$6/$1$2$3$4$5$6$7.jpg last;
  rewrite ^/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$2/$3/$4/$5/$6/$7/$1$2$3$4$5$6$7$8.jpg last;
  rewrite ^/([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])([0-9])(\-[_a-zA-Z0-9-]*)?/[_a-zA-Z0-9-]*\.jpg$ /img/p/$1/$2/$3/$4/$5/$6/$7/$8/$1$2$3$4$5$6$7$8$9.jpg last;
  rewrite ^/c/([0-9]+)(\-[_a-zA-Z0-9-]*)/[_a-zA-Z0-9-]*\.jpg$ /img/c/$1$2.jpg last;
  rewrite ^/c/([a-zA-Z-]+)/[a-zA-Z0-9-]+\.jpg$ /img/c/$1.jpg last;
  rewrite ^/([0-9]+)(\-[_a-zA-Z0-9-]*)/[_a-zA-Z0-9-]*\.jpg$ /img/c/$1$2.jpg last;

  rewrite "^/([0-9]+)\-(\P{M}\p{M}*)+\.html(.*)$" /index.php?controller=product&id_product=$1$3 last;
  rewrite "^/([0-9]+)\-([a-zA-Z0-9-]*)(.*)$" /index.php?controller=category&id_category=$1$3 last;
  rewrite "^/([a-zA-Z0-9-]*)/([0-9]+)\-([a-zA-Z0-9-]*)\.html(.*)$" /index.php?controller=product&id_product=$2$4 last;
  rewrite "^/([0-9]+)__([a-zA-Z0-9-]*)(.*)$" /index.php?controller=supplier&id_supplier=$1$3 last;
  rewrite "^/([0-9]+)_([a-zA-Z0-9-]*)$" /index.php?controller=manufacturer&id_manufacturer=$1$3 last;
  rewrite "^/content/([0-9]+)\-([a-zA-Z0-9-]*)(.*)$" /index.php?controller=cms&id_cms=$1$3 last;
  rewrite "^/content/category/([0-9]+)\-([a-zA-Z0-9-]*)(.*)$" /index.php?controller=cms&id_cms_category=$1$3 last;
  rewrite "^/module/([_a-zA-Z0-9-]*)/([_a-zA-Z0-9-]*)$" /index.php?fc=module&module=$1&controller=$2 last;
  rewrite ^/articles$ /index.php?fc=module&module=smartblog&controller=category last;
  rewrite "^/articles/([0-9]+)_([_a-zA-Z0-9-]*)$" /index.php?fc=module&module=smartblog&id_post=$1&controller=details last;
  rewrite "^/articles/category/([0-9]+)_([_a-zA-Z0-9-]*)$" /index.php?fc=module&module=smartblog&id_category=$1&controller=category;
  rewrite ^/products-comparison$ /index.php?controller=products-comparison last;
  rewrite ^/page-not-found$ /index.php?controller=404 last;
  rewrite ^/address$ /index.php?controller=address last;  
  rewrite ^/addresses$ /index.php?controller=addresses last;
  rewrite ^/authentication$ /index.php?controller=authentication last;
  rewrite ^/best-sales$ /index.php?controller=best-sales last;
  rewrite ^/cart$ /index.php?controller=cart last;
  rewrite ^/contact-us$ /index.php?controller=contact-form last;
  rewrite ^/discount$ /index.php?controller=discount last;
  rewrite ^/guest-tracking$ /index.php?controller=guest-tracking last;
  rewrite ^/order-history$ /index.php?controller=history last;
  rewrite ^/identity$ /index.php?controller=identity last;
  rewrite ^/manufacturers$ /index.php?controller=manufacturer last;
  rewrite ^/my-account$ /index.php?controller=my-account last;
  rewrite ^/new-products$ /index.php?controller=new-products last;
  rewrite ^/order$ /index.php?controller=order last;
  rewrite ^/order-follow$ /index.php?controller=order-follow last;
  rewrite ^/quick-order$ /index.php?controller=order-opc last;
  rewrite ^/order-slip$ /index.php?controller=order-slip last;
  rewrite ^/password-recovery$ /index.php?controller=password last;
  rewrite ^/prices-drop$ /index.php?controller=prices-drop last;  
  rewrite ^/search$ /index.php?controller=search last;
  rewrite ^/sitemap$ /index.php?controller=sitemap last;
  rewrite ^/stores$ /index.php?controller=stores last;  
  rewrite ^/supplier$ /index.php?controller=supplier last;

    location / {

        location ~* ^.+\.(jpeg|jpg|png|gif|bmp|ico|svg|css|js)$ {
            expires     max;
        }

        location ~ [^/]\.php(/|$) {
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            if (!-f $document_root$fastcgi_script_name) {
                return  404;
            }

            fastcgi_pass    %backend_lsnr%;
            fastcgi_index   index.php;
            include         /etc/nginx/fastcgi_params;
        }
    }

    error_page  403 /error/404.html;
    error_page  404 /index.php?controller=404;
    error_page  500 502 503 504 /error/50x.html;

    location /error/ {
        alias   %home%/%user%/web/%domain%/document_errors/;
    }

    location ~* "/\.(htaccess|htpasswd)$" {
        deny    all;
        return  404;
    }

    location ~* ^/(favicon.ico|robots.txt)$ {
        access_log off;
        log_not_found off;
    }

    include     /etc/nginx/conf.d/phpmyadmin.inc*;
    include     /etc/nginx/conf.d/phppgadmin.inc*;
    include     /etc/nginx/conf.d/webmail.inc*;

    include     %home%/%user%/conf/web/nginx.%domain%.conf*;
}