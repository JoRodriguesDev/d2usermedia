unit uModel.UserMedia.Interfaces;

interface

type
  TFacingMode = (fmUser, fmEnvironment);

  iModelUserMedia = interface
  ['{C4132B1D-CC11-4B66-93BA-89A529AA70D9}']
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

end.

