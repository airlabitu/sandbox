# !/bin/python
# FormatterPi live running script (2.0).
# Searches for newly inserted volumes (blocks). Will request to delete the first block on list, usually sda or sdb. Cannot delete itself "mmcblk"
# Thomas Kaufmanas // AIRLAB ITU // spring 2023

import time
import os
import subprocess

def blockCheck():
    """Use subprocess module to read block devices inserted. Returns a list of names"""
    output = subprocess.Popen("lsblk -l -o NAME", shell=True, stdout=subprocess.PIPE).stdout
    output = output.read()
    output = output.decode("utf-8")
    output = output.strip().split("\n")
    result = output[1:]
    #print("array er:", result)
    return result

def wipeSD(blockname):
    """formats an SD card by name of primary blocks (thereby including any partitions under this)"""
    b = blockname
    print("Unmounting all partitions...")
    os.system(f"sudo umount /dev/{b}?")
    time.sleep(0.5)
    print("Constructing partitioning table...")
    os.system(f"sudo parted -s -a optimal -- /dev/{b} mklabel msdos")
    time.sleep(0.5)
    print("partitioning 100% of volume to fat32...")
    os.system(f"sudo parted -s -a optimal -- /dev/{b} mkpart primary fat32 1MiB 100%")
    time.sleep(0.5)
    print("Cleaning up...")
    os.system(f"sudo parted -s -- /dev/{b} align-check optimal 1")
    time.sleep(0.5)
    print("Formatting Volume...")
    os.system(f"sudo mkfs.vfat -F32 /dev/{b}1")
    time.sleep(1)
    print("\nScript finished. Let's hope it worked. Remove SD card")
    return None

while True:
    blocks1 = blockCheck()
    time.sleep(3)
    blocks2 = blockCheck()
    
    if len(blocks2) > len(blocks1):
        block = blocks2[0]
        print("CARD INSERTED. Contains the following:")
        os.system("lsblk")
        if input(f"Format volume /dev/{block}? (y/n): ") == "y":
            if "mmc" not in block:
                wipeSD(block)
            else:
                print("Sorry, can't interact with my own block (MMCBLK)")
        
        
    else:
        print("Waiting for SD ...")
