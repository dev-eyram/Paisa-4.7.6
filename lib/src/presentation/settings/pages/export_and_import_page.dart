import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../../../main.dart';
import '../../../core/common.dart';
import '../../widgets/sika_purse_annotate_region_widget.dart';
import '../cubit/data_cubit.dart';
import '../widgets/settings_group_card.dart';

class ExportAndImportPage extends StatelessWidget {
  const ExportAndImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DataCubit dataCubit = getIt.get();
    return SikaPurseAnnotatedRegionWidget(
      color: context.background,
      child: BlocListener(
        bloc: dataCubit,
        listener: (context, state) {
          if (state is DataSuccessState) {
            context.showMaterialSnackBar(context.loc.restoringBackupSuccess);
          } else if (state is DataError) {
            context.showMaterialSnackBar(state.error);
          } else if (state is DataLoadingState) {
            context.showMaterialSnackBar(
              state.isLoadingImport ? context.loc.restoringBackup : context.loc.creatingBackup,
            );
          } else if (state is DataExportState) {
            context.showMaterialSnackBar(context.loc.creatingBackupSuccess);
          }
        },
        child: Scaffold(
          appBar: context.materialYouAppBar(context.loc.backupAndRestoreTitle, actions: [
            BlocBuilder(
              bloc: dataCubit,
              builder: (context, state) {
                if (state is DataLoadingState) {
                  return const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            const SizedBox(width: 16),
          ]),
          body: ListView(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              SettingsGroup(
                title: context.loc.backupAndRestoreJSONTitle,
                options: [
                  ListTile(
                    title: Text(context.loc.backupAndRestoreJSONDesc),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: context.primary,
                              elevation: 0,
                              padding: const EdgeInsets.all(10),
                            ),
                            onPressed: () => dataCubit.importDataFromJson(),
                            label: Text(context.loc.importData),
                            icon: const Icon(MdiIcons.fileImport),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: context.onPrimary,
                              backgroundColor: context.primary,
                              padding: const EdgeInsets.all(10),
                            ),
                            onPressed: () => dataCubit.exportDataToJson(),
                            label: Text(context.loc.exportData),
                            icon: const Icon(MdiIcons.fileExport),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
