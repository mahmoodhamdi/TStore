import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String? title;
  final String? subtitle;
  final String? actionUrl;
  final String? actionType;
  final int sortOrder;
  final bool isActive;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;

  const BannerEntity({
    required this.id,
    required this.imageUrl,
    this.title,
    this.subtitle,
    this.actionUrl,
    this.actionType,
    this.sortOrder = 0,
    this.isActive = true,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  bool get isCurrentlyActive {
    if (!isActive) return false;
    final now = DateTime.now();
    if (startDate != null && now.isBefore(startDate!)) return false;
    if (endDate != null && now.isAfter(endDate!)) return false;
    return true;
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        title,
        subtitle,
        actionUrl,
        actionType,
        sortOrder,
        isActive,
        startDate,
        endDate,
        createdAt,
      ];

  BannerEntity copyWith({
    String? id,
    String? imageUrl,
    String? title,
    String? subtitle,
    String? actionUrl,
    String? actionType,
    int? sortOrder,
    bool? isActive,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? createdAt,
  }) {
    return BannerEntity(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      actionUrl: actionUrl ?? this.actionUrl,
      actionType: actionType ?? this.actionType,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
