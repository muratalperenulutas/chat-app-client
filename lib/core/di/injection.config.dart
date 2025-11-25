// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/collectivity/collectivity_repository.dart' as _i865;
import '../../data/database_service.dart' as _i1049;
import '../../data/message/message_repository.dart' as _i260;
import '../../data/participant/participant_repository.dart' as _i341;
import '../../data/person/person_repository.dart' as _i841;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1049.DatabaseService>(() => _i1049.DatabaseService());
    gh.singleton<_i341.ParticipantRepository>(
        () => _i341.ParticipantRepository());
    gh.singleton<_i865.CollectivityRepository>(
        () => _i865.CollectivityRepository(gh<_i1049.DatabaseService>()));
    gh.singleton<_i260.MessageRepository>(
        () => _i260.MessageRepository(gh<_i1049.DatabaseService>()));
    gh.singleton<_i841.PersonRepository>(
        () => _i841.PersonRepository(gh<_i1049.DatabaseService>()));
    return this;
  }
}
