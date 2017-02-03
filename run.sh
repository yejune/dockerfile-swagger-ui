#! /bin/sh

if [ ! -z "$API_URL" ] ; then
  if [ ! -z "$API_HOST" ] ; then
    wget -O swagger.json ${API_URL}
    sed -i "s|\"host\": \".*\",|\"host\": \"${API_HOST}\",|g" swagger.json
    API_URL="http://${DOMAIN}/swagger.json"
  fi
  sed -i "s|http://petstore.swagger.io/v2/swagger.json|${API_URL}|g" index.html
  sed -i "s|http://example.com/api|${API_URL}|g" index.html
fi

sed -i "s|.*scheme:.*$||g" index.html

if [ ! -z "$USE_HTTPS" ]; then
  sed -i "s|\(url: url,.*\)|\1\n        scheme: \"https\",|g" index.html
else
  sed -i "s|\(url: url,.*\)|\1\n        scheme: \"http\",|g" index.html
fi

sed -i "s|.*validatorUrl:.*$||g" index.html

if [ ! -z "$VALIDATOR_URL" ]; then
  sed -i "s|\(url: url,.*\)|\1\n        validatorUrl: \"${VALIDATOR_URL}\",|g" index.html
else
  sed -i "s|\(url: url,.*\)|\1\n        validatorUrl: null,|g" index.html
fi

exec nginx -g 'daemon off;'
