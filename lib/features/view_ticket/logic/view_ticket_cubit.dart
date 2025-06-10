

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ViewTicketState{

}

class ViewTicketUnused extends ViewTicketState{

}

class ViewTicketInUse extends ViewTicketState{

}


class ViewTicketCubit extends Cubit<ViewTicketState>{
  ViewTicketCubit():super(ViewTicketUnused());

}