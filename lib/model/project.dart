import 'package:makemywindoor_admin/model/project_details.dart';
import 'package:makemywindoor_admin/model/project_dimens.dart';
import 'package:makemywindoor_admin/model/user.dart';

class Project {
  String projectID;
  ProjectDetails projectDetails;
  List<ProjectDimensions> projectDimensions;
  int totalCost;
  double totalCharge;
  DateTime createdOn;
  User createdBy;
  String status;

  Project(
      {required this.projectID,
      required this.projectDetails,
      required this.projectDimensions,
      required this.totalCost,
      required this.totalCharge,
      required this.createdOn,
      required this.createdBy,
      required this.status});

  factory Project.empty() {
    return Project(
        projectID: '',
        projectDetails: ProjectDetails.empty(),
        projectDimensions: [],
        totalCost: 0,
        totalCharge: 0.0,
        createdOn: DateTime.now(),
        createdBy: User.empty(),
        status: '');
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
        projectID: map['projectID'],
        projectDetails: ProjectDetails.fromMap(map['projectDetails']),
        projectDimensions: map['projectDimensions']
            .map<ProjectDimensions>(
                (dynamic item) => ProjectDimensions.fromMap(item))
            .toList(),
        totalCost: map['totalCost'],
        totalCharge: map['totalCharge'] as double,
        createdOn: DateTime.parse(map['createdOn']),
        createdBy: User.fromMap(map['createdBy']),
        status: map['status']);
  }

  Map<String, dynamic> toMap() {
    return {
      'projectID': projectID,
      'projectDetails': projectDetails.toMap(),
      'projectDimensions': projectDimensions
          .map<Map<String, dynamic>>((ProjectDimensions item) => item.toMap())
          .toList(),
      'totalCost': totalCost,
      'totalCharge': totalCharge,
      'createdOn': createdOn.toIso8601String(),
      'createdBy': createdBy.toMap(),
      'status': status
    };
  }

  @override
  String toString() {
    return 'Project{projectID: $projectID, projectDetails: $projectDetails, projectDimensions: $projectDimensions, totalCost: $totalCost, totalCharge: $totalCharge, createdOn: $createdOn, createdBy: $createdBy, status: $status}';
  }
}
