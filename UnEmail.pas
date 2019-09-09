unit UnEmail;

interface

uses
  Winapi.Windows, ShellApi;

   procedure EnviaEmail(XML : string);

implementation

procedure EnviaEmail(XML : string);
var tudo: String;
var msg:string;
begin
  msg:=XML;

  tudo:= 'suporte_denisfr@yahoo.com.br'+
  '?subject=Cadastro de Pessoa'+
  '&body= '+msg+'   ';

  ShellExecute(GetDesktopWindow,'open',pchar(tudo),nil,nil,sw_ShowNormal);
end;

end.
