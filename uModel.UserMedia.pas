unit uModel.UserMedia;

interface

uses
  uModel.UserMedia.Interfaces;

type
  TModelGetUserMedia = class(TInterfacedObject, iModelUserMedia)
  private
    FOnSuccess: string;
    FOnError: string;
    FVideoFacingMode: TFacingMode;
    FVideoWidth: Integer;
    FVideoHeight: Integer;
    FFrameRate: Integer;
    FWebcamElementID: string;
    FPhotoCanvasID: string;
    FCaptureButtonID: string;

    function FacingModeToString(AFacingMode: TFacingMode): string;
  public
    class function New: iModelUserMedia;
    constructor Create;
    destructor Destroy; override;

    function OnSuccess(AValue: string): iModelUserMedia;
    function OnError(AValue: string): iModelUserMedia;
    function VideoFacingMode(AValue: TFacingMode): iModelUserMedia;
    function VideoResolution(AWidth, AHeight: Integer): iModelUserMedia;
    function FrameRate(AValue: Integer): iModelUserMedia;
    function WebcamElementID(AValue: string): iModelUserMedia;
    function PhotoCanvasID(AValue: string): iModelUserMedia;
    function CaptureButtonID(AValue: string): iModelUserMedia;
    function Generate: string;
  end;

implementation

uses
  System.SysUtils;

{ TModelUserMedia }

constructor TModelGetUserMedia.Create;
begin
  FVideoFacingMode  := fmUser;
  FVideoWidth       := 1280;
  FVideoHeight      := 720;
  FFrameRate        := 30;

  FWebcamElementID  := 'webcam';
  FPhotoCanvasID    := 'photoCanvas';
  FCaptureButtonID  := 'captureButton';
end;

destructor TModelGetUserMedia.Destroy;
begin
  inherited;
end;

function TModelGetUserMedia.FacingModeToString(AFacingMode: TFacingMode): string;
begin
  case AFacingMode of
    fmUser:        Result := 'user';
    fmEnvironment: Result := 'environment';
  else
    Result := 'user';
  end;
end;

function TModelGetUserMedia.FrameRate(AValue: Integer): iModelUserMedia;
begin
  Result := Self;
  FFrameRate := AValue;
end;

function TModelGetUserMedia.Generate: string;
begin
  Result :=
    'const webcamElement = document.getElementById("' + FWebcamElementID + '");' +
    'const photoCanvas = document.getElementById("'   + FPhotoCanvasID + '");' +
    'const captureButton = document.getElementById("' + FCaptureButtonID + '");' +
    'const photoContext = photoCanvas.getContext("2d");' +
    'let facingMode = "' + FacingModeToString(FVideoFacingMode) + '";' +

    'async function initializeCamera() {' +
    '  try {' +
    '    const stream = await navigator.mediaDevices.getUserMedia({' +
    '      video: {' +
    '        facingMode: facingMode,' +
    '        width: { ideal: ' + FVideoWidth.ToString + ' },' +
    '        height: { ideal: ' + FVideoHeight.ToString + ' },' +
    '        frameRate: { ideal: ' + FFrameRate.ToString + ', max: 60 }' +
    '      },' +
    '      audio: false' +
    '    });' +
    '    webcamElement.srcObject = stream;' +
    '  } catch (error) {' +
    '    handleCameraError(error);' +
    '  }' +
    '}' +

    'function handleCameraError(error) {' +
    '  console.error("Erro ao acessar a câmera:", error);' +
    '  let errorMessage = "Erro ao acessar a câmera. ";' +
    '  if (error.name === "NotAllowedError") {' +
    '    errorMessage += "Verifique as permissões no navegador.";' +
    '  } else if (error.name === "NotFoundError") {' +
    '    errorMessage += "Nenhuma câmera foi encontrada no dispositivo.";' +
    '  } else if (error.name === "NotReadableError") {' +
    '    errorMessage += "A câmera está em uso por outro aplicativo.";' +
    '  } else {' +
    '    errorMessage += "Erro desconhecido. Verifique as configurações.";' +
    '  }' +
    '    ' + FOnError +
    '}' +

    'async function checkDevices() {' +
    '  const devices = await navigator.mediaDevices.enumerateDevices();' +
    '  const videoDevices = devices.filter(device => device.kind === "videoinput");' +
    '  const audioDevices = devices.filter(device => device.kind === "audioinput");' +
    '  console.log("Câmeras disponíveis:", videoDevices);' +
    '  console.log("Microfones disponíveis:", audioDevices);' +
    '}' +

    'function capturePhoto() {' +
    '  photoContext.drawImage(webcamElement, 0, 0, photoCanvas.width, photoCanvas.height);' +
    '  const base64Image = photoCanvas.toDataURL("image/png");' +
    '    ' + FOnSuccess +
    '}' +

    'captureButton.addEventListener("click", capturePhoto);' +
    'checkDevices();' +
    'initializeCamera();';
end;

class function TModelGetUserMedia.New: iModelUserMedia;
begin
  Result := Self.Create;
end;

function TModelGetUserMedia.OnError(AValue: string): iModelUserMedia;
begin
  Result := Self;
  FOnError := AValue;
end;

function TModelGetUserMedia.OnSuccess(AValue: string): iModelUserMedia;
begin
  Result := Self;
  FOnSuccess := AValue;
end;

function TModelGetUserMedia.VideoFacingMode(AValue: TFacingMode): iModelUserMedia;
begin
  Result := Self;
  FVideoFacingMode := AValue;
end;

function TModelGetUserMedia.VideoResolution(AWidth, AHeight: Integer): iModelUserMedia;
begin
  Result := Self;
  FVideoWidth := AWidth;
  FVideoHeight := AHeight;
end;

function TModelGetUserMedia.WebcamElementID(AValue: string): iModelUserMedia;
begin
  Result := Self;
  FWebcamElementID := AValue;
end;

function TModelGetUserMedia.PhotoCanvasID(AValue: string): iModelUserMedia;
begin
  Result := Self;
  FPhotoCanvasID := AValue;
end;

function TModelGetUserMedia.CaptureButtonID(AValue: string): iModelUserMedia;
begin
  Result := Self;
  FCaptureButtonID := AValue;
end;

end.
