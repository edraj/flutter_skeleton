class EserArabic {
  String type;
  String makam;
  String bestekar;
  String performer;

  EserArabic({
    required this.type,
    required this.makam,
    required this.bestekar,
    required this.performer,
  });

  factory EserArabic.fromJson(Map<String, dynamic> json) {
    return EserArabic(
      type: json['type'],
      makam: json['makam'],
      bestekar: json['bestekar'],
      performer: json['performer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'makam': makam,
      'bestekar': bestekar,
      'performer': performer,
    };
  }
}
