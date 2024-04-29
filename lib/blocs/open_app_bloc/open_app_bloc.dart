import 'package:bloc/bloc.dart';
import 'package:bpbm2/common/methods/package_info.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'open_app_event.dart';
part 'open_app_state.dart';

class OpenAppBloc extends Bloc<OpenAppEvent, OpenAppState> {
  OpenAppBloc() : super(OpenAppInitial()) {
    on<OpenAppEvent>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstTimeUser = prefs.getBool('firstTimeUser') ?? true;
      if (event is OpenAppStarted) {
        final versionName = await packageInformation();
        emit(
          OpenAppSplashScreen(
            versionName: versionName,
          ),
        );
        await Future.delayed(const Duration(seconds: 2));
        if (firstTimeUser) {
          emit(OpenAppFirstTimeUser());
        } else {
          emit(OpenAppNotFirstTimeUser());
        }
      }

      if (event is OpenAppIntroFinished) {
        emit(OpenAppSuccess());
        prefs.setBool('firstTimeUser', false);
      }
    });
  }
}
