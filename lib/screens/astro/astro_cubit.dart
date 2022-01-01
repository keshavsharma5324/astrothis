import 'package:astro/Model/Astro.dart';
import 'package:astro/Model/addres.dart';
import 'package:astro/base/base_repo.dart';
import 'package:astro/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AstroCubit extends Cubit<BaseState> {
  AstroCubit({this.repo}) : super(InitialState());
  final BaseRepo? repo;



  void getAstro() async {
    try {
      emit(LoadingState());

      final result = await repo!.getastro();
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }
   getaddress(String Addresss) async {
    try {
      emit(LoadingState());

      final result = await repo!.getastrobylocation(Addresss);
      emit(SuccessState<dynamic>(response: result));
    } catch (e) {
      emit(AuthErrorState(response: e.toString()));
    }
  }
  Future<Astro> fetchShows() async {
  final response =
  await repo!.getastro();
  Astro astro = Astro.fromJson(response);

  return astro;

  
}
  Future<Addres> getAutoCompletePlaces(String placesearch)async{
    final result;

    result = await repo!.getastrobylocation(placesearch);
    Addres addres = Addres.fromJson(result);

    return addres;
  }
}