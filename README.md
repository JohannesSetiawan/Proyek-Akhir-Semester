[![Build status](https://build.appcenter.ms/v0.1/apps/fe1e6724-e0e7-4de6-b655-9a7f1f5f74b8/branches/master/badge)](https://appcenter.ms)
[![Pre-Release](https://github.com/JohannesSetiawan/nutrious-mobile/actions/workflows/pre-release.yml/badge.svg)](https://github.com/JohannesSetiawan/nutrious-mobile/actions/workflows/pre-release.yml)
[![Release](https://github.com/JohannesSetiawan/nutrious-mobile/actions/workflows/release.yml/badge.svg)](https://github.com/JohannesSetiawan/nutrious-mobile/actions/workflows/release.yml)
[![Staging](https://github.com/JohannesSetiawan/nutrious-mobile/actions/workflows/staging.yml/badge.svg)](https://github.com/JohannesSetiawan/nutrious-mobile/actions/workflows/staging.yml)
# Nutrious Mobile

## Nama Anggota Kelompok
1. Stelline Claudia - 2106700933
2. Dhafin Raditya Juliawan - 2106650304
3. Johannes Setiawan - 2106750345
4. Muhammad Faris Umar Rahman - 2106702402
5. Jaycent Gunawan Ongris - 2106750231
6. Annava Wisha Sikoko - 2106635493

## Tautan APK
TBA

## Deskripsi Aplikasi
Aplikasi yang akan kami buat adalah Nutrious Mobile. Nutrious Mobile merupakan aplikasi *mobile* yang diadaptasi dari aplikasi [web](https://nutrious.up.railway.app/) yang telah kami buat
sebelumnya. Aplikasi ini kami buat untuk mendukung penyelesaian isu kesehatan global sebagaimana yang dibahas oleh pemimpin-pemimpin dunia pada Konferensi
G20. Spesifiknya, aplikasi ini berfokus pada permasalahan terkait bagaimana meningkatkan asupan gizi masyarakat untuk kualitas hidup yang lebih baik. Untuk
mengimplementasikan hal ini, kami membuat beberapa fitur pada aplikasi ini yang bermanfaat bagi pengguna aplikasi itu sendiri maupun masyarakat secara umum.
Fitur-fitur tersebut adalah *calorie tracker* untuk *tracking* kalori dari pengguna tiap harinya, *fundraising* untuk memberikan kesempatan kepada pengguna
melakukan donasi kepada orang-orang yang membutuhkan, *food-sharing* untuk memberikan informasi terkait lokasi pembagian makanan kepada masyarakat jika ada
pengguna yang ingin membagi makanan, *food recipe* untuk memberikan informasi terkait resep makanan sehat yang ditulis oleh pengguna, dan *blog* untuk
memberikan informasi atau artikel terkait kesehatan dan gizi yang ditulis oleh pengguna.

## Daftar Fitur yang Diimplementasikan dan Kontrak Kinerja
1. Fitur Utama (Jaycent Gunawan Ongris)<br>
Fitur ini terdiri dari halaman utama aplikasi, halaman *login*, halaman *dashboard* administrator, dan mengimplementasikan sistem autentikasi pada aplikasi.

2. Fundraising (Johannes Setiawan)<br>
Fitur ini terdiri dari halaman daftar donasi yang dibuka, formulir untuk membuka donasi baru, dan formulir untuk berdonasi.

3. Food-Sharing (Annava Wisha Sikoko)<br>
Fitur ini terdiri dari halaman daftar lokasi pembagian makanan yang ada, formulir untuk mendaftarkan lokasi pembagian makanan, serta fitur untuk menghapus dan mengedit lokasi pembagian makanan yang dibuat.

4. Calorie Tracker (Stelline Claudia)<br>
Fitur ini terdiri dari halaman daftar kalori yang dikonsumsi dan dibakar, formulir untuk menambahkan kalori yang dikonsumsi, formulir untuk menambah kalori yang dibakar, fitur untuk menghapus daftar kalori, dan fitur untuk mengedit daftar kalori.

5. Food Recipe (Muhammad Faris Umar Rahman)<br>
Fitur ini terdiri dari halaman yang berisi daftar resep makanan yang terdiri dari judul makanan, tanggal resep dibuat, nama pembuat resep, *ingredients* makanan, 
dan langkah-langkah pembuatan makanan. Resep makanan dapat ditambahkan dari oleh *user* melalui fitur *add recipe* yang tersedia.

6. Blog (Dhafin Raditya Juliawan)<br>
Fitur ini terdiri dari halaman utama *blog post*, formulir untuk menambahkan *post* baru, fitur untuk menampilkan *post* dengan tag yang diinginkan oleh *user* dan fitur *upvote-downvote* sebuah *post*.

## Peran atau Aktor Pengguna Aplikasi
Terdapat dua jenis pengguna pada aplikasi ini, yaitu admin dan pengguna biasa (*user*). Admin dapat melihat siapa saja user yang sudah terdaftar, donasi
yang dibuka oleh *user*, dan pesan yang dikirimkan oleh *user*. Sementara itu, *user* terdiri dari dua jenis, yaitu *user* yang sudah terverifikasi dan *user* yang
belum terverifikasi. Semua *user* yang sudah *logged in* ke dalam aplikasi dapat melakukan donasi, membuat *log* terkait aktivitas yang berhubungan dengan
penambahan atau pembakaran kalori, membagikan resep makanan sehat, membuat *blog*, dan melakukan *upvote* atau *downvote* pada *blog*. Sementara itu, untuk alasan
keamanan, hanya *user* yang sudah terverifikasi saja yang dapat membuka penggalangan dana dan memberikan informasi terkait lokasi pembagian makanan.

## Alur Pengintegrasian dengan *Web Service* dari PTS
1. Fitur Utama <br>
- Untuk sistem *login*, *user* akan memasukkan *username* dan *password* pada halaman yang tersedia. Selanjutnya, data terkait *username* dan *password* akan di-*pass* pada salah satu parameter *method* `login` yang disediakan oleh *package* `pbp_django_auth`. Data tersebut diteruskan ke URL `https://nutrious.up.railway.app/auth/login/` yang berisi fungsi `views` untuk *login* secara *asynchronous*. Fungsi tersebut akan menerapkan autentikasi terhadap *user* yang ingin *login* dan mengembalikan JSON berupa informasi dari *user* yang berhasil *login* atau *error message* jika *user* tidak berhasil *login*. Informasi yang didapatkan tersebut kemudian digunakan untuk menentukan apakah *role* *user* adalah admin atau pengguna biasa. Berdasarkan *role*-nya, *user* akan diarahkan ke *dashboard page* yang sesuai dengan *role* tersebut.

- Untuk sistem *logout*, *user* cukup mengklik tombol `Log Out` yang ada pada *drawer*. Setelah itu, dilakukan pemanggilan terhadap *method* `logout` yang disediakan oleh *package* `pbp_django_auth`, dengan parameter URL `https://nutrious.up.railway.app/auth/logout/` yang berisi fungsi `views` untuk *logout*. Jika berhasil *logout*, fungsi akan mengembalikan JSON yang berisi *status message* dari operasi tersebut dan *user* akan diarahkan ke *page* `Login-Register`.

- Untuk pengiriman *message* ke admin oleh pengguna biasa, pengguna tinggal memasukkan*message* yang ingin dikirim melalui kolom input yang telah disediakan. Setelah pengguna menekan tombol untuk kirim, data *message* yang dimasukkan oleh pengguna akan di-*pass* menjadi salah satu parameter *method* `post` yang disediakan oleh *package* `pbp_django_auth`. Data akan diteruskan ke URL `https://nutrious.up.railway.app/add-message/` yang berisi fungsi `views` untuk menambahkan *message* ke *database* secara *asynchronous*.

- Untuk melihat daftar pengguna pada *dashboard* admin, dilakukan pengambilan data dari URL
  `https://nutrious.up.railway.app/json-user/` yang akan mengembalikan JSON berupa daftar pengguna beserta informasi yang terkait. Pengambilan data memanfaatkan *method* `get` yang disediakan oleh *package* `pbp_django_auth`. Setelah itu, akan dibuat *model class* `User` untuk pengaksesan data. Selanjutnya, dilakukan *loop* pada respons data tersebut untuk
  kemudian dikonversi menjadi *instance* dari `User`, lalu ditambahkan ke `list`. Selanjutnya, dibuat `FutureBuilder` dengan parameter `future` yang berupa fungsi `Future` untuk *fetch* data dan mengembalikan `list of User`. Kemudian, `list` kembalian fungsi tersebut di-*pass* menjadi parameter `snapshot` untuk parameter `builder` di `FutureBuilder`. Selanjutnya, dilakukan *looping* di `list` tersebut untuk menampilkan informasi dari `User` dalam suatu `Container` yang menjadi `children` dari `ListView`. Kemudian, ketika ingin melihat detail dari pengguna, `Container` tersebut dapat diklik, yang kemudian *page* akan dipindahkan ke *page* yang berisi detail dari pengguna, yaitu pada *widget* `UserDetail`. Ketika dilakukan *push* ke *widget* tersebut, data `id` dan `detail` di-*pass* ke *widget* tersebut, lalu `detail` akan diekstrak untuk diambil nilai dari propertinya dan ditampilkan pada *page* detail tersebut.

- Untuk melihat daftar *fundraising* pada *dashboard* admin, dilakukan pengambilan data dari URL
  `https://nutrious.up.railway.app/donation/json-with-name/` yang akan mengembalikan JSON berupa daftar donasi beserta informasi yang
  terkait. Pengambilan data memanfaatkan *method* `get` yang disediakan oleh *package* `pbp_django_auth`. Setelah itu,
  akan dibuat *model class* `Fundraising` untuk pengaksesan data. Selanjutnya, dilakukan *loop* pada respons data tersebut untuk
  kemudian dikonversi menjadi *instance* dari `Fundraising`, lalu ditambahkan ke `list`. Selanjutnya, dibuat `FutureBuilder`
  dengan parameter `future` yang berupa fungsi `Future` untuk *fetch* data dan mengembalikan `list of Fundraising`. Kemudian,
  `list` kembalian fungsi tersebut di-*pass* menjadi parameter `snapshot` untuk parameter `builder` di `FutureBuilder`.
  Selanjutnya, dilakukan *looping* di `list` tersebut untuk menampilkan informasi dari `Fundraising` dalam suatu `Container`
  yang menjadi `children` dari `ListView`. Kemudian, ketika ingin melihat detail dari *fundraising*, `Container` tersebut dapat
  diklik, yang kemudian *page* akan dipindahkan ke *page* yang berisi detail dari *fundraising*, yaitu pada *widget* `FundraisingDetail`.
  Ketika dilakukan *push* ke *widget* tersebut, data `detail` akan di-*pass* ke *widget* tersebut, kemudian
  diekstrak untuk diambil nilai dari propertinya dan ditampilkan pada *page* detail tersebut.

- Untuk melihat daftar *message* pada *dashboard* admin, dilakukan pengambilan data dari URL
  `https://nutrious.up.railway.app/json-message-name/` yang akan mengembalikan JSON berupa daftar *message* beserta informasi yang
  terkait. Pengambilan data memanfaatkan *method* `get` yang disediakan oleh *package* `pbp_django_auth`. Setelah itu,
  akan dibuat *model class* `Message` untuk pengaksesan data. Selanjutnya, dilakukan *loop* pada respons data tersebut untuk
  kemudian dikonversi menjadi *instance* dari `Message`, lalu ditambahkan ke `list`. Selanjutnya, dibuat `FutureBuilder`
  dengan parameter `future` yang berupa fungsi `Future` untuk *fetch* data dan mengembalikan `list of Message`. Kemudian,
  `list` kembalian fungsi tersebut di-*pass* menjadi parameter `snapshot` untuk parameter `builder` di `FutureBuilder`.
  Selanjutnya, dilakukan *looping* di `list` tersebut untuk menampilkan informasi dari `Message` dalam suatu `Container`
  yang menjadi `children` dari `ListView`. Kemudian, ketika ingin melihat detail dari *message*, `Container` tersebut dapat
  diklik, yang kemudian *page* akan dipindahkan ke *page* yang berisi detail dari *message*, yaitu pada *widget* `MessageDetail`.
  Ketika dilakukan *push* ke *widget* tersebut, data `detail` akan di-*pass* ke *widget* tersebut, kemudian
  diekstrak untuk diambil nilai dari propertinya dan ditampilkan pada *page* detail tersebut.

2. \[FITUR SELANJUTNYA\]
