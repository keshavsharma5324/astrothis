import 'package:astro/Model/addres.dart';
import 'package:astro/base/base_repo.dart';
import 'package:astro/base/base_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanchangCubit extends Cubit<BaseState> {
  PanchangCubit({this.repo}) : super(InitialState());
  final BaseRepo? repo;



  void getpanchang(params) async {
    try {
      emit(LoadingState());

      final result = await repo!.getpachang(params);
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
  Future<Addres> getAutoCompletePlaces(String placesearch)async{
    final result;

    result = await repo!.getastrobylocation(placesearch);
    Addres addres = Addres.fromJson(result);

    return addres;
  }
}