# Solution error 400 ssl ubuntu 18.* not generate http (ssl) for domain

> wget https://raw.githubusercontent.com/serghey-rodin/vesta/master/bin/v-add-letsencrypt-domain -O /usr/local/vesta/bin/v-add-letsencrypt-domain
> wget https://raw.githubusercontent.com/serghey-rodin/vesta/master/bin/v-add-letsencrypt-user -O /usr/local/vesta/bin/v-add-letsencrypt-user
> wget https://raw.githubusercontent.com/serghey-rodin/vesta/master/bin/v-update-letsencrypt-ssl -O /usr/local/vesta/bin/v-update-letsencrypt-ssl

# Remove
> rm -fr /usr/local/vesta/bin/v-check-letsencrypt-domain
> rm -fr /usr/local/vesta/bin/v-sign-letsencrypt-csr

# Set permission
> chmod +x /usr/local/vesta/bin/v-add-letsencrypt-domain
> chmod +x /usr/local/vesta/bin/v-add-letsencrypt-user
> chmod +x /usr/local/vesta/bin/v-update-letsencrypt-ssl
