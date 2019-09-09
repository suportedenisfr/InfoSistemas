unit UnPessoa;

interface
uses UnEndereco;

  type
    TPessoa = class
    private
      FNome : string;
      FIdentidade : string;
      FCPF : string;
      FTelefone : string;
      FEmail : string;
      FEndereco : TEndereco;
    public
      property Nome : string read FNome write FNome;
      property Identidade : string read FIdentidade write FIdentidade;
      property CPF : string read FCPF write FCPF;
      property Telefone : string read FTelefone write FTelefone;
      property Email : string read FEmail write FEmail;
      property Endereco : TEndereco read FEndereco write FEndereco;
    published
      constructor Create();
      destructor Destroy; override;
    end;

implementation

uses
  System.SysUtils;



{ TPessoa }

constructor TPessoa.Create;
begin
  self.Endereco := TEndereco.Create();
end;

destructor TPessoa.Destroy;
begin
  self.Endereco.Free;
  inherited;
end;

end.
