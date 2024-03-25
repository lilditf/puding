#!/bin/bash

# Pastikan file proxy.txt ada
if [ ! -f "proxy.txt" ]; then
    echo "File proxy.txt tidak ditemukan."
    exit 1
fi

# Nama file untuk menyimpan hasil
output_file="proxy_list.txt"

echo "Pilih jenis protokol proxy yang ingin ditambahkan:"
echo "1. HTTP"
echo "2. SOCKS4"
echo "3. SOCKS5"
read -p "Masukkan pilihan [1/2/3]: " choice

# Validasi pilihan
if [[ ! $choice =~ ^[1-3]$ ]]; then
    echo "Pilihan tidak valid."
    exit 1
fi

# Tentukan protokol berdasarkan pilihan
case $choice in
    1)
        protocol="http"
        ;;
    2)
        protocol="socks4"
        ;;
    3)
        protocol="socks5"
        ;;
esac

# Baca setiap baris dari file proxy.txt
while IFS= read -r line; do
    # Tambahkan protokol yang dipilih ke setiap baris
    proxy="$protocol://$line"
    # Simpan proxy yang telah dimodifikasi ke dalam file output tanpa menghapus yang sudah ada
    echo "$proxy" >> "$output_file"
done < "proxy.txt"

echo "Proxies dengan $protocol:// telah ditambahkan ke $output_file."
