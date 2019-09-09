unit UnEndereco;

interface
  type TEndereco = class
    private
      FCep : string;
      FLogradouro : string;
      FNumero : integer;
      FComplemento : string;
      FBairro : string;
      FCidade : string;
      FEstado : string;
      FPais : string;
    public
      property Cep : string read FCep write FCep;
      property Logradouro : string  read FCep write FCep;
      property Numero : integer  read FNumero write FNumero;
      property Complemento : string read FComplemento write FCOmplemento;
      property Bairro : string read FBairro write FBairro;
      property Cidade : string read FCidade write FCidade;
      property Estado : string read FEstado write FEstado;
      property Pais : string read FPais write FPais;
  end;

implementation

end.
