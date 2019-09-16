object frmCadContabil_Ope_Lacto: TfrmCadContabil_Ope_Lacto
  Left = 393
  Top = 148
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastro dos Itens'
  ClientHeight = 367
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 333
    Width = 430
    Height = 34
    Align = alBottom
    Color = 8404992
    TabOrder = 1
    object BitBtn4: TBitBtn
      Left = 209
      Top = 5
      Width = 98
      Height = 25
      Caption = '(F10) Ca&ncelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = BitBtn4Click
    end
    object BitBtn1: TBitBtn
      Left = 110
      Top = 5
      Width = 98
      Height = 25
      Caption = '&Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 8404992
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 333
    Align = alClient
    Color = clMoneyGreen
    TabOrder = 0
    object Label5: TLabel
      Left = 44
      Top = 49
      Width = 65
      Height = 13
      Alignment = taRightJustify
      Caption = 'Conta Debito:'
    end
    object Label1: TLabel
      Left = 86
      Top = 15
      Width = 23
      Height = 13
      Alignment = taRightJustify
      Caption = 'Item:'
    end
    object Label2: TLabel
      Left = 42
      Top = 72
      Width = 67
      Height = 13
      Alignment = taRightJustify
      Caption = 'Conta Cr'#233'dito:'
    end
    object Label3: TLabel
      Left = 14
      Top = 95
      Width = 95
      Height = 13
      Alignment = taRightJustify
      Caption = 'C'#243'digo do Hist'#243'rico:'
    end
    object RxDBComboBox1: TRxDBComboBox
      Left = 110
      Top = 41
      Width = 152
      Height = 21
      Style = csDropDownList
      DataField = 'CONTA_DEBITO'
      DataSource = DMCadContabil_Ope.dsContabil_Ope_Lacto
      EnableValues = True
      ItemHeight = 13
      Items.Strings = (
        ''
        'Contas/Banco'
        'Cliente'
        'Fornecedor'
        'Juros Pagos'
        'Juros Recebidos'
        'Cadastro do Orcamento'
        'Conta Desconto (C.Receber)'
        'Conta Desconto (C.Pagar)'
        'Conta Multa (C.Receber)'
        'Conta Multa (C.Pagar)'
        'Despesa Banc'#225'ria(C.Receber)'
        'Despesa Banc'#225'ria(C.Pagar)'
        'Transfer'#234'ncia (Origem)'
        'Transfer'#234'ncia (Destino)')
      TabOrder = 0
      Values.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14')
    end
    object DBEdit1: TDBEdit
      Left = 110
      Top = 7
      Width = 83
      Height = 21
      TabStop = False
      Color = clMoneyGreen
      DataField = 'ITEM'
      DataSource = DMCadContabil_Ope.dsContabil_Ope_Lacto
      ReadOnly = True
      TabOrder = 1
    end
    object RxDBComboBox2: TRxDBComboBox
      Left = 110
      Top = 64
      Width = 152
      Height = 21
      Style = csDropDownList
      DataField = 'CONTA_CREDITO'
      DataSource = DMCadContabil_Ope.dsContabil_Ope_Lacto
      EnableValues = True
      ItemHeight = 13
      Items.Strings = (
        ''
        'Contas/Banco'
        'Cliente'
        'Fornecedor'
        'Juros Pagos'
        'Juros Recebidos'
        'Cadastro do Orcamento'
        'Conta Desconto (C.Receber)'
        'Conta Desconto (C.Pagar)'
        'Conta Multa (C.Receber)'
        'Conta Multa (C.Pagar)'
        'Despesa Banc'#225'ria(C.Receber)'
        'Despesa Banc'#225'ria(C.Pagar)'
        'Transfer'#234'ncia (Origem)'
        'Transfer'#234'ncia (Destino)')
      TabOrder = 2
      Values.Strings = (
        '0'
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14')
    end
    object DBEdit3: TDBEdit
      Left = 110
      Top = 87
      Width = 152
      Height = 21
      DataField = 'COD_HISTORICO'
      DataSource = DMCadContabil_Ope.dsContabil_Ope_Lacto
      TabOrder = 3
    end
    object RzGroupBox1: TRzGroupBox
      Left = 14
      Top = 117
      Width = 406
      Height = 100
      BorderColor = clNavy
      BorderInner = fsButtonUp
      BorderOuter = fsBump
      Caption = ' Hist'#243'rico '
      Color = clMoneyGreen
      Ctl3D = True
      FlatColor = clNavy
      FlatColorAdjustment = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 4
      VisualStyle = vsGradient
      object Label6: TLabel
        Left = 12
        Top = 19
        Width = 88
        Height = 13
        Alignment = taRightJustify
        Caption = 'Elemento Cont'#225'bil:'
      end
      object ComboBox1: TComboBox
        Left = 104
        Top = 10
        Width = 215
        Height = 21
        Style = csDropDownList
        DropDownCount = 10
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox1Change
        Items.Strings = (
          ''
          '<NUMNOTA>'
          '<PARCELA>'
          '<RAZAO_EMPRESA>'
          '<NUMCHEQUE>'
          '<SERIENOTA>'
          '<DTEMISSAO>'
          '<DTVENCIMENTO>'
          '<NUMTITULO>'
          '<DESCRICAO_OBS>'
          '<MES_ANO_COMP>'
          '<HIST_DUPLICATA>')
      end
      object DBMemo1: TDBMemo
        Left = 12
        Top = 34
        Width = 387
        Height = 62
        DataField = 'HISTORICO'
        DataSource = DMCadContabil_Ope.dsContabil_Ope_Lacto
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object BitBtn2: TBitBtn
        Left = 322
        Top = 8
        Width = 58
        Height = 25
        Caption = 'Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
        Visible = False
      end
    end
    object RzGroupBox2: TRzGroupBox
      Left = 14
      Top = 221
      Width = 406
      BorderColor = clNavy
      BorderInner = fsButtonUp
      BorderOuter = fsBump
      Caption = ' Valor '
      Color = clMoneyGreen
      Ctl3D = True
      FlatColor = clNavy
      FlatColorAdjustment = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 5
      VisualStyle = vsGradient
      object Label7: TLabel
        Left = 12
        Top = 19
        Width = 88
        Height = 13
        Alignment = taRightJustify
        Caption = 'Elemento Cont'#225'bil:'
      end
      object ComboBox2: TComboBox
        Left = 104
        Top = 10
        Width = 215
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = ComboBox2Change
        Items.Strings = (
          ''
          '<VLR_LANCAMENTO>'
          '<VLR_PAGAMENTO>'
          '<VLR_JUROS>'
          '<VLR_MULTA>'
          '<VLR_DESCONTO>'
          '<VLR_DESPESAS>')
      end
      object DBMemo2: TDBMemo
        Left = 12
        Top = 36
        Width = 387
        Height = 62
        DataField = 'ELEMENTO_VALOR'
        DataSource = DMCadContabil_Ope.dsContabil_Ope_Lacto
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object BitBtn3: TBitBtn
        Left = 322
        Top = 8
        Width = 58
        Height = 25
        Caption = 'Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 8404992
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        TabStop = False
        Visible = False
      end
    end
  end
end
