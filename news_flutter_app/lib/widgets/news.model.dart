class NewsModel {
  String name;
  String? details;
  String? content;
  String? image;
  String? video;
  String? time;
  String? publishedAt;

  NewsModel(
    this.name, {
    this.details,
    this.image,
    this.video,
    this.time,
    this.publishedAt,
  });
}
