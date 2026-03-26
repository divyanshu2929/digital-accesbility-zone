class Building {

  String name;
  int floors;
  double length;
  double width;

  Building(this.name, this.floors, this.length, this.width);

  Map<String, dynamic> toJson() => {
    "name": name,
    "floors": floors,
    "length": length,
    "width": width
  };

  factory Building.fromJson(Map<String, dynamic> json) {

    return Building(
      json["name"],
      json["floors"],
      json["length"],
      json["width"],
    );

  }

}