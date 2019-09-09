unit UnFrmCrud;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, UnEndereco, UnPessoa, System.Generics.Collections,
  Vcl.Mask, Vcl.ComCtrls, System.RTTI, Vcl.ExtCtrls, Vcl.DBCtrls,
  IdAntiFreezeBase, Vcl.IdAntiFreeze, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdMessage, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdSMTPBase, IdSMTP, Xml.xmldom, Xml.XMLIntf, Xml.XMLDoc,
  System.Classes, IdAttachmentFile;

   type
      ItemListaPessoa = Record
      StatusLista : integer;
      IndexItem : integer
    end;

type
  TForm2 = class(TForm)
    cdsDados: TClientDataSet;
    DsDados: TDataSource;
    grbxDados: TGroupBox;
    PageControl1: TPageControl;
    tbshPessoa: TTabSheet;
    lblNome: TLabel;
    lblIdentidade: TLabel;
    lblCPF: TLabel;
    Label5: TLabel;
    lblEmail: TLabel;
    ControlNome: TEdit;
    ControlIdentidade: TMaskEdit;
    ControlCPF: TMaskEdit;
    ControlTelefone: TMaskEdit;
    ControlEmail: TMaskEdit;
    tbshEndereco: TTabSheet;
    BtnInserir: TButton;
    BtnAlterar: TButton;
    BtnExcluir: TButton;
    BtnSalvar: TButton;
    btnCancelar: TButton;
    dbgrDados: TDBGrid;
    S: TStringField;
    dbnvdados: TDBNavigator;
    ControlLogradouro: TEdit;
    lblEnredero: TLabel;
    ControlComplemento: TEdit;
    lblcomp: TLabel;
    ControlBairro: TEdit;
    lblbairro: TLabel;
    ControlCidade: TEdit;
    lblcidade: TLabel;
    ControlNumero: TEdit;
    lblnumero: TLabel;
    ControlCep: TEdit;
    lblcep: TLabel;
    ControlEstado: TEdit;
    lblEstado: TLabel;
    ControlPais: TEdit;
    lblPais: TLabel;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    SSLSocket: TIdSSLIOHandlerSocketOpenSSL;
    IdAntiFreeze1: TIdAntiFreeze;
    XMLDocument1: TXMLDocument;
    btnCep: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnInserirClick(Sender: TObject);
    procedure cdsDadosAfterScroll(DataSet: TDataSet);
    procedure btnCepClick(Sender: TObject);
  private
    procedure IncluirPessoa(Dados: array of variant);
    procedure LoadCampos(Pessoa: Tpessoa);
    procedure StatusLista();
    procedure LimpaControles();
    procedure PopulaCDSGrid;
    procedure EnviarEmail;
    procedure GeraXML;
    { Private declarations }
  public
    { Public declarations }
  end;


var
  Form2: TForm2;
  ListaPessoa : TObjectList<TPessoa>;
  PessoaFoco : ItemListaPessoa;

implementation

{$R *.dfm}

uses UnEmail, UnXML, UnAPIviacep;

procedure TForm2.btnCepClick(Sender: TObject);
var
   UmAPIviacep : TAPIviacep;
begin
   try
      UmAPIviacep := TAPIviacep.Create(ControlCep.Text);
      //se encontrou o CEP, preenche os TEdits do form
      if (UmAPIviacep.GetRespCode = 200 ) then
      begin
        ControlLogradouro.Text := UmAPIviacep.GetLogradouro;
        ControlBairro.Text := UmAPIviacep.GetBairro;
        ControlComplemento.Text := UmAPIviacep.GetComplemento;
        ControlCidade.Text := UmAPIviacep.GetLocalidade;
        ControlEstado.Text := UmAPIviacep.GetUF;
        ControlPais.Text := UmAPIviacep.GetUnidade;
      end
      else if (UmAPIviacep.GetRespCode = 400) then
        showMessage('CEP inválido ou não encontrado');
   finally
     FreeAndNil(UmAPIviacep);
   end;end;

procedure TForm2.BtnInserirClick(Sender: TObject);
begin
  case TButton(Sender).Tag of
    1: //novo btn
    begin
      LimpaControles();
      PessoaFoco.StatusLista := 1;
      StatusLista();
    end;

    2://save btn
    begin
      IncluirPessoa([
        ControlNome.Text,
        ControlIdentidade.Text,
        ControlCPF.Text,
        ControlTelefone.Text,
        ControlEmail.Text,

        ControlCep.Text,
        ControlLogradouro.Text,
        ControlNumero.Text,
        ControlComplemento.Text,
        ControlBairro.Text,
        ControlCidade.Text,
        ControlEstado.Text,
        ControlPais.Text
        ]);

      PessoaFoco.IndexItem := ListaPessoa.Count-1;
      PessoaFoco.StatusLista := 2;
      StatusLista();

      PopulaCDSGrid();
      LoadCampos(ListaPessoa[0]);

      GeraXML();
      EnviarEmail()
    end;


    3://cancela btn
    begin
      LimpaControles();
      PessoaFoco.StatusLista := 1;
      LimpaControles();

      PessoaFoco.IndexItem := -1;
      PessoaFoco.StatusLista := 2;
      StatusLista();

      if ListaPessoa.Count > 0 then
        LoadCampos(ListaPessoa[0]);
    end;

    8: //novo btn
    begin
      PessoaFoco.StatusLista := 3;
      StatusLista();
    end;

    9: //novo btn
    begin
      ListaPessoa.Remove(ListaPessoa[cdsDados.RecNo-1]);
      PopulaCDSGrid();
    end;

  end;

end;

procedure TForm2.PopulaCDSGrid();
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  PropriedadeNome: TRttiProperty;
  Pessoa: TPessoa;
begin
  Contexto := TRttiContext.Create;
  try
    Tipo := Contexto.GetType(TPessoa.ClassInfo);

    PropriedadeNome := Tipo.GetProperty('Nome');

    CdsDados.Close();
    CdsDados.CreateDataSet;

    for Pessoa in ListaPessoa do
      CdsDados.AppendRecord([PropriedadeNome.GetValue(Pessoa).AsString]);

    CdsDados.First;
  finally
    Contexto.Free;
  end;
end;

procedure TForm2.cdsDadosAfterScroll(DataSet: TDataSet);
begin
   if ListaPessoa.Count > 0 then
     LoadCampos(ListaPessoa[cdsDados.RecNo-1])
   else
     LimpaControles();
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Freeandnil(ListaPessoa);
  cdsDados.Close();
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  ListaPessoa := TObjectList<TPessoa>.Create();
  PessoaFoco.StatusLista := 2;
  PessoaFoco.IndexItem := -1;

  StatusLista();

//  cdsDados.CreateDataSet;
end;

procedure TForm2.IncluirPessoa(Dados: array of variant);
var
  Pessoa : TPessoa;
begin
  Pessoa := TPessoa.Create;
  Pessoa.Nome := Dados[0];
  Pessoa.Identidade := Dados[1];
  Pessoa.CPF := Dados[2];
  Pessoa.Telefone := Dados[3];
  Pessoa.Email := Dados[4];
  Pessoa.Endereco.Cep := Dados[5];
  Pessoa.Endereco.Logradouro := Dados[6];
  Pessoa.Endereco.Numero := strtointdef(Dados[7],0);
  Pessoa.Endereco.Complemento := Dados[8];
  Pessoa.Endereco.Bairro := Dados[9];
  Pessoa.Endereco.Cidade := Dados[10];
  Pessoa.Endereco.Estado := Dados[11];
  Pessoa.Endereco.Pais := Dados[12];

  if PessoaFoco.StatusLista = 1 then
    ListaPessoa.Add(Pessoa)
  else if PessoaFoco.StatusLista = 3 then
  begin
    ListaPessoa[cdsDados.RecNo-1].Nome := Pessoa.Nome;
    ListaPessoa[cdsDados.RecNo-1].Identidade := Pessoa.Identidade;
    ListaPessoa[cdsDados.RecNo-1].CPF := Pessoa.CPF;
    ListaPessoa[cdsDados.RecNo-1].Telefone := Pessoa.Telefone;
    ListaPessoa[cdsDados.RecNo-1].Email := Pessoa.Email;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Cep := Pessoa.Endereco.Cep;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Logradouro := Pessoa.Endereco.Logradouro;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Numero := Pessoa.Endereco.Numero;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Complemento := Pessoa.Endereco.Complemento;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Bairro := Pessoa.Endereco.Bairro;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Cidade := Pessoa.Endereco.Cidade;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Estado := Pessoa.Endereco.Estado;
    ListaPessoa[cdsDados.RecNo-1].Endereco.Pais := Pessoa.Endereco.Pais;

    PopulaCDSGrid();
  end;

  PessoaFoco.StatusLista := 2;
  StatusLista();
end;

procedure TForm2.StatusLista();
begin
  case PessoaFoco.StatusLista of
    1,3: //Edição
    begin
      BtnInserir.Enabled := false;
      BtnAlterar.Enabled := false;
      BtnExcluir.Enabled := false;
      BtnSalvar.Enabled := true;
      btnCancelar.Enabled := true;
    end;

    2: //Navegação
    begin
      BtnInserir.Enabled := true;
      BtnAlterar.Enabled := true;
      BtnExcluir.Enabled := true;
      BtnSalvar.Enabled := false;
      btnCancelar.Enabled := false;
    end;
  end;
end;

procedure TForm2.LoadCampos(Pessoa: Tpessoa);
var
  Context: TRttiContext;
  Tipo: TRttiType;
  Propriedade: TRttiProperty;
  Valor: variant;
  Componente: TComponent;
  ItemPessoa : TPessoa;
begin
  Context := TRttiContext.Create;

  Tipo := Context.GetType(TPessoa.ClassInfo);

  ItemPessoa := Pessoa;

  for Propriedade in Tipo.GetProperties do
  begin
    Valor := Propriedade.GetValue(ItemPessoa).AsVariant;
    Componente := FindComponent('Control' + Propriedade.Name);

    if Componente <> nil then
    begin
    if (Componente is TEdit) then
      (Componente as TEdit).Text := Valor
    else if (Componente is TMaskEdit) then
      (Componente as TMaskEdit).Text := Valor;
    end;
  end;

  Tipo := Context.GetType(TEndereco.ClassInfo);

  for Propriedade in Tipo.GetProperties do
  begin
    Valor := Propriedade.GetValue(ItemPessoa.Endereco).AsVariant;
    Componente := FindComponent('Control' + Propriedade.Name);

    if Componente <> nil then
    begin
    if (Componente is TEdit) then
      (Componente as TEdit).Text := Valor
    else if (Componente is TMaskEdit) then
      (Componente as TMaskEdit).Text := Valor;
    end;
  end;

end;

procedure TForm2.LimpaControles();
var
  controle : TControl;
  i : integer;
begin

  for i := 0 to Form2.tbshPessoa.ControlCount-1 do
  begin
    controle := Form2.tbshPessoa.Controls[i];

    if (controle is TEdit) then
      (controle as TEdit).Text := ''
    else if (controle is TMaskEdit) then
      (controle as TMaskEdit).Text := '';
  end;

  for i := 0 to Form2.tbshEndereco.ControlCount-1 do
  begin
    controle := Form2.tbshEndereco.Controls[i];

    if (controle is TEdit) then
      (controle as TEdit).Text := ''
    else if (controle is TMaskEdit) then
      (controle as TMaskEdit).Text := '';
  end;

end;

procedure TForm2.EnviarEmail();
begin
  SSLSocket.SSLOptions.Method := sslvSSLv23;
  SSLSocket.SSLOptions.Mode := sslmClient;
  SSLSocket.SSLOptions.VerifyMode := [];
  SSLSocket.SSLOptions.VerifyDepth := 0;

  IdSMTP1.Host := 'smtp.live.com';
  IdSMTP1.Username:='suporte_denisfr';
  IdSMTP1.Password := 'sua senha';
  IdSMTP1.Port := 587;
  IdSMTP1.IOHandler := SSLSocket;
  IdSMTP1.UseTLS := utUseExplicitTLS;
  IdSMTP1.AuthType := satDefault;
  IdSMTP1.Authenticate;

  IdMessage1.MessageParts.Clear;
  TIdAttachmentFile.Create(IdMessage1.MessageParts, (ExtractFileDir(Application.ExeName) + '\Pessoa.xml'));

  IdMessage1.From.Address:= 'suporte_denisfr@hotmail.com';
  IdMessage1.Subject:= 'Cadastro de Pessoa';
  IdMessage1.Body.Text := 'Teste de envio';
  IdMessage1.ContentType:='text/html';
  IdMessage1.Recipients.EMailAddresses := 'suporte_denisfr@hotmail.com';
  IdMessage1.Encoding := meMIME;
  IdMessage1.Priority := mpNormal;

//  IdSMTP1.Connect();
//  IdSMTP1.Send(IdMessage1);
//  IdSMTP1.Disconnect();
end;

procedure TForm2.GeraXML();
var
  MeuXml : TMeuXML;
begin
  try
    MeuXml := TMeuXML.Create();
    MeuXml.WriteToXML(ListaPessoa[ListaPessoa.Count-1]);

  finally
    Freeandnil(MeuXml);
  end;
end;

end.
