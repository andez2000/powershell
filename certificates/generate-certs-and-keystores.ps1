#
# Purpose: Generates the self signed set of certificates
#
# Instructions
#
# 1. Download Open SSL (C:\Program Files\OpenSSL\bin)
# 2. Add location (eg. C:\Program Files\OpenSSL\bin) to the Path environment variable
# 3. Run this script
#
# Outputs
#
# | File                      | Description                                                               |
# |---------------------------|---------------------------------------------------------------------------|
# | MYSERVERKEYSTORE.jks      | The Java Keystore                                                         |
# | {certificateName}_ca.crt  | The OpenSSL Certificate Authority certificate file                        |
# | {certificateName}_ca.key  | The OpenSSL Certificate Authority RSA key file                            |
# | {certificateName}_ca.p12  | The OpenSSL Certificate Authority certificate converted to p12/pfx format |
# | {certificateName}_ca.srl  | Unknown what outputs this                                                 |
# | {certificateName}_srv.crt | The OpenSSL server certificate file                                       |
# | {certificateName}_srv.csr | The OpenSSL server Certificate Signing Request file                       |
#

# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser 
Set-Location (Split-Path $MyInvocation.MyCommand.Path -Parent)
$env:Path = $env:Path + ";" + $env:JAVA_HOME + "\bin"
Clear-Host

$java_key_store_alias = "Localhost"
$java_key_store_file = "Localhost.jks"

#
# create rand file to stop errors
#
openssl rand -writerand .rnd


#
# create Certification Authority Key (ca-key)
#
openssl genrsa -des3 -passout pass:password -out localhost_ca.key 2048

#
# create Certification Authority Certificate (ca-cert)
#
openssl req -new -x509 -days 3650 -key localhost_ca.key -out localhost_ca.crt -passin pass:password -subj "/C=GB/ST=Timbuktu/L=Timbuktu/O=acme/CN=localhost-CA"

#
# create Server Key (server-key)
#
openssl genrsa -out localhost_srv.key 2048

#
# create Server Signing Request (server-csr)
#
openssl req -new -out localhost_srv.csr -key localhost_srv.key -passin pass:password -subj "/C=GB/ST=Timbuktu/L=Timbuktu/O=acme/CN=localhost"

#
# create Server Certificate (server-crt)
#   verify and sign: server-csr = ca-crt + ca-key
#
openssl x509 -req -in localhost_srv.csr -CA localhost_ca.crt -CAkey localhost_ca.key -CAcreateserial -out localhost_srv.crt -passin pass:password -days 3650 

#
# convert ca-cert to pfx/p12
#
openssl pkcs12 -export -in localhost_ca.crt -inkey localhost_ca.key -out localhost_ca.p12 -passin pass:password -passout pass:password

# verify
write-host "Verifying..."
openssl verify -CAfile localhost_ca.crt localhost_srv.crt


#
#
# JAVA
#
#

# create a java keystore
Write-Host "Now the Java fun begins..."


if (Test-Path $java_key_store_file) {
   Remove-Item $java_key_store_file
}


keytool -genkey -alias $java_key_store_alias -keyalg RSA -keysize 2048 -keystore "$java_key_store_file" -dname "CN=localhost-CA, O=acme, L=Timbuktu, ST=Timbuktu, C=GB" -storepass password -keypass password -validity 2000

# import certificate
keytool -import -alias $java_key_store_alias -keystore $java_key_store_file -file localhost_ca.p12 -storepass password -keypass password

