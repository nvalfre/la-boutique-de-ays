import 'dart:convert';

BannerLanding bannerLandingFromJson(String str) => BannerLanding.fromJson(json.decode(str));

String bannerLandingToJson(BannerLanding data) => json.encode(data.toJson());

class BannerLanding {
  BannerLanding({
    this.id,
    this.name,
    this.landingUrl,
    this.startDate,
    this.endDate,
  });

  String id;
  String name;
  String landingUrl;
  String startDate;
  String endDate;

  factory BannerLanding.fromJson(Map<String, dynamic> json) => BannerLanding(
    id: json["id"],
    name: json["name"],
    landingUrl: json["landing_url"],
    startDate: json["start_date"],
    endDate: json["end_date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "landing_url": landingUrl,
    "start_date": startDate,
    "end_date": endDate,
  };
}
