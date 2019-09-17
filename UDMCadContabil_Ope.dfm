object DMCadContabil_Ope: TDMCadContabil_Ope
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 360
  Top = 108
  Height = 592
  Width = 818
  object sdsContabil_Ope: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM CONTABIL_OPE'#13#10
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 88
    Top = 24
    object sdsContabil_OpeID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sdsContabil_OpeNOME: TStringField
      FieldName = 'NOME'
      Size = 40
    end
    object sdsContabil_OpeNAO_GERAR_ARQ: TStringField
      FieldName = 'NAO_GERAR_ARQ'
      FixedChar = True
      Size = 1
    end
  end
  object sdsContabil_Ope_Lacto: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM CONTABIL_OPE_LACTO'#13#10'WHERE ID = :ID'
    DataSource = sdsContabil_Ope_Mestre
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
        Size = 4
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 88
    Top = 136
    object sdsContabil_Ope_LactoID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sdsContabil_Ope_LactoITEM: TIntegerField
      FieldName = 'ITEM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sdsContabil_Ope_LactoCONTA_DEBITO: TIntegerField
      FieldName = 'CONTA_DEBITO'
    end
    object sdsContabil_Ope_LactoCONTA_CREDITO: TIntegerField
      FieldName = 'CONTA_CREDITO'
    end
    object sdsContabil_Ope_LactoHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Size = 250
    end
    object sdsContabil_Ope_LactoELEMENTO_VALOR: TStringField
      FieldName = 'ELEMENTO_VALOR'
      Size = 200
    end
    object sdsContabil_Ope_LactoOPERACAO_SD: TStringField
      FieldName = 'OPERACAO_SD'
      FixedChar = True
      Size = 1
    end
    object sdsContabil_Ope_LactoCOD_HISTORICO: TIntegerField
      FieldName = 'COD_HISTORICO'
    end
  end
  object dsContabil_Ope: TDataSource
    DataSet = cdsContabil_Ope
    Left = 288
    Top = 24
  end
  object sdsContabil_Ope_Mestre: TDataSource
    DataSet = sdsContabil_Ope
    Left = 56
    Top = 80
  end
  object cdsContabil_Ope: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ID'
    Params = <>
    ProviderName = 'dspContabil_Ope'
    Left = 216
    Top = 24
    object cdsContabil_OpeID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsContabil_OpeNOME: TStringField
      FieldName = 'NOME'
      Size = 40
    end
    object cdsContabil_OpesdsContabil_Ope_Lacto: TDataSetField
      FieldName = 'sdsContabil_Ope_Lacto'
    end
    object cdsContabil_OpeNAO_GERAR_ARQ: TStringField
      FieldName = 'NAO_GERAR_ARQ'
      FixedChar = True
      Size = 1
    end
  end
  object cdsContabil_Ope_Lacto: TClientDataSet
    Aggregates = <>
    DataSetField = cdsContabil_OpesdsContabil_Ope_Lacto
    IndexFieldNames = 'ID;ITEM'
    Params = <>
    OnCalcFields = cdsContabil_Ope_LactoCalcFields
    Left = 176
    Top = 136
    object cdsContabil_Ope_LactoID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsContabil_Ope_LactoITEM: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'Item'
      FieldName = 'ITEM'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsContabil_Ope_LactoCONTA_DEBITO: TIntegerField
      Alignment = taCenter
      FieldName = 'CONTA_DEBITO'
    end
    object cdsContabil_Ope_LactoCONTA_CREDITO: TIntegerField
      Alignment = taCenter
      FieldName = 'CONTA_CREDITO'
    end
    object cdsContabil_Ope_LactoHISTORICO: TStringField
      DisplayLabel = 'Hist'#243'rico'
      FieldName = 'HISTORICO'
      Size = 250
    end
    object cdsContabil_Ope_LactoELEMENTO_VALOR: TStringField
      DisplayLabel = 'Elemento do Valor'
      FieldName = 'ELEMENTO_VALOR'
      Size = 200
    end
    object cdsContabil_Ope_LactoOPERACAO_SD: TStringField
      FieldName = 'OPERACAO_SD'
      FixedChar = True
      Size = 1
    end
    object cdsContabil_Ope_LactoCOD_HISTORICO: TIntegerField
      Alignment = taCenter
      DisplayLabel = 'C'#243'd. Hist'#243'rico'
      FieldName = 'COD_HISTORICO'
    end
    object cdsContabil_Ope_LactoDESC_CONTA_DEBITO: TStringField
      DisplayLabel = 'Descri'#231#227'o Debito'
      FieldKind = fkCalculated
      FieldName = 'DESC_CONTA_DEBITO'
      ProviderFlags = []
      Size = 40
      Calculated = True
    end
    object cdsContabil_Ope_LactoDESC_CONTA_CREDITO: TStringField
      DisplayLabel = 'Descri'#231#227'o Cr'#233'dito'
      FieldKind = fkCalculated
      FieldName = 'DESC_CONTA_CREDITO'
      ProviderFlags = []
      Size = 40
      Calculated = True
    end
  end
  object dspContabil_Ope: TDataSetProvider
    DataSet = sdsContabil_Ope
    UpdateMode = upWhereKeyOnly
    OnUpdateError = dspContabil_OpeUpdateError
    Left = 152
    Top = 24
  end
  object dsContabil_Ope_Lacto: TDataSource
    DataSet = cdsContabil_Ope_Lacto
    Left = 248
    Top = 136
  end
  object sdsConsulta: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM CONTABIL_OPE'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 448
    Top = 8
  end
  object dspConsulta: TDataSetProvider
    DataSet = sdsConsulta
    Left = 480
    Top = 8
  end
  object cdsConsulta: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspConsulta'
    Left = 512
    Top = 8
    object cdsConsultaID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsConsultaNOME: TStringField
      FieldName = 'NOME'
      Size = 40
    end
  end
  object dsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 544
    Top = 8
  end
end
