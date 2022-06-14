import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/constants/theme.dart';
import 'features/posts/presentation/bloc/Posts/posts_bloc.dart';
import 'features/posts/presentation/bloc/add_delete_update-posts/add_delete_update_bloc.dart';
import 'features/posts/presentation/screens/home_screen/home_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.inj<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.inj<AddOrDeleteOrUpdateBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: appTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
