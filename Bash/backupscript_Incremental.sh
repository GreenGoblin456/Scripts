#!/bin/bash

mount //IP/Name_of_shared_folder_for_backUP  /mnt/Path_to_Mounted_folder/ -o username=xxxx,password=xxxx

if test -f  /mnt/Path_to_Mounted_folder/mounted.txt
then
      date >>  /mnt/Path_to_Mounted_folder/mounted.txt

      rsync -abrqz /srv/Path_to_folder_wanted_to_back_up  /mnt/Path_to_Mounted_folder
      rsync -abrqz --exclude 'if_you_want_exclude' --exclude 'if_you_want_exclude' /and_back_Up_other  /mnt/Path_to_Mounted_folder

      date >>  /mnt/Path_to_Mounted_folder/mounted.txt

      umount  /mnt/Path_to_Mounted_folder

else
      printf "Mountovani neprobehlo uspesne!! \n"
fi



