
import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'constantes.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final WebViewController wvc = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(BASE_URL))
    ..setBackgroundColor(Colors.white);

  final scrollController = ScrollController();

  // funcoes da classe
  Future<List> inicializarNfc() async {
    // verificar disponiblidade do NFC no celular
    bool isActive = await NfcManager.instance.isAvailable();
    // continuar
    return [];
  }
  Future<void> refreshPage() async{
    try{
      await wvc.clearCache();
      wvc.reload();
    }catch(_){
      //
    }
  }
  fecharNfc(){
    // fechar o NFC se tiver activo
    NfcManager.instance.isAvailable().then((isActive){
      if(isActive){
        NfcManager.instance.stopSession();
      }
    });
  }

  @override
  void initState() {
    fecharNfc();

    super.initState();
  }
  @override
  void dispose() {

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: refreshPage,
          child: ListView(
            controller: scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: WebViewWidget(controller: wvc,),
              )
            ],
          ),
        ),
      )
    );
  }
}
