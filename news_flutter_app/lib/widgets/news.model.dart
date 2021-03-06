class NewsModel {
  static List favourites = [];
  //
  String title;
  String? description;
  String? content;
  String? image;
  String? video;
  String? time;
  String? published_at;
  String? category;
  String? author;
  String? url;
  String? source;
  String? country;

  NewsModel(
    this.title, {
    this.description,
    this.image,
    this.video,
    this.time,
    this.published_at,
    this.category,
    this.author,
    this.url,
    this.source,
    this.country,
  });
}

class ProfileModel {
  String? imageUrl;
  String? name;
  String? uid;
  String? address;
  String? card_number;

  ProfileModel({
    this.name,
    this.address,
    this.imageUrl,
    this.uid,
    this.card_number,
  });
}

List categories = [
  "general",
  "business",
  "entertainment",
  "health",
  "sports",
  "technology",
  "science",
];

const String access_key = "af2d46399491eaecdb98e704c325e3ac";
