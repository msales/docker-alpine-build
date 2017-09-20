#Alpine Package Builder

Build Alpine packages in docker.

## Configuration

### Environment Variables

* **RSA_PUBLIC_KEY** - The contents of your RSA public key.
* **RSA_PRIVATE_KEY** - The contents of your RSA private key.
* **RSA_PRIVATE_KEY_NAME** - The name of your RSA private key. Default: ```ssh.rsa```
* **REPODEST** - The package destination. Default: ```/packages```
* **PACKAGER** - The name of the packager to be used in package metadata. Default ```msales (alpine@msales.com)```

### Volumes

* **/home/builder/package** - Mount our package(s) directory to be built. For multiple packages, your packages should 
be under a ```main``` directory.
* **/packages** - Mount point your packages will be build to. 

## License

MIT-License. As is. No warranties whatsoever. Mileage may vary. Batteries not included.