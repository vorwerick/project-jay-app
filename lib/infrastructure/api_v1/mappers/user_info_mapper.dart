import 'package:app/domain/user/entity/user.dart';
import 'package:app/infrastructure/api_v1/models/json/user/user_info.dart';

final class UserInfoJsonMapper {
  final UserInfo _userInfo;

  UserInfoJsonMapper(this._userInfo);

  User toEntity() => User.create(
        id: _userInfo.id ?? 0,
        name: _userInfo.name,
        surname: _userInfo.surname,
        academicTitle: _userInfo.title,

      );
}
