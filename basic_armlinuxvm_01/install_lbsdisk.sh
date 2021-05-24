#!/bin/bash
	
# Partition the drive /dev/sdc.
# Read from standard input provide the options we want.
#  n adds a new partition.
#  p specifies the primary partition type.
#  the following blank line accepts the default partition number.
#  the following blank line accepts the default start sector.
#  the following blank line accepts the default final sector.
#  p prints the partition table.
#  w writes the changes and exits.
echo -e "nn\np\n1\n\n\nw" | fdisk /dev/sdc

# Creación del VG_Group
vgcreate vg_lbsdisks /dev/sdc1


# Creación de los LVM
lvcreate -L 10G -n lv_var vg_lbsdisks
lvcreate -L 6G -n lv_home vg_lbsdisks
lvcreate -L 8G -n lv_agent vg_lbsdisks
lvcreate -l 100%FREE -n lv_tmp vg_lbsdisks

# Formateo de volumenes
mkfs.ext4  /dev/mapper/vg_lbsdisks-lv_var
mkfs.ext4  /dev/mapper/vg_lbsdisks-lv_tmp
mkfs.ext4  /dev/mapper/vg_lbsdisks-lv_home
mkfs.ext4  /dev/mapper/vg_lbsdisks-lv_agent

# Montado de discos y creación de carpetas temporales
mount  /dev/mapper/vg_lbsdisks-lv_tmp /tmp
mkdir /tmp/hometmp
mkdir /tmp/vartmp
mkdir /agent

mount  /dev/mapper/vg_lbsdisks-lv_var /tmp/vartmp/
mount  /dev/mapper/vg_lbsdisks-lv_home /tmp/hometmp/

# Copiar los archivos desde la carpeta /home,/var hacia carpetas en la ruta /tpm
sudo rsync -avz /home/ /tmp/hometmp/ 
sudo rsync -avz /var/ /tmp/vartmp/

mount /dev/mapper/vg_lbsdisks-lv_home /home/  
mount /dev/mapper/vg_lbsdisks-lv_var /var/
mount /dev/mapper/vg_lbsdisks-lv_agent /agent/

rsync -avz /tmp/hometmp/ /home/  
rsync -avz /tmp/vartmp/ /var/


# Agregar montado de disco al archivo /etc/fstab
echo '/dev/mapper/vg_lbsdisks-lv_tmp /tmp       ext4   defaults,nofail   1  2' >> /etc/fstab
echo '/dev/mapper/vg_lbsdisks-lv_var /var       ext4   defaults,nofail    1  2' >> /etc/fstab
echo '/dev/mapper/vg_lbsdisks-lv_home /home       ext4   defaults,nofail    1  2' >> /etc/fstab
echo '/dev/mapper/vg_lbsdisks-lv_agent /agent       ext4   defaults,nofail    1  2' >> /etc/fstab

