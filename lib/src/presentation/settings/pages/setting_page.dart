import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sika_purse/src/presentation/settings/widgets/small_size_fab_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../main.dart';
import '../../../app/routes.dart';
import '../../../core/common.dart';
import '../../../core/enum/box_types.dart';
import '../../../core/enum/theme_mode.dart';
import '../../../data/settings/authenticate.dart';
import '../../widgets/choose_theme_mode_widget.dart';
import '../../widgets/sika_purse_annotate_region_widget.dart';
import '../widgets/accounts_style_widget.dart';
import '../widgets/biometrics_auth_widget.dart';
import '../widgets/currency_change_widget.dart';
import '../widgets/setting_option.dart';
import '../widgets/settings_color_picker_widget.dart';
import '../widgets/settings_group_card.dart';
import '../widgets/version_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = getIt.get<Box<dynamic>>(
      instanceName: BoxType.settings.name,
    );
    final currentTheme = ThemeMode
        .values[getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name).get(themeModeKey, defaultValue: 0)];
    return SikaPurseAnnotatedRegionWidget(
      color: context.background,
      child: Scaffold(
        appBar: context.materialYouAppBar(
          context.loc.settings,
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            SettingsGroup(
              title: context.loc.colorsUI,
              options: [
                SettingsColorPickerWidget(settings: settings),
                const Divider(),
                SettingsOption(
                  title: context.loc.chooseTheme,
                  subtitle: currentTheme.themeName,
                  onTap: () {
                    showModalBottomSheet(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width >= 700 ? 700 : double.infinity,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      context: context,
                      builder: (_) => ChooseThemeModeWidget(
                        currentTheme: currentTheme,
                      ),
                    );
                  },
                ),
                const Divider(),
                const AccountsStyleWidget(),
                const Divider(),
                const SmallSizeFabWidget(),
              ],
            ),
            SettingsGroup(
              title: context.loc.others,
              options: [
                BiometricAuthWidget(
                  authenticate: getIt.get<Authenticate>(),
                ),
                const CurrencyChangeWidget(),
                const Divider(),
                SettingsOption(
                  title: context.loc.backupAndRestoreTitle,
                  subtitle: context.loc.backupAndRestoreSubTitle,
                  onTap: () {
                    GoRouter.of(context).goNamed(exportAndImportName);
                  },
                ),
              ],
            ),
            SettingsGroup(
              title: context.loc.socialLinks,
              options: [
                const Divider(),
                SettingsOption(
                  title: context.loc.privacyPolicy,
                  onTap: () => launchUrl(
                    Uri.parse('termsAndConditionsUrl'),
                    mode: LaunchMode.externalApplication,
                  ),
                ),
                const Divider(),
                const VersionWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
