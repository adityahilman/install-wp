echo "Domain Name (ex: *.domain.com ): "
read CERT_DOMAIN

echo "Organization : "
read CERT_ORGANIZATION

echo "Department : "
read CERT_DEPARTMENT

echo "City : "
read CERT_CITY

echo "State/Province : "
read CERT_STATE

echo "Country Code (ex: ID): "
read CERT_COUNTRY

openssl req -new -newkey rsa:2048 -nodes -out $CERT_DOMAIN.csr -keyout $CERT_DOMAIN.key -subj "/C=ID/ST=$CERT_STATE/L=$CERT_CITY/O=$CERT_ORGANIZATION/OU=$CERT_DEPARTMENT/CN=$CERT_DOMAIN"