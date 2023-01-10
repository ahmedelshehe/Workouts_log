import 'dart:convert';
Exercise exerciseFromJson(String str) => Exercise.fromJson(json.decode(str));
String exerciseToJson(Exercise data) => json.encode(data.toJson());
class Exercise {
  Exercise({
      num? id, 
      String? name,
      String? uuid, 
      num? exerciseBaseId, 
      String? description, 
      String? creationDate, 
      Category? category, 
      List<Muscles>? muscles, 
      List<MusclesSecondary>? musclesSecondary, 
      List<Equipment>? equipment, 
      Language? language, 
      License? license, 
      String? licenseAuthor, 
      List<Images>? images, 
      List<Videos>? videos, 
      List<Comments>? comments, 
      List<num>? variations, 
      List<String>? authorHistory,}){
    _id = id;
    _name = name;
    _uuid = uuid;
    _exerciseBaseId = exerciseBaseId;
    _description = description;
    _creationDate = creationDate;
    _category = category;
    _muscles = muscles;
    _musclesSecondary = musclesSecondary;
    _equipment = equipment;
    _language = language;
    _license = license;
    _licenseAuthor = licenseAuthor;
    _images = images;
    _videos = videos;
    _comments = comments;
    _variations = variations;
    _authorHistory = authorHistory;
}

  Exercise.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _uuid = json['uuid'];
    _exerciseBaseId = json['exercise_base_id'];
    _description = json['description'];
    _creationDate = json['creation_date'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['muscles'] != null) {
      _muscles = [];
      json['muscles'].forEach((v) {
        _muscles?.add(Muscles.fromJson(v));
      });
    }
    if (json['muscles_secondary'] != null) {
      _musclesSecondary = [];
      json['muscles_secondary'].forEach((v) {
        _musclesSecondary?.add(MusclesSecondary.fromJson(v));
      });
    }
    if (json['equipment'] != null) {
      _equipment = [];
      json['equipment'].forEach((v) {
        _equipment?.add(Equipment.fromJson(v));
      });
    }
    _language = json['language'] != null ? Language.fromJson(json['language']) : null;
    _license = json['license'] != null ? License.fromJson(json['license']) : null;
    _licenseAuthor = json['license_author'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      _videos = [];
      json['videos'].forEach((v) {
        _videos?.add(Videos.fromJson(v));
      });
    }
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Comments.fromJson(v));
      });
    }
    _variations = json['variations'] != null ? json['variations'].cast<num>() : [];
  }
  num? _id;
  String? _name;
  String? _uuid;
  num? _exerciseBaseId;
  String? _description;
  String? _creationDate;
  Category? _category;
  List<Muscles>? _muscles;
  List<MusclesSecondary>? _musclesSecondary;
  List<Equipment>? _equipment;
  Language? _language;
  License? _license;
  String? _licenseAuthor;
  List<Images>? _images;
  List<Videos>? _videos;
  List<Comments>? _comments;
  List<num>? _variations;
  List<String>? _authorHistory;

  num get id => _id ?? 0;
  String get name => _name ?? '';
  String get uuid => _uuid ?? '';
  num get exerciseBaseId => _exerciseBaseId ?? 0;
  String get description => _description ?? '';
  String get creationDate => _creationDate ?? '';
  Category? get category => _category;
  List<Muscles> get muscles => _muscles ?? [];
  List<MusclesSecondary> get musclesSecondary => _musclesSecondary ?? [];
  List<Equipment> get equipment => _equipment ?? [];
  Language? get language => _language;
  License? get license => _license;
  String get licenseAuthor => _licenseAuthor ?? '';
  List<Images> get images => _images ?? [];
  List<Videos> get videos => _videos ?? [];
  List<Comments> get comments => _comments ?? [];
  List<num> get variations => _variations ?? [];
  List<String> get authorHistory => _authorHistory ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['uuid'] = _uuid;
    map['exercise_base_id'] = _exerciseBaseId;
    map['description'] = _description;
    map['creation_date'] = _creationDate;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_muscles != null) {
      map['muscles'] = _muscles?.map((v) => v.toJson()).toList();
    }
    if (_musclesSecondary != null) {
      map['muscles_secondary'] = _musclesSecondary?.map((v) => v.toJson()).toList();
    }
    if (_equipment != null) {
      map['equipment'] = _equipment?.map((v) => v.toJson()).toList();
    }
    if (_language != null) {
      map['language'] = _language?.toJson();
    }
    if (_license != null) {
      map['license'] = _license?.toJson();
    }
    map['license_author'] = _licenseAuthor;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    if (_videos != null) {
      map['videos'] = _videos?.map((v) => v.toJson()).toList();
    }
    if (_comments != null) {
      map['comments'] = _comments?.map((v) => v.toJson()).toList();
    }
    map['variations'] = _variations;
    return map;
  }

}

Comments commentsFromJson(String str) => Comments.fromJson(json.decode(str));
String commentsToJson(Comments data) => json.encode(data.toJson());
class Comments {
  Comments({
      num? id, 
      num? exercise, 
      String? comment,}){
    _id = id;
    _exercise = exercise;
    _comment = comment;
}

  Comments.fromJson(dynamic json) {
    _id = json['id'];
    _exercise = json['exercise'];
    _comment = json['comment'];
  }
  num? _id;
  num? _exercise;
  String? _comment;

  num get id => _id ?? 0;
  num get exercise => _exercise ?? 0;
  String get comment => _comment ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['exercise'] = _exercise;
    map['comment'] = _comment;
    return map;
  }

}

Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));
String videosToJson(Videos data) => json.encode(data.toJson());
class Videos {
  Videos({
      num? id, 
      String? uuid, 
      num? exerciseBase, 
      String? exerciseBaseUuid, 
      String? video, 
      bool? isMain, 
      num? size, 
      String? duration, 
      num? width, 
      num? height, 
      String? codec, 
      String? codecLong, 
      num? license, 
      String? licenseAuthor, 
      List<String>? authorHistory,}){
    _id = id;
    _uuid = uuid;
    _exerciseBase = exerciseBase;
    _exerciseBaseUuid = exerciseBaseUuid;
    _video = video;
    _isMain = isMain;
    _size = size;
    _duration = duration;
    _width = width;
    _height = height;
    _codec = codec;
    _codecLong = codecLong;
    _license = license;
    _licenseAuthor = licenseAuthor;
    _authorHistory = authorHistory;
}

  Videos.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _exerciseBase = json['exercise_base'];
    _exerciseBaseUuid = json['exercise_base_uuid'];
    _video = json['video'];
    _isMain = json['is_main'];
    _size = json['size'];
    _duration = json['duration'];
    _width = json['width'];
    _height = json['height'];
    _codec = json['codec'];
    _codecLong = json['codec_long'];
    _license = json['license'];
    _licenseAuthor = json['license_author'];
  }
  num? _id;
  String? _uuid;
  num? _exerciseBase;
  String? _exerciseBaseUuid;
  String? _video;
  bool? _isMain;
  num? _size;
  String? _duration;
  num? _width;
  num? _height;
  String? _codec;
  String? _codecLong;
  num? _license;
  String? _licenseAuthor;
  List<String>? _authorHistory;

  num get id => _id ?? 0;
  String get uuid => _uuid ?? '';
  num get exerciseBase => _exerciseBase ?? 0;
  String get exerciseBaseUuid => _exerciseBaseUuid ?? '';
  String get video => _video ?? '';
  bool? get isMain => _isMain;
  num get size => _size ?? 0;
  String get duration => _duration ?? '';
  num get width => _width ?? 0;
  num get height => _height ?? 0;
  String get codec => _codec ?? '';
  String get codecLong => _codecLong ?? '';
  num get license => _license ?? 0;
  String get licenseAuthor => _licenseAuthor ?? '';
  List<String> get authorHistory => _authorHistory ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['exercise_base'] = _exerciseBase;
    map['exercise_base_uuid'] = _exerciseBaseUuid;
    map['video'] = _video;
    map['is_main'] = _isMain;
    map['size'] = _size;
    map['duration'] = _duration;
    map['width'] = _width;
    map['height'] = _height;
    map['codec'] = _codec;
    map['codec_long'] = _codecLong;
    map['license'] = _license;
    map['license_author'] = _licenseAuthor;
    return map;
  }

}

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());
class Images {
  Images({
      num? id, 
      String? uuid, 
      num? exerciseBase, 
      String? image, 
      bool? isMain, 
      String? style, 
      num? license, 
      String? licenseAuthor, 
      List<dynamic>? authorHistory,}){
    _id = id;
    _uuid = uuid;
    _exerciseBase = exerciseBase;
    _image = image;
    _isMain = isMain;
    _style = style;
    _license = license;
    _licenseAuthor = licenseAuthor;
    _authorHistory = authorHistory;
}

  Images.fromJson(dynamic json) {
    _id = json['id'];
    _uuid = json['uuid'];
    _exerciseBase = json['exercise_base'];
    _image = json['image'];
    _isMain = json['is_main'];
    _style = json['style'];
    _license = json['license'];
    _licenseAuthor = json['license_author'];
  }
  num? _id;
  String? _uuid;
  num? _exerciseBase;
  String? _image;
  bool? _isMain;
  String? _style;
  num? _license;
  String? _licenseAuthor;
  List<dynamic>? _authorHistory;

  num get id => _id ?? 0;
  String get uuid => _uuid ?? '';
  num get exerciseBase => _exerciseBase ?? 0;
  String get image => _image ?? '';
  bool? get isMain => _isMain;
  String get style => _style ?? '';
  num get license => _license ?? 0;
  String get licenseAuthor => _licenseAuthor ?? '';
  List<dynamic> get authorHistory => _authorHistory ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uuid'] = _uuid;
    map['exercise_base'] = _exerciseBase;
    map['image'] = _image;
    map['is_main'] = _isMain;
    map['style'] = _style;
    map['license'] = _license;
    map['license_author'] = _licenseAuthor;
    return map;
  }

}

License licenseFromJson(String str) => License.fromJson(json.decode(str));
String licenseToJson(License data) => json.encode(data.toJson());
class License {
  License({
      num? id, 
      String? fullName, 
      String? shortName, 
      String? url,}){
    _id = id;
    _fullName = fullName;
    _shortName = shortName;
    _url = url;
}

  License.fromJson(dynamic json) {
    _id = json['id'];
    _fullName = json['full_name'];
    _shortName = json['short_name'];
    _url = json['url'];
  }
  num? _id;
  String? _fullName;
  String? _shortName;
  String? _url;

  num get id => _id ?? 0;
  String get fullName => _fullName ?? '';
  String get shortName => _shortName ?? '';
  String get url => _url ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['full_name'] = _fullName;
    map['short_name'] = _shortName;
    map['url'] = _url;
    return map;
  }

}

Language languageFromJson(String str) => Language.fromJson(json.decode(str));
String languageToJson(Language data) => json.encode(data.toJson());
class Language {
  Language({
      num? id, 
      String? shortName, 
      String? fullName,}){
    _id = id;
    _shortName = shortName;
    _fullName = fullName;
}

  Language.fromJson(dynamic json) {
    _id = json['id'];
    _shortName = json['short_name'];
    _fullName = json['full_name'];
  }
  num? _id;
  String? _shortName;
  String? _fullName;

  num get id => _id ?? 0;
  String get shortName => _shortName ?? '';
  String get fullName => _fullName ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['short_name'] = _shortName;
    map['full_name'] = _fullName;
    return map;
  }

}

Equipment equipmentFromJson(String str) => Equipment.fromJson(json.decode(str));
String equipmentToJson(Equipment data) => json.encode(data.toJson());
class Equipment {
  Equipment({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Equipment.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;

  num get id => _id ?? 0;
  String get name => _name ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

MusclesSecondary musclesSecondaryFromJson(String str) => MusclesSecondary.fromJson(json.decode(str));
String musclesSecondaryToJson(MusclesSecondary data) => json.encode(data.toJson());
class MusclesSecondary {
  MusclesSecondary({
      num? id, 
      String? name, 
      String? nameEn, 
      bool? isFront, 
      String? imageUrlMain, 
      String? imageUrlSecondary,}){
    _id = id;
    _name = name;
    _nameEn = nameEn;
    _isFront = isFront;
    _imageUrlMain = imageUrlMain;
    _imageUrlSecondary = imageUrlSecondary;
}

  MusclesSecondary.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nameEn = json['name_en'];
    _isFront = json['is_front'];
    _imageUrlMain = json['image_url_main'];
    _imageUrlSecondary = json['image_url_secondary'];
  }
  num? _id;
  String? _name;
  String? _nameEn;
  bool? _isFront;
  String? _imageUrlMain;
  String? _imageUrlSecondary;

  num get id => _id ?? 0;
  String get name => _name ?? '';
  String get nameEn => _nameEn ?? '';
  bool get isFront => _isFront ?? false;
  String get imageUrlMain => _imageUrlMain ?? '';
  String get imageUrlSecondary => _imageUrlSecondary ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['name_en'] = _nameEn;
    map['is_front'] = _isFront;
    map['image_url_main'] = _imageUrlMain;
    map['image_url_secondary'] = _imageUrlSecondary;
    return map;
  }

}

Muscles musclesFromJson(String str) => Muscles.fromJson(json.decode(str));
String musclesToJson(Muscles data) => json.encode(data.toJson());
class Muscles {
  Muscles({
      num? id, 
      String? name, 
      String? nameEn, 
      bool? isFront, 
      String? imageUrlMain, 
      String? imageUrlSecondary,}){
    _id = id;
    _name = name;
    _nameEn = nameEn;
    _isFront = isFront;
    _imageUrlMain = imageUrlMain;
    _imageUrlSecondary = imageUrlSecondary;
}

  Muscles.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _nameEn = json['name_en'];
    _isFront = json['is_front'];
    _imageUrlMain = json['image_url_main'];
    _imageUrlSecondary = json['image_url_secondary'];
  }
  num? _id;
  String? _name;
  String? _nameEn;
  bool? _isFront;
  String? _imageUrlMain;
  String? _imageUrlSecondary;

  num get id => _id ?? 0;
  String get name => _name ?? '';
  String get nameEn => _nameEn ?? '';
  bool get isFront => _isFront ?? false;
  String get imageUrlMain => _imageUrlMain ?? '';
  String get imageUrlSecondary => _imageUrlSecondary ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['name_en'] = _nameEn;
    map['is_front'] = _isFront;
    map['image_url_main'] = _imageUrlMain;
    map['image_url_secondary'] = _imageUrlSecondary;
    return map;
  }

}

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;

  num get id => _id ?? 0;
  String get name => _name ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}