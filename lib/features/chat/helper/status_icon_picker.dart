import 'package:flutter/material.dart';

import '../../../constants/enums/status.dart';

IconData statusIconPicker(Status status) {
  switch (status) {
    case Status.created:
      return Icons.access_time_sharp;
    case Status.pending:
      return Icons.access_time_sharp;
    case Status.failed:
    // TODO: Handle this case.
    case Status.sync:
      return Icons.check;
  }
}
