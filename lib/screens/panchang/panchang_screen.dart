

import 'package:astro/Model/addres.dart';
import 'package:astro/Model/panchang.dart';
import 'package:astro/base/base_repo.dart';
import 'package:astro/base/base_state.dart';
import 'package:astro/screens/panchang/panchang.dart';
import 'package:astro/screens/panchang/panchang_cubit.dart';
import 'package:astro/utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class panchangScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => panchangScreenState();
}

class panchangScreenState extends State<panchangScreen> {
  Panchang? panchang;
  Addres? addres;

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PanchangCubit(repo: BaseRepo()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _globalKey,
        body: BlocConsumer<PanchangCubit, BaseState>(
            listener: (context, state) async {
              if (state is LoadingState) {
                print('loading Data');
                // showLoader("Logging In`......");

              }
              if (state is GettingDataState) {
                print('getting Data State');
                //showLoader("Getting data......");
              }
              if (state is UserDataSuccessState){
                addres = Addres.fromJson(state.response);
                print(addres);
              }

              if (state is SuccessState) {
                //print(loginResponse.success!.token);
                panchang = Panchang.fromJson(state.response);
                FocusScope.of(context).requestFocus(FocusNode());
                _globalKey.currentState!.showSnackBar(getSnackBar(
                    panchang!.httpStatus!, "Loading", _globalKey));
                if(panchang!.data==null){

                }
                //print();
                /* _globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["errors"][0]["msg"]
                    , "OK", _globalKey));*/

                // print('r54ggg');
                //print("this sample text"+state.response["errors"][0]["msg"]);
                // print(${state.reponse});
                // hideLoader();
                // print("Response Value -> ${state.response}");

                print(state.response);
               // Navigator.push(context, new MaterialPageRoute(builder: (__) => new VerifyotpScreen()));

              }
              //  print(loginResponse.success.token);
              //AppUtils.token = loginResponse.success.token!;
              // TaxiUKPrefs.instance.saveSecureToken(tokenKey, loginResponse.success.token!);
              // print(loginResponse.success);
              /* if(loginResponse.success != null){
                  var args =await {
                    "from": 'login',
                    "code": 'ffrr',
                    "user_id": loginResponse.success.userId,
                    "token": loginResponse.success.token
                  };
                  NavigationService().navigationKey.currentState!.pushNamed(personalDetailsRoute, arguments: args);
                 // print(loginResponse.success.token);
                }*/
              else{



                /*if(loginResponse.data!.stage == Constants.passengerStagePersonalDetailCompleted){
                    TaxiUKPrefs.instance.saveLoginStatus(true);
                    SharedPreferenceUtils().saveUserData(loginResponse!.data!);
                    NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(dashboard, (route) => false);
                  }else if(loginResponse.data!.stage == Constants.passengerStagePasswordCreated){
                    _globalKey.currentContext!.read<LoginCubit>().getPersonalDetails(loginResponse.data!.token.toString());
                  }else{
                     }*/
              }
              //  }
              /*RegisterResponse registerResponse = RegisterResponse.fromMap(state.response);
                if(registerResponse.isSuccess){
                  var args = {
                    "from": 'login',
                    "code": '',
                    "mobile": registerResponse.data.phone_number,
                    "ext": registerResponse.data.ext,
                   // "type": Constants.loginTypeRegistration
                  };
                  NavigationService().navigationKey.currentState!.pushNamed(otpRoute, arguments: args);
                }*//*else{
                 if(registerResponse.meta != null){
                   if(!registerResponse.meta.is_user_exist){
                     var args = {
                       "from": 'login',
                       "code": '',
                       "mobile": registerResponse.data.phone_number,
                       "ext": registerResponse.data.ext,
                       //"type": Constants.loginTypeRegistration
                     };
                     NavigationService().navigationKey.currentState!.pushNamed(otpRoute, arguments: args);
                   } else{
                     NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
                   }
                 }
                }
              }*/
              /* if(state is UserDataSuccessState){
                hideLoader();
                ProfileResponse profileResponse = ProfileResponse.fromMap(state.response);
                AppUtils.userData = profileResponse.data;
                AppUtils.fname = (AppUtils.userData!.fname == null ? "" : AppUtils.userData!.fname)!;
                var data = {"fromPage": "register"};
                NavigationService().navigationKey.currentState!.pushNamed(personalDetailsRoute, arguments: data);
              }*/

              if (state is AuthErrorState) {
                print('errorstate');
                //print("error => ${state.response}");
                //   hideLoader();
                //  NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
                //Navigator.pop(context);
                //FocusScope.of(context).requestFocus(FocusNode());
                /*_globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["errors"][0]["msg"]
                    , "OK", _globalKey));*/
              }

              /*if (state is AuthErrorState) {
                print("error => ${state.response}");
                hideLoader();
                FocusScope.of(context).requestFocus(FocusNode());
                if(state.response["is_user_exist"]){
                  NavigationService().navigationKey.currentState!.pushNamedAndRemoveUntil(login, (Route route) => false);
                }
                _globalKey.currentState!.showSnackBar(getSnackBar(
                    state.response["message"], "OK", _globalKey));
              }*/
            },
            listenWhen: (previous, current) => previous != current,
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) => Stack(
              children: [
                panchangui(panchangmodel: panchang,addres: addres,

                  /* onClick: (Map<String, dynamic> params) {
                          // NavigationService().navigationKey.currentState.pushNamed(login);
                          context.read<LoginCubit>().generateOtpRegisteration(params);
                        }*/),
              ],
            )),
      ),
    );
  }
}