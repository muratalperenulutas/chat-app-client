import 'package:flutter/material.dart';

import '../../../constants/enums/status.dart';

IconData StatusIconPicker(Status status) {
  switch (status) {
    case Status.CREATED:
      return Icons.access_time_sharp;
    case Status.PENDING:
      return Icons.access_time_sharp;
    case Status.FAILED:
    // TODO: Handle this case.
    case Status.SYNC:
      return Icons.check;
  }
}
