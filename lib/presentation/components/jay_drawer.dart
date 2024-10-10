import 'package:app/application/bloc/alarms/alert_bloc.dart';
import 'package:app/application/bloc/settings/version/app_version_bloc.dart';
import 'package:app/application/bloc/user/user_bloc.dart';
import 'package:app/application/cubit/login/login_cubit.dart';
import 'package:app/application/cubit/logout/logout_cubit.dart';
import 'package:app/presentation/common/jay_colors.dart';
import 'package:app/presentation/pages/event_history_list.dart';
import 'package:app/presentation/pages/settings_page.dart';
import 'package:app/presentation/utils/snack_bar_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

// TODO(vojjta): implement params for drawer
class JayDrawer extends StatelessWidget {
  final String name;
  final int memberId;

  const JayDrawer({super.key, required this.name, required this.memberId});

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
            child: Container(
              child: Column(
                children: [
                  DrawerHeader(
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: JayColors.primaryLight,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BlocBuilder<UserBloc, UserState>(
                          builder: (final context, final state) {
                            if (state is UserLoadSuccess) {
                              return Container(
                                margin: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      child: SvgPicture.asset(
                                        'assets/firefighter-avatar.svg',
                                        semanticsLabel: 'Firefighter avatar',
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(),
                                          state.fullName,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is UserLoadFailure) {
                              return Center(
                                child: Text(
                                  AppLocalizations.of(context)!.checkConnection,
                                ),
                              );
                            }

                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        /*
                          BlocBuilder<AlertBloc, AlertState>(
                            builder: (final context, final state) {
                              if (state is CurrentAlertsState) {
                                return state.alerts.isEmpty
                                    ? Container(
                                        margin: EdgeInsets.all(16),
                                        color: JayColors.primary,
                                        child: Text(
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                  color: JayColors.secondary,
                                                  fontWeight:
                                                      FontWeight.normal),
                                          'žádný poplach',
                                        ),
                                      )
                                    : Container(
                                        color: JayColors.secondary,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/megaphone.svg",
                                              color: JayColors.primary,
                                            ),
                                            Text(
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .copyWith(
                                                      color: JayColors.primary,
                                                      fontWeight:
                                                          FontWeight.bold),
                                              'poplach!',
                                            ),
                                          ],
                                        ),
                                      );
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),*/
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.eventHistory),
                    onTap: () {
                      // close the drawer
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (final context) => const EventHistoryList(),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: Text(AppLocalizations.of(context)!.settings),
                    onTap: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (final context) => const SettingsPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    title: const Text('O aplikaci'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (final context) {
                          return Dialog(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  margin: const EdgeInsets.all(24),
                                  child: Text(
                                    'O aplikaci',
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    left: 24,
                                    right: 24,
                                    bottom: 24,
                                  ),
                                  child: const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                          );
                        },
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
                                    Text('''
1. Použití aplikace
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
                                            '''),
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
                    title: Text('Zpětná vazba'),
                    onTap: () {
                      Navigator.pop(context);
                      showDialog(
                        context: context,
                        builder: (final context) {
                          TextEditingController controller =
                              TextEditingController();
                          return SimpleDialog(
                            title: const Text('Odeslat zpětnou vazbu'),
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 0),
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
                                    SizedBox(
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
                                          onPressed: () async {
                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).pop();
                                            await Sentry.captureUserFeedback(
                                                SentryUserFeedback(
                                                    eventId: SentryId.newId(),
                                                    comments: controller.text,
                                                    name: '$name ($memberId)',
                                                    email: OneSignal.User
                                                        .pushSubscription.id));
                                            SnackBarUtils.show(context,"Děkujeme za zpětnou vazbu!",Colors.blueAccent);
                                          },
                                          child: const Text('Odeslat'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                          showDialog(
                            context: context,
                            builder: (final context) => SimpleDialog(
                              title: const Text('Odhlášení'),
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 20, right: 20, bottom: 0),
                                  child: Column(
                                    children: [
                                      const Text(
                                        'Opravdu chcete toto zařízení odhlásit?',
                                      ),
                                      SizedBox(
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
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).pop();
                                              context
                                                  .read<LogoutCubit>()
                                                  .logout();
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
                  if (kDebugMode)
                    ListTile(
                      title: const Text('Debug'),
                      onTap: () async {
                        final prefs = await SharedPreferences.getInstance();

                        String g = prefs.getString('notifications') ?? '';
                        showAboutDialog(
                          context: context,
                          children: [
                            Text(
                              g,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      );
}
