class ImageModel{
  late String imageUrl;

  ImageModel({required this.imageUrl});

  ImageModel.fromJson(Map<String,dynamic> json){
    this.imageUrl = json['imageUrl'];
  }

}