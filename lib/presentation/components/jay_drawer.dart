import 'dart:developer';

import 'package:app/application/bloc/alarms/alert_bloc.dart';
import 'package:app/application/bloc/feedback/feedback_bloc.dart';
import 'package:app/application/bloc/settings/version/app_version_bloc.dart';
import 'package:app/application/cubit/login/login_cubit.dart';
import 'package:app/application/cubit/logout/logout_cubit.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/event_history_list.dart';
import 'package:app/presentation/pages/settings_page.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class JayDrawer extends StatelessWidget {
  final String name;
  final String email;
  final int memberId;
  final String? functionName;
  final Function onSettingsChanged;
  final String mapSettings;

  const JayDrawer({
    super.key,
    required this.name,
    required this.memberId,
    required this.email,
    this.functionName,
    required this.onSettingsChanged,
    required this.mapSettings,
  });

  @override
  Widget build(final BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<AppVersionBloc>(
            create: (final context) =>
                AppVersionBloc()..add(AppVersionStarted()),
          ),
          BlocProvider<AlertBloc>(
            create: (final context) => AlertBloc()..add(AlertStarted()),
          ),
          BlocProvider<LogoutCubit>(create: (final context) => LogoutCubit()),
        ],
        child: SafeArea(
          child: Drawer(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                DrawerHeader(

                  padding: const EdgeInsets.all(0),
                  decoration: const BoxDecoration(
                      color: JayColors.primaryLight,
                      gradient: LinearGradient(colors: [
                        JayColors.primary,
                        JayColors.primary,
                        JayColors.primaryLight
                      ])),
                  child: Stack(children: [
                   Transform.flip(flipX: true,
                     child: Opacity(
                       opacity: 0.1,
                       child: Image.asset(
                         fit: BoxFit.fill,
                         'assets/zasah.png',
                       ),
                     ),
                   ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 16, left: 12),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 12, left: 8),
                              child: Column(
                                children: [
                                  Text(
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                    name,
                                  ),
                                  if (functionName != null)
                                    Text(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                      functionName!,
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.eventHistory),
                  onTap: () {
                    // close the drawer
                    Navigator.of(context, rootNavigator: true).pop();
                    showModalBottomSheet(
                      enableDrag: false,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (final context) => Container(
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  padding: const EdgeInsets.all(12),
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pop();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    size: 32,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Historie událostí',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    const Text(
                                      'Starší než 24 hodin',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 8),
                              height: MediaQuery.of(context).size.height * 0.75,
                              child: EventHistoryList(
                                mapSettings: mapSettings,
                                memberId: memberId,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    /*
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (final context) => EventHistoryList(
                          memberId: memberId,
                        ),
                      ),
                    );

                     */
                  },
                ),
                const Divider(),
                ListTile(
                  title: Text(AppLocalizations.of(context)!.settings),
                  onTap: () async {
                    // Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (final context) => const SettingsPage(),
                      ),
                    );
                    onSettingsChanged.call();
                  },
                ),
                ListTile(
                  title: const Text('O aplikaci'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (final context) => Dialog(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: const EdgeInsets.all(24),
                              child: Text(
                                'O aplikaci',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                bottom: 24,
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*
                                      Row(
                                        children: [
                                          Image.network(
                                            "https://www.telwork.cz/JAYAdmin/assets/images/logo-light-icon.png",
                                            width: 24,
                                            color: JayColors.blue,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "TELwork",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),*/
                                  Text(
                                    'Aplikace slouží k rychlému svolávání a informování jednotek JSDH v rámci systému JAY. Je určena výhradně pro hasičské jednotky integrované v tomto systému. Pro správnou funkčnost je nutné ji registrovat v systému JAY a nastavit v mobilním zařízení. Funkčnost se může lišit podle typu telefonu a operačního systému.\n\nAplikaci vyvinula společnost TELwork, s.r.o.\n\nPro technickou podporu kontaktujte:\ne-mail: info@telwork.cz\ntelefon: +420\u{00A0}773\u{00A0}319\u{00A0}297.',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Podmínky použití'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (final context) => AlertDialog(
                        title: Container(
                          margin: const EdgeInsets.all(24),
                          child: Text(
                            'Podmínky použití',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        scrollable: true,
                        content: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                left: 24,
                                right: 24,
                                bottom: 24,
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /*
                                      Row(
                                        children: [
                                          Image.network(
                                            "https://www.telwork.cz/JAYAdmin/assets/images/logo-light-icon.png",
                                            width: 24,
                                            color: JayColors.blue,
                                          ),
                                          SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            "TELwork",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),*/
                                  Text(
                                    '''1. Použití aplikace
Aplikace je poskytována výhradně pro účely, ke kterým byla určena. Jste povinni používat aplikaci v souladu s těmito podmínkami a platnými právními předpisy. Jakékoliv neoprávněné použití aplikace je zakázáno, včetně, ale ne omezeno na, zpětnou analýzu, dekompilaci nebo jakýkoli jiný pokus o získání zdrojového kódu aplikace.
            
2. Registrace a bezpečnost účtu
Používání aplikace může vyžadovat registraci a vytvoření uživatelského účtu. Jste zodpovědní za zajištění důvěrnosti vašich přístupových údajů a za všechny aktivity prováděné prostřednictvím vašeho účtu. Poskytovatel nenese odpovědnost za jakékoliv zneužití vašeho účtu.
            
3. Aktualizace a dostupnost
Poskytovatel si vyhrazuje právo aplikaci kdykoli aktualizovat nebo změnit její funkcionalitu. Takové změny mohou zahrnovat úpravy rozhraní, přidávání funkcí nebo opravy chyb. Poskytovatel nezaručuje, že aplikace bude vždy dostupná bez přerušení, chyb nebo omezení.
            
4. Odpovědnost a záruky
Aplikace je poskytována „tak, jak je“, bez jakýchkoliv záruk, výslovných či implicitních. Poskytovatel neodpovídá za škody způsobené nesprávným použitím aplikace, technickými problémy, nekompatibilitou zařízení nebo chybami v přenosu dat.
            
5. Autorská práva
Aplikace a veškerý její obsah (včetně, ale ne omezeno na texty, grafiku, loga, ikony, zvuky a software) jsou chráněny autorským právem a dalšími právními předpisy o ochraně duševního vlastnictví. Jakékoliv kopírování, distribuce, úprava nebo jiná forma využití obsahu aplikace bez předchozího písemného souhlasu poskytovatele je zakázána.
            
6. Sběr a zpracování osobních údajů
Používání aplikace může vyžadovat poskytnutí osobních údajů. Poskytovatel se zavazuje zpracovávat osobní údaje v souladu s platnými právními předpisy a zásadami ochrany osobních údajů, které jsou dostupné v samostatné sekci aplikace.
            
7. Ukončení používání
Poskytovatel si vyhrazuje právo omezit nebo ukončit váš přístup k aplikaci kdykoliv a bez předchozího upozornění, zejména v případě porušení těchto podmínek.
            
8. Změny podmínek
Poskytovatel si vyhrazuje právo kdykoli změnit tyto podmínky použití. O jakýchkoliv změnách budete informováni prostřednictvím aplikace nebo e-mailem.
            
9. Kontaktní informace
Pro jakékoliv dotazy nebo problémy týkající se těchto podmínek nebo aplikace nás kontaktujte na e-mailové adrese info@telwork.cz nebo na telefonním čísle +420\u{00A0}773\u{00A0}319\u{00A0}297.
                                          ''',
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('Zpětná vazba'),
                  onTap: () {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder: (final context) {
                        TextEditingController controller =
                            TextEditingController();
                        final feedbackBloc = FeedbackBloc();
                        return BlocProvider(
                          create: (final BuildContext context) => feedbackBloc,
                          child: BlocListener<FeedbackBloc, FeedbackState>(
                            listener: (final BuildContext context,
                                final FeedbackState state) {
                              log('FAJLOZA: ');
                              if (state is FeedbackSentSuccess) {
                                SnackBarUtils.show(
                                  context,
                                  'Děkujeme za zpětnou vazbu!',
                                  Colors.blueAccent,
                                );

                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                              }
                              if (state is FeedbackSentFailed) {
                                log('FAJLOZA: ' + state.statusCode);
                                SnackBarUtils.show(
                                  context,
                                  'Odeslání zpětné vazby se nezdařilo.',
                                  Colors.red,
                                );

                                Navigator.of(
                                  context,
                                  rootNavigator: true,
                                ).pop();
                              }
                            },
                            child: BlocBuilder<FeedbackBloc, FeedbackState>(
                              builder: (context, state) => SimpleDialog(
                                title: const Text('Odeslat zpětnou vazbu'),
                                children: [
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: 0,
                                    ),
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: controller,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            labelText: 'Text',
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(
                                                  context,
                                                  rootNavigator: true,
                                                ).pop();
                                              },
                                              child: const Text('Zavřít'),
                                            ),
                                            if (state is FeedbackSentInProgress)
                                              CircularProgressIndicator(),
                                            if (state is FeedbackInitial)
                                              TextButton(
                                                onPressed: () {
                                                  final text = controller.text
                                                      .toString();
                                                  final noWhitespacesText =
                                                      text.replaceAll(' ', '');
                                                  if (noWhitespacesText.length <
                                                      10) {
                                                    SnackBarUtils.show(
                                                      context,
                                                      'Zpráva musí mít alespoň 10 znaků.',
                                                      Colors.red,
                                                    );
                                                  } else {
                                                    feedbackBloc.add(
                                                      SendFeedback(
                                                        email: email,
                                                        type: 0,
                                                        message:
                                                            '${controller.text}\n\nsubscriptionId: ${OneSignal.User.pushSubscription.id}\nid: $memberId $name',
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: const Text('Odeslat'),
                                              ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Builder(
                  builder: (final context) =>
                      BlocListener<LogoutCubit, LogoutState>(
                    listener: (final context, final state) {
                      if (state is LogoutSuccess) {
                        context.pop();
                        context.read<LoginCubit>().checkAuth();
                      }
                    },
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.logout),
                      onTap: () {
                        final loginCubit = context.read<LoginCubit>();
                        showDialog(
                          context: context,
                          builder: (final context) => SimpleDialog(
                            title: const Text('Odhlášení'),
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  bottom: 0,
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Opravdu chcete toto zařízení odhlásit?',
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                          },
                                          child: const Text('Zavřít'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                            loginCubit.logout();
                                          },
                                          child: const Text('Odhlásit'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const Spacer(),
                BlocBuilder<AppVersionBloc, AppVersionState>(
                  builder: (final context, final state) {
                    if (state is AppVersionLoadSuccess) {
                      return Padding(
                        padding: EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'JAY ' +
                                  (kDebugMode ? 'DEBUG ' : '') +
                                  'verze ' +
                                  state.appVersion +
                                  (kDebugMode
                                      ? ' (' +
                                          state.buildNumber.toString() +
                                          ')'
                                      : ''),
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                          mainAxisSize: MainAxisSize.max,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
