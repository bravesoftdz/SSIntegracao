object frmConvPlanoContas: TfrmConvPlanoContas
  Left = 270
  Top = 180
  Width = 928
  Height = 480
  Caption = 'frmConvPlanoContas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 912
    Height = 103
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 120
      Top = 16
      Width = 135
      Height = 13
      Alignment = taRightJustify
      Caption = 'Arquivo Plano Contas (EBS):'
    end
    object Label5: TLabel
      Left = 10
      Top = 38
      Width = 245
      Height = 13
      Alignment = taRightJustify
      Caption = 'Pasta para gravar o arquivo Plano de Contas (EBS):'
    end
    object btnGerar: TNxButton
      Left = 256
      Top = 60
      Width = 120
      Height = 34
      Caption = 'Gerar Plano'
      Down = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnGerarClick
    end
    object FilenameEdit1: TFilenameEdit
      Left = 256
      Top = 10
      Width = 528
      Height = 21
      Ctl3D = False
      NumGlyphs = 1
      ParentCtl3D = False
      TabOrder = 1
    end
    object btnFechar: TNxButton
      Left = 376
      Top = 60
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
      TabOrder = 2
      OnClick = btnFecharClick
    end
    object DirectoryEdit1: TDirectoryEdit
      Left = 256
      Top = 30
      Width = 528
      Height = 21
      InitialDir = 'C:\'
      MultipleDirs = True
      Ctl3D = False
      NumGlyphs = 1
      ParentCtl3D = False
      TabOrder = 3
      Text = 'C:\'
    end
  end
  object SMDBGrid1: TSMDBGrid
    Left = 0
    Top = 103
    Width = 912
    Height = 339
    Align = alClient
    DataSource = DMIntegracao.dsmPlano
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Flat = False
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
    ColCount = 10
    RowCount = 2
  end
end
