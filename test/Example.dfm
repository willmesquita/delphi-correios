object FormExample: TFormExample
  Left = 0
  Top = 0
  Caption = 'Example'
  ClientHeight = 297
  ClientWidth = 355
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 355
    Height = 297
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 41
      Height = 13
      Caption = 'Empresa'
    end
    object Label2: TLabel
      Left = 185
      Top = 16
      Width = 30
      Height = 13
      Caption = 'Senha'
    end
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 41
      Height = 13
      AutoSize = False
      Caption = 'Entrega'
    end
    object Label4: TLabel
      Left = 16
      Top = 88
      Width = 56
      Height = 13
      Caption = 'CEP Origem'
    end
    object Label5: TLabel
      Left = 185
      Top = 88
      Width = 58
      Height = 13
      Caption = 'CEP Destino'
    end
    object Label6: TLabel
      Left = 16
      Top = 128
      Width = 23
      Height = 13
      Caption = 'Peso'
    end
    object Label7: TLabel
      Left = 148
      Top = 128
      Width = 40
      Height = 13
      Caption = 'Formato'
    end
    object Label8: TLabel
      Left = 16
      Top = 163
      Width = 29
      Height = 13
      Caption = 'Altura'
    end
    object Label9: TLabel
      Left = 111
      Top = 163
      Width = 37
      Height = 13
      Caption = 'Largura'
    end
    object Label10: TLabel
      Left = 212
      Top = 163
      Width = 63
      Height = 13
      Caption = 'Comprimento'
    end
    object Label11: TLabel
      Left = 16
      Top = 194
      Width = 43
      Height = 13
      Caption = 'Diametro'
    end
    object Label12: TLabel
      Left = 128
      Top = 194
      Width = 75
      Height = 13
      Caption = 'Valor Declarado'
    end
    object editEmpresa: TEdit
      Left = 63
      Top = 13
      Width = 104
      Height = 21
      TabOrder = 0
    end
    object editSenha: TEdit
      Left = 221
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 1
    end
    object comboEntrega: TComboBox
      Left = 63
      Top = 45
      Width = 279
      Height = 21
      TabOrder = 2
    end
    object editCepOrigem: TMaskEdit
      Left = 78
      Top = 85
      Width = 88
      Height = 21
      EditMask = '00000-000;0;_'
      MaxLength = 9
      TabOrder = 3
      Text = ''
    end
    object editCepDestino: TMaskEdit
      Left = 249
      Top = 85
      Width = 92
      Height = 21
      EditMask = '00000-000;0;_'
      MaxLength = 9
      TabOrder = 4
      Text = ''
    end
    object comboFormato: TComboBox
      Left = 206
      Top = 125
      Width = 136
      Height = 21
      TabOrder = 5
    end
    object editPeso: TMaskEdit
      Left = 45
      Top = 125
      Width = 89
      Height = 21
      TabOrder = 6
      Text = ''
    end
    object btnEnviar: TButton
      Left = 266
      Top = 266
      Width = 75
      Height = 25
      Caption = 'Enviar'
      TabOrder = 7
      OnClick = btnEnviarClick
    end
    object btnCancelar: TButton
      Left = 15
      Top = 266
      Width = 75
      Height = 25
      Caption = 'Sair'
      TabOrder = 8
      OnClick = btnCancelarClick
    end
    object editAltura: TMaskEdit
      Left = 53
      Top = 160
      Width = 52
      Height = 21
      TabOrder = 9
      Text = ''
    end
    object editLargura: TMaskEdit
      Left = 154
      Top = 160
      Width = 52
      Height = 21
      TabOrder = 10
      Text = ''
    end
    object editComprimento: TMaskEdit
      Left = 281
      Top = 160
      Width = 60
      Height = 21
      TabOrder = 11
      Text = ''
    end
    object editDiametro: TMaskEdit
      Left = 65
      Top = 191
      Width = 52
      Height = 21
      TabOrder = 12
      Text = ''
    end
    object editValorDeclarado: TMaskEdit
      Left = 209
      Top = 191
      Width = 132
      Height = 21
      TabOrder = 13
      Text = ''
    end
    object checkMaoPropria: TCheckBox
      Left = 15
      Top = 224
      Width = 97
      Height = 17
      Caption = 'M'#227'o Propria'
      TabOrder = 14
    end
    object checkAvisoRecebimento: TCheckBox
      Left = 128
      Top = 224
      Width = 111
      Height = 17
      Caption = 'Aviso Recebimento'
      TabOrder = 15
    end
  end
end
