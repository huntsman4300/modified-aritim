timedatectl set-ntp true
fdisk /dev/nvme0n1
mkfs.fat -F32 /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mount /dev/nvme0n1p2 /mnt
mkdir /mnt/boot
mount /dev/nvme0n1p1 /mnt/boot
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
ln -sf /usr/share/zoneinfo/US/Central /etc/localtime
hwclock --systohc
pacman -S vim
vim /etc/locale.gen
locale-gen
vim /etc/locale.conf
vim /etc/hostname
vim /etc/hosts
mkinitcpio -P
passwd
pacman -S grub efibootmgr networkmanager intel-ucode
systemctl enable NetworkManager
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Aelius
grub-mkconfig -o /boot/grub/grub.cfg
exit
umount -a
