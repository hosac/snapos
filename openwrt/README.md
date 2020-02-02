# OpenWrt/LEDE flavored SnapOS
Cross compilation for OpenWrt is done with the [OpenWrt build system](https://wiki.openwrt.org/about/toolchain) on a Linux host machine:  
https://wiki.openwrt.org/doc/howto/build

For LEDE: 
https://lede-project.org/docs/guide-developer/quickstart-build-images

## OpenWrt/LEDE build system setup
https://wiki.openwrt.org/doc/howto/buildroot.exigence

### Get OpenWrt/LEDE
Clone OpenWrt to some place in your home directory (`<wrt dir>`)

    $ git clone https://github.com/openwrt/openwrt.git

...LEDE 

    $ git clone https://git.lede-project.org/source.git




### Option1: add snapcast to local filesystem
Within the `<wrt dir>/package` directory create a symbolic link to `<snapos dir>/openwrt`: 

	$ cd <wrt dir>
	$ ln -s <snapos dir>/openwrt package/snapos
	
### Option2: add snapcast to feeds
Add the github repository to <wrt dir>/feeds.conf

	src-git snapos https://github.com/badaix/snapos.git	# or an alternative repository

### Download and install available feeds 

	$ cd <wrt dir>
	$ ./scripts/feeds update -a
	$ ./scripts/feeds install -a


### Build  
In `make menuconfig` navigate to `Multimedia/snapcast` and select `snapserver` and/or `snapclient`

```
$ cd <wrt dir>
$ make defconfig
$ make menuconfig
$ make
```

#### Rebuild Snapcast:
If there is an update for snapcast available, it can be rebuilt like this:
```
$ cd <wrt dir>
$ make package/snapos/snapcast/clean
$ make package/snapos/snapcast/compile
```

The packaged `ipk` files are in  
```
<wrt dir>/bin/packages/<pkg_arch>/base/snapclient_x.x.x_<pkg_arch>.ipk
<wrt dir>/bin/packages/<pkg_arch>/base/snapserver_x.x.x_<pkg_arch>.ipk
```

