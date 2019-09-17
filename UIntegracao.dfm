object frmIntegracao: TfrmIntegracao
  Left = 287
  Top = 33
  Width = 1055
  Height = 651
  BorderIcons = [biSystemMenu]
  Caption = 'Integra'#231#227'o Cont'#225'bil   (v.1.0.12   17/09/2019)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object RzPageControl1: TRzPageControl
    Left = 0
    Top = 0
    Width = 1047
    Height = 620
    ActivePage = TS_Geracao
    ActivePageDefault = TS_Geracao
    Align = alClient
    TabIndex = 1
    TabOrder = 0
    FixedDimension = 19
    object TS_Menu: TRzTabSheet
      Caption = 'Menu'
      object btnOperacoes: TNxButton
        Left = 10
        Top = 7
        Width = 199
        Height = 34
        Caption = 'Cadastro de Opera'#231#245'es'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = btnOperacoesClick
      end
      object btnPlanoContas: TNxButton
        Left = 10
        Top = 48
        Width = 199
        Height = 34
        Caption = 'Converte Plano de Contas'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = btnPlanoContasClick
      end
    end
    object TS_Geracao: TRzTabSheet
      Caption = 'Gera'#231#227'o Arq. Cont'#225'bil'
      object gbxVendedor: TRzGroupBox
        Left = 0
        Top = 229
        Width = 1043
        Height = 368
        Align = alClient
        BorderColor = clNavy
        BorderInner = fsButtonUp
        BorderOuter = fsBump
        Caption = ' Erros '
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
        TabOrder = 0
        VisualStyle = vsGradient
        object SMDBGrid1: TSMDBGrid
          Left = 5
          Top = 18
          Width = 1033
          Height = 345
          Align = alClient
          Ctl3D = False
          DataSource = DMIntegracao.dsmErros
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
          ParentCtl3D = False
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clNavy
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Flat = True
          BandsFont.Charset = DEFAULT_CHARSET
          BandsFont.Color = clWindowText
          BandsFont.Height = -11
          BandsFont.Name = 'MS Sans Serif'
          BandsFont.Style = []
          Groupings = <>
          GridStyle.Style = gsCustom
          GridStyle.OddColor = clWindow
          GridStyle.EvenColor = clWindow
          TitleHeight.PixelCount = 24
          FooterColor = clBtnFace
          ExOptions = [eoENTERlikeTAB, eoKeepSelection, eoStandardPopup, eoBLOBEditor, eoTitleWordWrap]
          RegistryKey = 'Software\Scalabium'
          RegistrySection = 'SMDBGrid'
          WidthOfIndicator = 11
          DefaultRowHeight = 17
          ScrollBars = ssHorizontal
          ColCount = 2
          RowCount = 2
          Columns = <
            item
              Expanded = False
              FieldName = 'Erro'
              Width = 855
              Visible = True
            end>
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 110
        Width = 1043
        Height = 119
        Align = alTop
        Color = 13948116
        TabOrder = 1
        object Label6: TLabel
          Left = 88
          Top = 18
          Width = 187
          Height = 13
          Alignment = taRightJustify
          Caption = 'Processando Contas a Receber/Pagar:'
        end
        object RzProgressBar1: TRzProgressBar
          Left = 279
          Top = 8
          Width = 569
          BorderOuter = fsFlat
          BorderWidth = 0
          InteriorOffset = 0
          PartsComplete = 0
          Percent = 0
          TotalParts = 0
        end
        object Label7: TLabel
          Left = 153
          Top = 65
          Width = 122
          Height = 13
          Caption = 'Gerando arquivo cont'#225'bil:'
        end
        object RzProgressBar2: TRzProgressBar
          Left = 279
          Top = 54
          Width = 569
          BorderOuter = fsFlat
          BorderWidth = 0
          InteriorOffset = 0
          PartsComplete = 0
          Percent = 0
          TotalParts = 0
        end
        object Label8: TLabel
          Left = 320
          Top = 80
          Width = 387
          Height = 32
          Caption = 'Arquivo gerado com sucesso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object Label21: TLabel
          Left = 142
          Top = 41
          Width = 133
          Height = 13
          Alignment = taRightJustify
          Caption = 'Processando Transfer'#234'ncia:'
        end
        object RzProgressBar4: TRzProgressBar
          Left = 279
          Top = 31
          Width = 569
          BorderOuter = fsFlat
          BorderWidth = 0
          InteriorOffset = 0
          PartsComplete = 0
          Percent = 0
          TotalParts = 0
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 1043
        Height = 110
        Align = alTop
        TabOrder = 2
        object Label1: TLabel
          Left = 120
          Top = 16
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'Filial:'
        end
        object Label2: TLabel
          Left = 96
          Top = 36
          Width = 47
          Height = 13
          Alignment = taRightJustify
          Caption = 'Dt. Inicial:'
        end
        object Label3: TLabel
          Left = 277
          Top = 36
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'Dt. Final:'
        end
        object Label5: TLabel
          Left = 9
          Top = 56
          Width = 134
          Height = 13
          Alignment = taRightJustify
          Caption = 'Pasta para gravar o arquivo:'
        end
        object Label9: TLabel
          Left = 454
          Top = 36
          Width = 41
          Height = 13
          Alignment = taRightJustify
          Caption = 'Dt. Lote:'
        end
        object RxDBLookupCombo1: TRxDBLookupCombo
          Left = 146
          Top = 8
          Width = 473
          Height = 21
          DropDownCount = 8
          Ctl3D = False
          LookupField = 'ID'
          LookupDisplay = 'NOME'
          LookupSource = DMIntegracao.dsFilial
          ParentCtl3D = False
          TabOrder = 0
          OnExit = RxDBLookupCombo1Exit
        end
        object NxDatePicker1: TNxDatePicker
          Left = 146
          Top = 28
          Width = 121
          Height = 21
          TabOrder = 1
          Text = '17/07/2016'
          HideFocus = False
          Date = 42568.000000000000000000
          NoneCaption = 'None'
          TodayCaption = 'Today'
        end
        object NxDatePicker2: TNxDatePicker
          Left = 322
          Top = 28
          Width = 121
          Height = 21
          TabOrder = 2
          Text = '17/07/2016'
          OnExit = NxDatePicker2Exit
          HideFocus = False
          Date = 42568.000000000000000000
          NoneCaption = 'None'
          TodayCaption = 'Today'
        end
        object btnGerar: TNxButton
          Left = 146
          Top = 72
          Width = 120
          Height = 34
          Caption = 'Gerar Arquivo'
          Down = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 5
          OnClick = btnGerarClick
        end
        object DirectoryEdit1: TDirectoryEdit
          Left = 146
          Top = 48
          Width = 473
          Height = 21
          InitialDir = 'C:\'
          MultipleDirs = True
          Ctl3D = False
          NumGlyphs = 1
          ParentCtl3D = False
          TabOrder = 4
          Text = 'C:\'
        end
        object btnFechar: TNxButton
          Left = 266
          Top = 72
          Width = 120
          Height = 34
          Caption = 'Fechar'
          Down = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 6
          OnClick = btnFecharClick
        end
        object NxDatePicker3: TNxDatePicker
          Left = 498
          Top = 28
          Width = 121
          Height = 21
          TabOrder = 3
          Text = '17/07/2016'
          HideFocus = False
          Date = 42568.000000000000000000
          NoneCaption = 'None'
          TodayCaption = 'Today'
        end
        object RzGroupBox1: TRzGroupBox
          Left = 649
          Top = 5
          Width = 312
          Height = 80
          BorderColor = clNavy
          BorderInner = fsButtonUp
          BorderOuter = fsBump
          Caption = ' Informa'#231#245'es do arquivo '
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
          TabOrder = 7
          VisualStyle = vsGradient
          object Label4: TLabel
            Left = 31
            Top = 24
            Width = 64
            Height = 13
            Alignment = taRightJustify
            Caption = 'N'#186' Seq. Lote:'
          end
          object Label10: TLabel
            Left = 20
            Top = 42
            Width = 75
            Height = 13
            Alignment = taRightJustify
            Caption = 'Descri'#231#227'o Lote:'
          end
          object Label11: TLabel
            Left = 10
            Top = 60
            Width = 85
            Height = 13
            Alignment = taRightJustify
            Caption = 'Identificador Lote:'
          end
          object CurrencyEdit1: TCurrencyEdit
            Left = 98
            Top = 16
            Width = 121
            Height = 21
            AutoSize = False
            Ctl3D = False
            DecimalPlaces = 0
            DisplayFormat = '0'
            ParentCtl3D = False
            TabOrder = 0
          end
          object Edit1: TEdit
            Left = 99
            Top = 36
            Width = 207
            Height = 19
            Ctl3D = False
            MaxLength = 20
            ParentCtl3D = False
            TabOrder = 1
          end
          object Edit2: TEdit
            Left = 98
            Top = 54
            Width = 207
            Height = 19
            Ctl3D = False
            MaxLength = 10
            ParentCtl3D = False
            TabOrder = 2
            Text = 'OUT'
          end
        end
      end
    end
    object TS_NotaEnt: TRzTabSheet
      Caption = 'Gera'#231#227'o Nota Entrada'
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 1043
        Height = 110
        Align = alTop
        TabOrder = 0
        object Label12: TLabel
          Left = 120
          Top = 16
          Width = 23
          Height = 13
          Alignment = taRightJustify
          Caption = 'Filial:'
        end
        object Label13: TLabel
          Left = 96
          Top = 36
          Width = 47
          Height = 13
          Alignment = taRightJustify
          Caption = 'Dt. Inicial:'
        end
        object Label14: TLabel
          Left = 271
          Top = 36
          Width = 42
          Height = 13
          Alignment = taRightJustify
          Caption = 'Dt. Final:'
        end
        object Label15: TLabel
          Left = 9
          Top = 57
          Width = 134
          Height = 13
          Alignment = taRightJustify
          Caption = 'Pasta para gravar o arquivo:'
        end
        object Label16: TLabel
          Left = 440
          Top = 36
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Dt.Gera'#231#227'o:'
        end
        object Label20: TLabel
          Left = 640
          Top = 94
          Width = 104
          Height = 13
          Alignment = taRightJustify
          Caption = 'C'#225'lculo do Pis/Cofins:'
        end
        object Label18: TLabel
          Left = 833
          Top = 72
          Width = 68
          Height = 13
          Caption = 'CFOP Padr'#227'o:'
        end
        object RxDBLookupCombo2: TRxDBLookupCombo
          Left = 146
          Top = 8
          Width = 473
          Height = 21
          DropDownCount = 8
          Ctl3D = False
          LookupField = 'ID'
          LookupDisplay = 'NOME'
          LookupSource = DMIntegracao.dsFilial
          ParentCtl3D = False
          TabOrder = 0
          OnExit = RxDBLookupCombo1Exit
        end
        object btnGerarNotaEnt: TNxButton
          Left = 146
          Top = 71
          Width = 120
          Height = 34
          Caption = 'Gerar Arquivo'
          Default = True
          Down = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 2
          OnClick = btnGerarNotaEntClick
        end
        object edtDiretorioArquivo: TDirectoryEdit
          Left = 146
          Top = 49
          Width = 473
          Height = 21
          InitialDir = 'C:\'
          MultipleDirs = True
          Ctl3D = False
          NumGlyphs = 1
          ParentCtl3D = False
          TabOrder = 1
          Text = 'C:\'
        end
        object NxButton2: TNxButton
          Left = 266
          Top = 72
          Width = 120
          Height = 34
          Caption = 'Fechar'
          Down = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 3
          OnClick = btnFecharClick
        end
        object RzGroupBox2: TRzGroupBox
          Left = 649
          Top = 5
          Width = 312
          Height = 44
          BorderColor = clNavy
          BorderInner = fsButtonUp
          BorderOuter = fsBump
          Caption = ' Informa'#231#245'es do arquivo '
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
          object Label17: TLabel
            Left = 31
            Top = 24
            Width = 64
            Height = 13
            Alignment = taRightJustify
            Caption = 'N'#186' Seq. Lote:'
          end
          object CurrencyEdit2: TCurrencyEdit
            Left = 98
            Top = 16
            Width = 121
            Height = 21
            AutoSize = False
            Ctl3D = False
            DecimalPlaces = 0
            DisplayFormat = '0'
            ParentCtl3D = False
            TabOrder = 0
          end
        end
        object ComboBox2: TComboBox
          Left = 748
          Top = 86
          Width = 279
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ItemHeight = 13
          ItemIndex = 0
          ParentFont = False
          TabOrder = 5
          Text = '0=C'#225'lculo de PIS COFINS '#233' conforme vem na nfse'
          Items.Strings = (
            '0=C'#225'lculo de PIS COFINS '#233' conforme vem na nfse'
            '1=Autom'#225'tico')
        end
        object Edit3: TEdit
          Left = 906
          Top = 62
          Width = 121
          Height = 21
          MaxLength = 4
          TabOrder = 6
          Text = '1102'
        end
        object dateInicial: TDateEdit
          Left = 146
          Top = 28
          Width = 116
          Height = 21
          NumGlyphs = 2
          TabOrder = 7
        end
      end
      object dateFinal: TDateEdit
        Left = 316
        Top = 28
        Width = 118
        Height = 21
        NumGlyphs = 2
        TabOrder = 1
      end
      object dateGeracao: TDateEdit
        Left = 500
        Top = 28
        Width = 118
        Height = 21
        NumGlyphs = 2
        TabOrder = 2
      end
      object Panel4: TPanel
        Left = 0
        Top = 110
        Width = 1043
        Height = 81
        Align = alTop
        Color = 13948116
        TabOrder = 3
        object Label19: TLabel
          Left = 144
          Top = 19
          Width = 131
          Height = 13
          Caption = 'Processando Notas Fiscais:'
        end
        object RzProgressBar3: TRzProgressBar
          Left = 279
          Top = 8
          Width = 569
          BorderOuter = fsFlat
          BorderWidth = 0
          InteriorOffset = 0
          PartsComplete = 0
          Percent = 0
          TotalParts = 0
        end
        object Label22: TLabel
          Left = 328
          Top = 36
          Width = 387
          Height = 32
          Caption = 'Arquivo gerado com sucesso'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -27
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
      end
    end
  end
end
