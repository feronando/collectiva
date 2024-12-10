class Event {
  int? id;
  String? name;
  String? location;
  String? description;
  String? category;
  DateTime? startDate;
  DateTime? endDate;

  Event({
    this.id,
    this.name,
    this.location,
    this.description,
    this.category,
    this.startDate,
    this.endDate
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    description = json['description'];
    category = json['category'];
    startDate = DateTime.tryParse(json['startDate'] ?? '');
    endDate = DateTime.tryParse(json['endDate'] ?? '');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['location'] = location;
    data['description'] = description;
    data['category'] = category;
    data['startDate'] = startDate?.toIso8601String();
    data['endDate'] = endDate?.toIso8601String();

    return data;
  }
}
