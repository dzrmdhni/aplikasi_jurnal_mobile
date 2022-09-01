// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journal _$JournalFromJson(Map<String, dynamic> json) => Journal(
      title: json['title'] as String,
      publication_info: PublicationInfo.fromJson(
          json['publication_info'] as Map<String, dynamic>),
      resources: Resources.fromJson(json['resources'] as Map<String, dynamic>),
    );

PublicationInfo _$PublicationInfoFromJson(Map<String, dynamic> json) =>
    PublicationInfo(
      summary: json['summary'] as String,
    );

Resources _$ResourcesFromJson(Map<String, dynamic> json) => Resources(
      link: json['link'] as String? ?? 'Unknown',
    );
