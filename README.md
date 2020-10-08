Requires https://github.com/mkaczanowski/packer-builder-arm

Build:
    
    sudo -E packer build armbian-focal.json  

Mount for inspection:
    
    mkdir -p ./mnt
    sudo mount -o loop,offset=4194304 ./armbian-focal-zeropi.img ./mnt
    sudo chroot mnt /bin/bash
    # inspect, ..., exit bash
    sudo umount mnt

Flash:

    lsblk
    dd bs=4M if=armbian-focal-zeropi.img of=/dev/mmcblk0 status=progress conv=fsync