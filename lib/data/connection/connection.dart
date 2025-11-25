// This file is just a stub that conditionally exports the correct
// database connection implementation based on the platform

export 'unsupported.dart'
    if (dart.library.io) 'native.dart'
    if (dart.library.html) 'web.dart';
