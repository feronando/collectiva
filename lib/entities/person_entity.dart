class Person {
  int? id;
  String? name;
  String? cpf;

  Person({this.id, this.name, this.cpf});

  Person.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    cpf = json['cpf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cpf'] = this.cpf;

    return data;
  }
}
