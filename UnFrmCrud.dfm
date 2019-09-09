object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 544
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object grbxDados: TGroupBox
    Left = 0
    Top = 0
    Width = 765
    Height = 193
    Align = alTop
    Caption = '[ Dados ]'
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 2
      Top = 55
      Width = 761
      Height = 136
      ActivePage = tbshEndereco
      Align = alBottom
      TabOrder = 0
      object tbshPessoa: TTabSheet
        Caption = 'Pessoa'
        object lblNome: TLabel
          Left = 16
          Top = 19
          Width = 27
          Height = 13
          Caption = 'Nome'
        end
        object lblIdentidade: TLabel
          Left = 487
          Top = 19
          Width = 52
          Height = 13
          Caption = 'Identidade'
        end
        object lblCPF: TLabel
          Left = 19
          Top = 46
          Width = 19
          Height = 13
          Caption = 'CPF'
        end
        object Label5: TLabel
          Left = 275
          Top = 43
          Width = 42
          Height = 13
          Caption = 'Telefone'
        end
        object lblEmail: TLabel
          Left = 19
          Top = 65
          Width = 24
          Height = 13
          Caption = 'Email'
        end
        object ControlNome: TEdit
          Left = 72
          Top = 16
          Width = 380
          Height = 21
          TabOrder = 0
        end
        object ControlIdentidade: TMaskEdit
          Left = 545
          Top = 16
          Width = 144
          Height = 21
          EditMask = '000\.000\.000\-0;1;_'
          MaxLength = 13
          TabOrder = 1
          Text = '   .   .   - '
        end
        object ControlCPF: TMaskEdit
          Left = 72
          Top = 43
          Width = 168
          Height = 21
          EditMask = '000\.000\.000\-00;1;_'
          MaxLength = 14
          TabOrder = 2
          Text = '   .   .   -  '
        end
        object ControlTelefone: TMaskEdit
          Left = 323
          Top = 43
          Width = 127
          Height = 21
          EditMask = '!\(99\)0000-0000;1;_'
          MaxLength = 13
          TabOrder = 3
          Text = '(  )    -    '
        end
        object ControlEmail: TMaskEdit
          Left = 72
          Top = 70
          Width = 380
          Height = 21
          TabOrder = 4
          Text = ''
        end
      end
      object tbshEndereco: TTabSheet
        Caption = 'Endere'#231'o'
        ImageIndex = 1
        object lblEnredero: TLabel
          Left = 24
          Top = 3
          Width = 45
          Height = 13
          Caption = 'Endere'#231'o'
        end
        object lblcomp: TLabel
          Left = 16
          Top = 30
          Width = 65
          Height = 13
          Caption = 'Complemento'
        end
        object lblbairro: TLabel
          Left = 24
          Top = 49
          Width = 28
          Height = 13
          Caption = 'Bairro'
        end
        object lblcidade: TLabel
          Left = 24
          Top = 81
          Width = 33
          Height = 13
          Caption = 'Cidade'
        end
        object lblnumero: TLabel
          Left = 473
          Top = 3
          Width = 37
          Height = 13
          Caption = 'N'#250'mero'
        end
        object lblcep: TLabel
          Left = 473
          Top = 27
          Width = 19
          Height = 13
          Caption = 'Cep'
        end
        object lblEstado: TLabel
          Left = 473
          Top = 54
          Width = 33
          Height = 13
          Caption = 'Estado'
        end
        object lblPais: TLabel
          Left = 473
          Top = 81
          Width = 19
          Height = 13
          Caption = 'Pa'#237's'
        end
        object ControlLogradouro: TEdit
          Left = 87
          Top = 3
          Width = 380
          Height = 21
          TabOrder = 0
        end
        object ControlComplemento: TEdit
          Left = 87
          Top = 27
          Width = 380
          Height = 21
          TabOrder = 1
        end
        object ControlBairro: TEdit
          Left = 87
          Top = 54
          Width = 380
          Height = 21
          TabOrder = 2
        end
        object ControlCidade: TEdit
          Left = 87
          Top = 81
          Width = 380
          Height = 21
          TabOrder = 3
        end
        object ControlNumero: TEdit
          Left = 524
          Top = 3
          Width = 192
          Height = 21
          MaxLength = 5
          TabOrder = 4
        end
        object ControlCep: TEdit
          Left = 524
          Top = 27
          Width = 141
          Height = 21
          MaxLength = 9
          TabOrder = 5
        end
        object ControlEstado: TEdit
          Left = 524
          Top = 54
          Width = 192
          Height = 21
          MaxLength = 2
          TabOrder = 6
        end
        object ControlPais: TEdit
          Left = 524
          Top = 81
          Width = 192
          Height = 21
          TabOrder = 7
        end
        object btnCep: TButton
          Left = 670
          Top = 26
          Width = 46
          Height = 25
          Caption = 'Buscar'
          TabOrder = 8
          OnClick = btnCepClick
        end
      end
    end
    object BtnInserir: TButton
      Tag = 1
      Left = 6
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Novo'
      TabOrder = 1
      OnClick = BtnInserirClick
    end
    object BtnAlterar: TButton
      Tag = 8
      Left = 78
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Altera'
      TabOrder = 2
      OnClick = BtnInserirClick
    end
    object BtnExcluir: TButton
      Tag = 9
      Left = 151
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Apaga'
      TabOrder = 3
      OnClick = BtnInserirClick
    end
    object BtnSalvar: TButton
      Tag = 2
      Left = 456
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Salvar'
      TabOrder = 4
      OnClick = BtnInserirClick
    end
    object btnCancelar: TButton
      Tag = 3
      Left = 530
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 5
      OnClick = BtnInserirClick
    end
    object dbnvdados: TDBNavigator
      Left = 230
      Top = 16
      Width = 220
      Height = 25
      DataSource = DsDados
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
      ConfirmDelete = False
      TabOrder = 6
    end
  end
  object dbgrDados: TDBGrid
    Left = 0
    Top = 193
    Width = 765
    Height = 351
    Align = alBottom
    DataSource = DsDados
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object cdsDados: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cdsDadosAfterScroll
    Left = 24
    Top = 208
    object S: TStringField
      FieldName = 'Nome'
      Size = 50
    end
  end
  object DsDados: TDataSource
    AutoEdit = False
    DataSet = cdsDados
    Left = 24
    Top = 264
  end
  object IdSMTP1: TIdSMTP
    SASLMechanisms = <>
    Left = 104
    Top = 208
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 168
    Top = 208
  end
  object SSLSocket: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmClient
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 312
    Top = 208
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 240
    Top = 208
  end
  object XMLDocument1: TXMLDocument
    Left = 104
    Top = 264
  end
end
