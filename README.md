This is my ideal dev environment for working remotely. It also works on my ipad when it's setup and done, so that's ideal! 

Clone then 

```
cd code-server && sudo docker-compose up -d

```

When it's done, you need to go into the nginx conig to enable the reverse proxy to the code-server, gatsby, and flutter. 

First enable the code-server reverse proxy

```
cd letsencrypt/nginx/proxy_config

```

```
mv code-server.config.sample code-server.config
```

then duplicate the code-server config and update the port to match gatsby. Do the same for flutter. (this doesn't seem to work right yet, I'm trying to figure out why not)