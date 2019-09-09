program InfoSistemas;

uses
  Vcl.Forms,
  UnFrmCrud in 'UnFrmCrud.pas' {Form2},
  UnPessoa in 'Classes\UnPessoa.pas',
  UnEndereco in 'Classes\UnEndereco.pas',
  UnEmail in 'UnEmail.pas',
  UnXML in 'Lib\UnXML.pas',
  UnAPIviacep in 'Lib\UnAPIviacep.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
