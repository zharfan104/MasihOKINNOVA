class Produk {
  final String nama;
  final String picture;
  final String heropicture;
  final String hargaAsal;
  final String hargaJadi;
  final String produsen;
  final String deskripsi;
  final String alamat;
  final String id;
  final String jam;
  final String sisa;
  Produk(
      {this.id,
      this.nama,
      this.picture,
      this.heropicture,
      this.hargaAsal,
      this.hargaJadi,
      this.produsen,
      this.deskripsi,
      this.jam,
      this.sisa,
      this.alamat});
}

List<Produk> itemProduk = [
  Produk(
      id: "990",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "21.00-22.00",
      sisa: "5",
      hargaAsal: "7000",
      hargaJadi: "3000",
      heropicture: "assets/warteg2.jpg",
      picture: "assets/wartegbukan2.jpg",
      nama: "Warung Tegal Suka",
      produsen: "Indomaret",
      alamat: "Tirtoagung 45"),
  Produk(
      id: "991",
      deskripsi:
          "Menyediakan makanan yang tersisa pada dinner untuk tamu Hotel Ibis Semarang, Kami dari Ibis Hotel sangat mengapresiasi aplikasi MasihOK dalam rangka mengurangi sampah makanan",
      jam: "22.00-23.00",
      sisa: "10",
      hargaAsal: "45000",
      hargaJadi: "20000",
      alamat: "Tirtoagung 45",
      heropicture: "assets/ibis.png",
      picture: "assets/hotel2.jpg",
      nama: "Hotel Ibis Semarang",
      produsen: "Ibis Group International"),
  Produk(
      id: "992",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "21.00-22.00",
      sisa: "83",
      alamat: "Tirtoagung 45",
      hargaAsal: "7000",
      hargaJadi: "3000",
      heropicture: "assets/indomaret.jpg",
      picture: "assets/sarirotikeju.jpg",
      nama: "Sari Roti Keju",
      produsen: "Indomaret"),
  Produk(
      id: "993",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "21.00-22.00",
      sisa: "3",
      alamat: "Tirtoagung 45",
      hargaAsal: "8000",
      hargaJadi: "5000",
      heropicture: "assets/warteg.jpg",
      picture: "assets/wartegbukan.jpg",
      nama: "Warteg Makmur",
      produsen: "Indomaret"),
  Produk(
      id: "994",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "21.00-22.00",
      sisa: "3",
      hargaAsal: "7000",
      hargaJadi: "3000",
      heropicture: "assets/indomaret.jpg",
      picture: "assets/susu.jpg",
      alamat: "Tirtoagung 45",
      nama: "Susu UHT",
      produsen: "Indomaret"),
  Produk(
      id: "995",
      deskripsi:
          "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?",
      jam: "21.00-22.00",
      sisa: "5",
      hargaAsal: "7000",
      alamat: "Tirtoagung 45",
      hargaJadi: "3000",
      heropicture: "assets/warteg.jpg",
      picture: "assets/wartegbukan.jpg",
      nama: "Warteg Kucingan",
      produsen: "Indomaret"),
];
