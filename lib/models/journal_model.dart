// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';
part 'journal_model.g.dart';

@JsonSerializable(createToJson: false)
class Journal{
  final String title;
  final PublicationInfo publication_info;
  final Resources resources;


Journal({
    required this.title,
    required this.publication_info,
    required this.resources
  });

  factory Journal.fromJson(Map<String, dynamic> json) => _$JournalFromJson(json);
}

@JsonSerializable(createToJson: false)
class PublicationInfo {
  final String summary;

PublicationInfo({required this.summary});

  factory PublicationInfo.fromJson(Map<String, dynamic> json) => _$PublicationInfoFromJson(json);
}

@JsonSerializable(createToJson: false)
class Resources {
  @JsonKey(defaultValue: 'Unknown')
  final String link;

Resources({required this.link});

  factory Resources.fromJson(Map<String, dynamic> json) => _$ResourcesFromJson(json);
}

