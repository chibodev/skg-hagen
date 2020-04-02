import 'package:flutter/material.dart';
import 'package:skg_hagen/src/offer/model/project.dart' as Model;
import 'package:skg_hagen/src/offer/view/projects.dart' as View;

class ProjectsController extends StatefulWidget {
  final Model.Project project;
  final bool dataAvailable;
  final BuildContext context;

  const ProjectsController(
      {Key key,
      this.context,
      @required this.project,
      this.dataAvailable = true})
      : super(key: key);

  @override
  View.Projects createState() => View.Projects();
}
