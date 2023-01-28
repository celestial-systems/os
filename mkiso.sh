rm -rf orion/

FOLDER=orion/
if test -d "$FOLDER"; then
    echo "$FOLDER exists."
else
    git clone https://github.com/celestial-systems/orion.git --recurse
fi

make -C orion/

mv orion/orion-x86_64.x .

FILE1=BOOTX64.EFI
if test -f "$FILE1"; then
    echo "$FILE1 exists."
else
    wget https://github.com/UltraOS/Hyper/releases/download/v0.5.1/BOOTX64.EFI
fi

FILE2=hyper_install-linux-x86_64
if test -f "$FILE2"; then
    echo "$FILE2 exists."
else
    wget https://github.com/UltraOS/Hyper/releases/download/v0.5.1/hyper_install-linux-x86_64
fi

FILE3=hyper_iso_boot
if test -f "$FILE3"; then
    echo "$FILE3 exists."
else
    wget https://github.com/UltraOS/Hyper/releases/download/v0.5.1/hyper_iso_boot
fi

rm -rf celestial_os.x86_64.iso
xorriso -as mkisofs -b hyper_iso_boot -no-emul-boot -boot-load-size 4 -boot-info-table --efi-boot BOOTX64.EFI -efi-boot-part --efi-boot-image --protective-msdos-label . -o celestial_os.x86_64.iso