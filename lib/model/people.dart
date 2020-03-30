class People {
  var id;
  String nama;
  String telepon;
  String email;
  String alamat;
  String latitude;
  String longitude;
  String imagePath;

  People({this.id,this.telepon,this.email,this.alamat,this.latitude,this.longitude,this.imagePath});

  People.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    telepon = json['telepon'];
    email = json['email'];
    alamat = json['alamat'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    imagePath = json['imagePath'];
  }
}