import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:not_so_secret/app/app_prefs.dart';
import 'package:not_so_secret/app/di.dart';
import 'package:not_so_secret/presentation/common/state_renderer/state_render_impl.dart';
import 'package:not_so_secret/presentation/register/register_viewmodel.dart';
import 'package:not_so_secret/presentation/resources/assets_manager.dart';
import 'package:not_so_secret/presentation/resources/color_manager.dart';
import 'package:not_so_secret/presentation/resources/font_manager.dart';
import 'package:not_so_secret/presentation/resources/routes_manager.dart';
import 'package:not_so_secret/presentation/resources/strings_manager.dart';
import 'package:not_so_secret/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameTextEditingController =
      TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
    _userNameTextEditingController.addListener(() {
      _viewModel.setUserName(_userNameTextEditingController.text);
    });
    _passwordTextEditingController.addListener(() {
      _viewModel.setPassword(_passwordTextEditingController.text);
    });

    _viewModel.isUserRegisterInSuccessfullyStreamController.stream
        .listen((value) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        if (value) {
          const snackBar =
                SnackBar(content: Text("Kullanıcı başarı ile kayıt oldu"),duration: Duration(seconds: 1,milliseconds: 500),);
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Future.delayed(Duration(seconds: 2), () {
            
            Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
          });

          //
        }
      });
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _passwordTextEditingController.dispose();
    _userNameTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorManager.white,
          body: StreamBuilder<FlowState>(
            stream: _viewModel.outputState,
            builder: (context, snapshot) {
              return snapshot.data
                      ?.getScreenWidget(context, _getContentWidget(), () {
                    _viewModel.register();
                  }) ??
                  _getContentWidget();
            },
          )),
    );
  }

  Widget _getContentWidget() {
    return Container(
      color: ColorManager.white,
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Spacer(
                flex: 5,
              ),
              Expanded(
                flex: 20,
                child: SizedBox(
                  height: AppSize.s200,
                  width: AppSize.s200,
                  child: Image(
                    image: AssetImage(ImageAssets.notsosecretLogo),
                  ), //json image
                ),
              ),
              Spacer(flex: 2),
              Expanded(
                flex: 10,
                child: Row(
                  children: [
                    Spacer(),
                    Expanded(
                      flex: 10,
                      child: Text(
                        AppStrings.registerWelcome.tr(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Spacer(),
                      Expanded(
                          flex: 10,
                          child: Text(
                            AppStrings.registerSubtext.tr(),
                            textAlign: TextAlign.center,
                          )),
                      Spacer()
                    ],
                  )),
              Spacer(
                flex: 3,
              ),
              Expanded(
                flex: 12,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserName,
                    builder: (context, snapshot) {
                      return TextFormField(
                          controller: _userNameTextEditingController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: AppStrings.inputUsername.tr(),
                            labelText: AppStrings.inputUsername.tr(),
                            errorText: snapshot.data,
                          ));
                    },
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: AppPadding.p28, right: AppPadding.p28),
                  child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPassword,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _passwordTextEditingController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: AppStrings.inputPassword.tr(),
                            labelText: AppStrings.inputPassword.tr(),
                            errorText: snapshot.data),
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Expanded(
                        flex: 5,
                        child: StreamBuilder<bool>(
                            stream: _viewModel.checkBoxStream,
                            initialData: false,
                            builder: (context, snapshot) {
                              return Checkbox(
                                checkColor: ColorManager.white,
                                fillColor: MaterialStateProperty.resolveWith(
                                    (states) => ColorManager.primary),
                                value: snapshot.data,
                                onChanged: (value) {
                                  // _viewModel.inputCheckBox.add(value!);
                                  _viewModel.setCheckBox(value!);
                                },
                              );
                            }),
                      ),
                      Expanded(
                          flex: 20,
                          child: TextButton(
                              onPressed: () {
                                showAlertDialog(context);
                              },
                              child: Text(AppStrings.acceptTerms.tr(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1!
                                      .copyWith(
                                        fontSize: FontSize.s14,
                                      )))),
                      Spacer(),
                    ],
                  )),
              Spacer(),
              Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: AppPadding.p28, right: AppPadding.p28),
                    child: StreamBuilder<bool>(
                      stream: _viewModel.outputIsAllValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(
                                        AppSize.s12))),
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.register();
                                  }
                                : null,
                            child: Text(
                              AppStrings.registerButton.tr(),
                              style: TextStyle(
                                  color: ColorManager.white,
                                  fontSize: AppSize.s16),
                            ),
                          ),
                        );
                      },
                    )),
              ),
              Expanded(
                flex: 10,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: AppPadding.p8,
                      left: AppPadding.p28,
                      right: AppPadding.p28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            //.pop çalışmadı daha sonra dön!!!
                            Navigator.of(context)
                                .popAndPushNamed(Routes.loginRoute);
                          },
                          child: Text(
                            AppStrings.haveAccount.tr(),
                            style: Theme.of(context).textTheme.subtitle2,
                            textAlign: TextAlign.end,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    Widget notsureButton = new TextButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.resolveWith(
                (state) => ColorManager.primary)),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          AppStrings.ok.tr(),
          style: Theme.of(context).textTheme.bodyText2,
        ));

    AlertDialog alertDialog = AlertDialog(
      titlePadding: EdgeInsets.only(left: AppSize.s30, top: AppSize.s20),
      scrollable: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s24))),
      title: Text(
        AppStrings.terms.tr(),
        style: Theme.of(context).textTheme.headline1,
      ),
      content: RichText(
        text: TextSpan(style: Theme.of(context).textTheme.bodyText1, children: [
          TextSpan(
              text:
                  "NotSoSecret Uygulaması Kullanıcı Sözleşmesi ve Gizlilik Politikası Taraflar İşbu Hizmet Kullanımı Sözleşmesi (“Sözleşme”),NotSoSecret mobil uygulamasını (“Uygulama”) indiren ve kullanan gerçek veya tüzel kişi (“Kullanıcı”) ile Nispetiye Mahallesi Engin Sitesi Yolu Sk. Engin Sitesi Yasemin Apartmanı no:173 D:5 Beşiktaş /İstanbul adresinde mukim “Erhan Ali Yılmaz”(“Şirket”) arasında gerçekleşmiş olup, sözleşme maddeleri Kullanıcı’nın Uygulama’yı mobil cihazına indirmesi ve/veya İnternet Sitesi’ni kullanmaya başlaması ile birlikte, Kullanıcı tarafından kabul görmüş ve yürürlüğe girmiş sayılacaktır.İşbu sözleşmede Kullanıcı ve Şirket gerektiğinde tek olarak “Taraf” ve birlikte “Taraflar” olarak anılacaktır.Hizmetin Tanımı – Sözleşme Konus“Mola” Uygulaması Kullanıcı’ların stresini yönetmelerine, konsantrasyonlarını arttırmalarına, zihinlerini boşaltmalarına yardımcı olacak “Mindfulness” bilgi ve egzersizlerini görsel, işitsel ya da yazılı olarak tavsiye niteliğinde sunan bir uygulamadır.İşbu sözleşme Uygulama ve İnternet Sitesi’nin kullanım koşulları ve Kullanıcı ile Şirket’in hak ve yükümlülüklerini düzenler."),
          TextSpan(
              text:
                  "Kullanıcının hak ve yükümlülükleri Kullanıcı, Uygulama ve İnternet Sitesi’ndeki ücretsiz içerik ve egzersizleri Uygulamayı indirip üyeliğini tamamlamasını müteakiben, ücretli içerik ve egzersizleri ise Uygulamaya abone olarak kullanma hakkına sahip olacaktırKullanıcı, kendisinden istenilen bilgileri tam ve gerçeğe uygun olarak bildireceğini beyan ve taahhüt eder.Kullanıcı, bilgilerin eksik veya gerçeğe aykırı olarak bildirilmesinden ve bu eksik veya gerçeğe aykırı bildirimden kaynaklanabilecek sonuçlardan sorumludur.Kullanıcı, Uygulama’yı indirerek 18 yaşının üzerinde olduğunu beyan ve kabul eder. 18 yaşını doldurmamış olan Kullanıcı’nın veli veya vasisinin bu sözleşmeye açık onayını almış olduğu kabul edilir.Uygulama ve İnternet sitesi içindeki her türlü bilgi, egzersiz ve içerik Kullanıcının ortalama olarak herhangi bir tıbbi rahatsızlığı olmadığı varsayılaraktavsiye niteliğinde hazırlanmıştır ve kişiye özel değildir. Kullanıcı, bu durumu bilerek Uygulamayı kullanmakla ve kullanım öncesi gerek görüyorsa doktorunun onayını almakla yükümlüdür. Şirket, Kullanıcı’nın tıbbi rahatsızlığı nedeni ile ortaya çıkacak herhangi bir sonuçtan sorumlu tutulamaz.Kullanıcıegzersizleri kendisine tavsiye edildiği şekilde uygulamakla yükümlüdür.Kullanıcı’nın sisteme girdiği bilgiler, sadece Kullanıcı’nın talebi ile değiştirilebilir.Kullanıcı bu sözleşmeye istediği anda erişme, kayıt etme ve uyuşmazlık durumunda kullanma hakkına sahiptir.")
        ]),
      ),
      actions: [notsureButton],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }
}
