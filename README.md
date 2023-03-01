# Migrasi Email dari cPanel ke Zimbra

## Migrasi Akun dari cPanel ke Zimbra (email dan password)
1. Copy file shadow dari cPanel `/home/account/etc/domain/shadow` ke server Zimbra `/srv/`
2. Download file `script-export-acc-cpanel.sh` ke server zimbra `/srv/`
3. Jalankan script untuk memulai export data shadow, selanjutnya akan menghasilkan output file dengan nama `create-account-zimbra.zmp` dengan command berikut  
```
# chmod +x script-export-acc-cpanel.sh  
# su zimbra  
$ zmprov < create-account-zimbra.zmp
```
4. Tunggu hingga proses import account selesai. Selanjutnya bisa di cek pada Zimbra Admin harusnya semua akun akan import ke zimbra

## Migrasi Data Email dari cPanel ke Zimbra menggunakan imapsync
#### Action pada cPanel
1. Backup file `shadow` dengan nama `shadow_original`
2. Copy hash code dari akun yang kita sudah tau password nya di dalam file `shadow` dan pastekan ke file baru dengan nama `password.txt`
3. Sesuaikan file `create-shadow-reset.sh` , namadomain = sesuaikan dengan domain TLD, misal example.com
4. Jalankan script untuk membuat file `shadow` baru dnegan nama `shadow-reset`
```
# chmod +x create-shadow-reset.sh
# ./create-shadow-reset.sh
```
5. Replace file `shadow` dengan file hasil generate script, yaitu `shadow-reset`
6. Restart service exim `service exim restart`

#### Action pada Zimbra
Action pada server sama seperti tahapan **Migrasi Akun dari cPanel ke Zimbra (email dan password)** hanya saja file `shadow` yang kita copy adalah file yang sudah di ubah password nya ke password yang sama.

1. Copy file shadow dari cPanel yang isi hash nya sudah di ganti semua dengan password yang sama `/home/account/etc/domain/shadow` ke server Zimbra `/srv/`
2. Download file `reset-pass.sh` ke server zimbra `/srv/` . sesuaikan terlebih dahulu pada bagian `DOMAIN`
3. Jalankan script untuk memulai export data shadow, selanjutnya akan menghasilkan output file dengan nama `reset-pass.zmp` dengan command berikut  
```
# chmod +x reset-pass.sh  
# su zimbra  
$ zmprov < reset-pass.zmp
```
4. Tunggu hingga proses import account selesai. Selanjutnya bisa di cek pada Zimbra Admin harusnya semua akun akan import ke zimbra

#### ImapSync
