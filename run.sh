#! /bin/sh

if [ ! -z "$API_URL" ] ; then
  sed -i "s|http://petstore.swagger.io/v2/swagger.json|$API_URL|g" index.html
  sed -i "s|http://example.com/api|$API_URL|g" index.html
fi

sed -i "s|.*validatorUrl:.*$||g" index.html

if [ ! -z "$VALIDATOR_URL" ]; then
  sed -i "s|\(url: url,.*\)|\1\n        validatorUrl: \"${VALIDATOR_URL}\",|g" index.html
else
  sed -i "s|\(url: url,.*\)|\1\n        validatorUrl: null,|g" index.html
fi

exec nginx -g 'daemon off;'