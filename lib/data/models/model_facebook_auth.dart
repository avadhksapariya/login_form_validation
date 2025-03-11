class ModelFacebookAuth {
  String? name = '';
  String? email = '';
  Picture? picture;
  String? id = '';

  ModelFacebookAuth({
    this.name = '',
    this.email = '',
    this.picture,
    this.id = '',
  });

  ModelFacebookAuth.fromJson(Map<String, dynamic> json) {
    name = json["name"].toString();
    email = json["email"].toString();
    picture = json["picture"] == null ? null : Picture.fromJson(json["picture"]);
    id = json["id"].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["email"] = email;
    if (picture != null) {
      data["picture"] = picture?.toJson();
    }
    data["id"] = id;
    return data;
  }
}

class Picture {
  Data? authImgData;

  Picture({this.authImgData});

  Picture.fromJson(Map<String, dynamic> json) {
    authImgData = json["data"] == null ? null : Data.fromJson(json["data"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (authImgData != null) {
      data["data"] = authImgData?.toJson();
    }
    return data;
  }
}

class Data {
  int? height = 0;
  bool? isSilhouette;
  String? url = '';
  int? width = 0;

  Data({
    this.height = 0,
    this.isSilhouette,
    this.url = '',
    this.width = 0,
  });

  Data.fromJson(Map<String, dynamic> json) {
    height = json["height"];
    isSilhouette = json["is_silhouette"];
    url = json["url"].toString();
    width = json["width"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["height"] = height;
    data["is_silhouette"] = isSilhouette;
    data["url"] = url;
    data["width"] = width;
    return data;
  }
}
