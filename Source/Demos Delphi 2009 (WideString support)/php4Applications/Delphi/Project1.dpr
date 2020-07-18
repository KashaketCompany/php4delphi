program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  php4AppIntf in '..\..\..\php4AppIntf.pas',
  ZendTypes in '..\..\..\ZendTypes.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
