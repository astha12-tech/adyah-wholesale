// To parse this JSON data, do
//
//     final getBlogModel = getBlogModelFromJson(jsonString);

import 'dart:convert';

List<GetBlogModel> getBlogModelFromJson(String str) => List<GetBlogModel>.from(json.decode(str).map((x) => GetBlogModel.fromJson(x)));

String getBlogModelToJson(List<GetBlogModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetBlogModel {
    int? id;
    String? author;
    String? title;
    String? body;
    String? summary;
    PublishedDate? publishedDate;
    String? publishedDateIso8601;
    bool? isPublished;
    List<dynamic>? tags;
    String? metaDescription;
    String? metaKeywords;
    String? thumbnailPath;
    String? url;
    String? previewUrl;

    GetBlogModel({
        this.id,
        this.author,
        this.title,
        this.body,
        this.summary,
        this.publishedDate,
        this.publishedDateIso8601,
        this.isPublished,
        this.tags,
        this.metaDescription,
        this.metaKeywords,
        this.thumbnailPath,
        this.url,
        this.previewUrl,
    });

    factory GetBlogModel.fromJson(Map<String, dynamic> json) => GetBlogModel(
        id: json["id"],
        author: json["author"],
        title: json["title"],
        body: json["body"],
        summary: json["summary"],
        publishedDate: json["published_date"] == null ? null : PublishedDate.fromJson(json["published_date"]),
        publishedDateIso8601: json["published_date_iso8601"],
        isPublished: json["is_published"],
        tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        thumbnailPath: json["thumbnail_path"],
        url: json["url"],
        previewUrl: json["preview_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "body": body,
        "summary": summary,
        "published_date": publishedDate?.toJson(),
        "published_date_iso8601": publishedDateIso8601,
        "is_published": isPublished,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "thumbnail_path": thumbnailPath,
        "url": url,
        "preview_url": previewUrl,
    };
}

class PublishedDate {
    DateTime? date;
    int? timezoneType;
    String? timezone;

    PublishedDate({
        this.date,
        this.timezoneType,
        this.timezone,
    });

    factory PublishedDate.fromJson(Map<String, dynamic> json) => PublishedDate(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timezoneType: json["timezone_type"],
        timezone: json["timezone"],
    );

    Map<String, dynamic> toJson() => {
        "date": date?.toIso8601String(),
        "timezone_type": timezoneType,
        "timezone": timezone,
    };
}
