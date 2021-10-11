program Print_rs;

uses
  Forms,
  Ps in 'Ps.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
