---
name: text2image-generator
description: Generate gambar dari deskripsi teks menggunakan API text2image. Gunakan saat pengguna meminta untuk membuat gambar, generate gambar, atau me-render visual berdasarkan prompt tertentu.
---

# Text2Image Generator

Skill untuk menghasilkan gambar berbasis deskripsi teks (prompt) menggunakan endpoint API external.

## Workflow

### Langkah 1: Siapkan Payload & Eksekusi Request
Jalankan perintah `curl` berikut di terminal untuk mengirim prompt ke API.

```bash
curl -X POST "[https://puruboy-api.vercel.app/api/text2image](https://puruboy-api.vercel.app/api/text2image)" \
  -H "Content-Type: application/json" \
  -d '{
  "prompt": "<DESKRIPSI_GAMBAR>",
  "size": "<RASIO_ASPEK>",
  "num_images": 1
}'

```
 * **Parameter size yang didukung:** 1:1 (default), 16:9, 9:16, 4:3, 3:4.
 * Ubah <DESKRIPSI_GAMBAR> sesuai permintaan pengguna.
### Langkah 2: Parsing Response SSE / Stream
API mengembalikan respons berupa alur *Server-Sent Events* (SSE) berbasis JSON. Filter output untuk mengambil array images pada event done.
Contoh respons sukses:
```json
{"event":"done","success":true,"status":"success","source":"vheer","model":"flux_dev","taskId":"DG6StkcY","images":["[https://access.vheer.com/results/DG6StkcY_1788251288396.jpg](https://access.vheer.com/results/DG6StkcY_1788251288396.jpg)"]}

```
### Langkah 3: Tampilkan Hasil
Tampilkan URL gambar yang dihasilkan dari array images kepada pengguna dalam format Markdown image: ![Hasil Gambar](URL_GAMBAR).
## Contoh Penggunaan
**Input Pengguna:**
> "Bikinin gambar rubah merah di hutan salju dong, rasio 1:1"
> 
**Perintah yang Dijalankan:**
```bash
curl -X POST "[https://puruboy-api.vercel.app/api/text2image](https://puruboy-api.vercel.app/api/text2image)" \
  -H "Content-Type: application/json" \
  -d '{
  "prompt": "seekor rubah merah di hutan salju",
  "size": "1:1",
  "num_images": 1
}'

```
**Output:**
> Gambar berhasil dibuat!
> 
> 
```

---

### 🚀 Cara Pemasangan & Penggunaan:

1. **Simpan File:** 
   Buat folder dan simpan file di atas ke: `~/.claude/skills/text2image-generator/SKILL.md`
2. **Uji Coba:**
   Buka kembali Claude Code lalu berikan perintah:
   *"Bikinin gambar pemandangan gunung saat matahari terbenam."*

Apakah struktur skill ini sudah sesuai dengan kebutuhanmu, atau ada parameter API lain yang ingin ditambahkan?
