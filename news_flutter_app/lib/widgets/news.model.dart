class NewsModel {
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

List categories = [
  "general",
  "business",
  "entertainment",
  "health",
  "sports",
  "technology",
  "science",
];

const String access_key = "5e2f7e588bdf512b832cff86a7c9a0de";
