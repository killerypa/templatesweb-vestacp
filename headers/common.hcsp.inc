# By default is suposed that your site is serving all its content whitout 3rd party 
# services
# The basic template is
# add_header Content-Security-Policy "default-src * 'self' 'unsafe-inline' 'unsafe-eval' 'nonce-*' 'sha256-' about: data: blob:;" always;
add_header Content-Security-Policy "default-src 'self';" always;

