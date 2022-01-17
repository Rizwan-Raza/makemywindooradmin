class ProjectDimensions {
  String dimensionID;
  int height;
  int width;
  int esft;
  int rate;
  String? remarks;
  String type;

  factory ProjectDimensions.empty() => ProjectDimensions(
        dimensionID: '',
        height: 0,
        width: 0,
        esft: 0,
        rate: 0,
        remarks: '',
        type: '',
      );

  ProjectDimensions({
    required this.dimensionID,
    required this.height,
    required this.width,
    required this.esft,
    required this.rate,
    this.remarks,
    required this.type,
  });

  factory ProjectDimensions.fromMap(Map<String, dynamic> json) =>
      ProjectDimensions(
        dimensionID: json["dimensionID"],
        height: json["height"],
        width: json["width"],
        esft: json["esft"],
        rate: json["rate"],
        remarks: json["remarks"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "dimensionID": dimensionID,
        "height": height,
        "width": width,
        "esft": esft,
        "rate": rate,
        "remarks": remarks,
        "type": type,
      };

  @override
  String toString() {
    return 'ProjectDimensions{dimensionID: $dimensionID, height: $height, width: $width, esft: $esft, rate: $rate, remarks: $remarks, type: $type}';
  }
}
