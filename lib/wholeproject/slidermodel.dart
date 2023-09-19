class HomeBannerModel {
  String entryfee;
  String image;
  String prize;
  String id;


  HomeBannerModel({this.entryfee, this.image,this.prize,this.id});

  factory HomeBannerModel.fromJson(Map<String, dynamic> json) {
    return HomeBannerModel(
      entryfee: json['entryfee'],
      image: json['image'],
      prize: json['prize'],
      id:json["id"],
    );
  }
}