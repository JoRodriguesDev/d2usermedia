# d2webmedia
Este repositório contém um conjunto de classes Delphi desenvolvido para capturar fotos e videos, criado para um projeto em [D2Bridge](https://www.d2bridge.com.br/), um framework que permite compilar projetos VCL ou FireMonkey para a Web com o mesmo código.

## Instalação
Instalação usando o boss
```
boss install https://github.com/JoRodriguesDev/d2webmedia
```

## Declaração
Para utilizar o d2webmedia você deve adicionar as uses:
```pascal
  uModel.UserMedia.Interfaces,
  uModel.UserMedia.Factory;
```

## Como usar
```pascal
  var HTML := TModelGetUserMedia.New
                .WebcamElementID('webcam')           // ID do elemento de vídeo
                .PhotoCanvasID('photoCanvas')        // ID do elemento canvas
                .CaptureButtonID('captureButton')    // ID do botão de captura
                .VideoResolution(1280, 720)          // Resolução da câmera
                .FrameRate(30)                       // Taxa de quadros
                .VideoFacingMode(fmUser)             // Direção da câmera
                .OnSuccess(D2Bridge.PrismSession.CallBacks.CallBackJS('OnCaptureSuccess', D2Bridge.FormUUID, 'base64Image'))   // Função de sucesso
                .OnError(D2Bridge.PrismSession.CallBacks.CallBackJS('OnCaptureError', D2Bridge.FormUUID, 'error'));            // Função de erro
```
