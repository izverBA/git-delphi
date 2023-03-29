program HelloWorld;

uses
  System.StartUpCopy,
  FMX.Forms,
  formHelloWorld in 'formHelloWorld.pas' {frmHelloWorld};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmHelloWorld, frmHelloWorld);
  Application.Run;
end.
