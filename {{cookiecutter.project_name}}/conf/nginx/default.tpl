upstream uwsgi_servers {
    server uwsgi:9527;
    server uwsgi:9528;
}

server {
    listen       80;
    server_name ${SERVER_NAME};

    location ^~ /robots.txt {
        return 200 "User-agent: *\nDisallow: /";
    }

    location / {
        include /etc/nginx/uwsgi_params;
        uwsgi_pass uwsgi_servers;
        uwsgi_read_timeout 300;
        index index.html index.html;
        client_max_body_size 4g;
    }

    #error_page  404              /404.html;

    # redirect server error pages to the static page /50x.html
    #
    error_page   500 502 503 504  /50x.html;
    location = /50x.html {
        root   /usr/share/nginx/html;
    }

    # deny access to .htaccess files, if Apache's document root
    # concurs with nginx's one
    
    location ~ /\.ht {
        deny  all;
    }
}
