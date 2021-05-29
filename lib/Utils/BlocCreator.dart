import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageBlocCreator<Event, State, B extends Bloc<Event, State>>
    extends StatelessWidget {
  final B Function(BuildContext context) create;
  final void Function(BuildContext context, State state) listener;
  final Widget Function(BuildContext context, State state) builder;

  PageBlocCreator(
      {@required this.create, @required this.builder, @required this.listener});
  @override
  Widget build(BuildContext c) {
    return BlocProvider(
      create: create,
      child: Builder(
        builder: (context) => BlocListener<B, State>(
          listener: listener,
          bloc: BlocProvider.of<B>(context),
          child: BlocBuilder<B, State>(
              bloc: BlocProvider.of<B>(context), builder: builder),
        ),
      ),
    );
  }
}
