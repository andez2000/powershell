# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser 
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent)
Clear-Host

#
# create ca-key
#
openssl genrsa -des3 -passout pass:password -out localhost_ca.key 2048

#
# create ca-cert
#
openssl req -new -x509 -days 3650 -key localhost_ca.key -out localhost_ca.crt -passin pass:password -subj "/C=GB/ST=Durham/L=Durham/O=acme/CN=localhost"

#
# create server-key
#
openssl genrsa -out localhost_srv.key 2048

#
# create server-csr
#
openssl req -new -out localhost_srv.csr -key localhost_srv.key -passin pass:password -subj "/C=GB/ST=Durham/L=Durham/O=acme/CN=localhost"

#
# create server-crt 
#   verify and sign: server-csr = ca-crt + ca-key
#
openssl x509 -req -in localhost_srv.csr -CA localhost_ca.crt -CAkey localhost_ca.key -CAcreateserial -out localhost_srv.crt -passin pass:password -days 3650 