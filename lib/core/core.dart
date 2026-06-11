import 'package:catimage/core/constants/constants.dart';
import 'package:catimage/core/theme/color.dart';
import 'package:catimage/core/theme/theme.dart';

import 'utils/utils.dart';

abstract class Core {
  static AppColors colors = AppColors();
  static const Constants constants = Constants();
  static AppTheme theme = AppTheme();
  static Utils utils = Utils();
}
