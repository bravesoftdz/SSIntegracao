object DMIntegracao: TDMIntegracao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 278
  Top = 131
  Height = 551
  Width = 1000
  object qParametros_Geral: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT *'
      'FROM PARAMETROS_GERAL')
    SQLConnection = dmDatabase.scoDados
    Left = 504
    Top = 48
    object qParametros_GeralID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object qParametros_GeralEND_ARQ_INT_CONTABIL: TStringField
      FieldName = 'END_ARQ_INT_CONTABIL'
      Size = 200
    end
  end
  object sdsFilial: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM FILIAL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 720
    Top = 16
  end
  object dspFilial: TDataSetProvider
    DataSet = sdsFilial
    Left = 768
    Top = 16
  end
  object cdsFilial: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFilial'
    Left = 808
    Top = 16
    object cdsFilialID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsFilialNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsFilialENDERECO: TStringField
      FieldName = 'ENDERECO'
      Size = 60
    end
    object cdsFilialBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Size = 30
    end
    object cdsFilialCEP: TStringField
      FieldName = 'CEP'
      Size = 9
    end
    object cdsFilialID_CIDADE: TIntegerField
      FieldName = 'ID_CIDADE'
    end
    object cdsFilialCIDADE: TStringField
      FieldName = 'CIDADE'
      Size = 40
    end
    object cdsFilialUF: TStringField
      FieldName = 'UF'
      Size = 2
    end
    object cdsFilialNOME_INTERNO: TStringField
      FieldName = 'NOME_INTERNO'
      Size = 30
    end
    object cdsFilialCOMPLEMENTO_END: TStringField
      FieldName = 'COMPLEMENTO_END'
      Size = 60
    end
    object cdsFilialNUM_END: TStringField
      FieldName = 'NUM_END'
      Size = 15
    end
    object cdsFilialDDD1: TIntegerField
      FieldName = 'DDD1'
    end
    object cdsFilialFONE1: TStringField
      FieldName = 'FONE1'
      Size = 15
    end
    object cdsFilialDDD2: TIntegerField
      FieldName = 'DDD2'
    end
    object cdsFilialFONE: TStringField
      FieldName = 'FONE'
      Size = 15
    end
    object cdsFilialPESSOA: TStringField
      FieldName = 'PESSOA'
      FixedChar = True
      Size = 1
    end
    object cdsFilialCNPJ_CPF: TStringField
      FieldName = 'CNPJ_CPF'
      Size = 18
    end
    object cdsFilialINSCR_EST: TStringField
      FieldName = 'INSCR_EST'
      Size = 18
    end
    object cdsFilialSIMPLES: TStringField
      FieldName = 'SIMPLES'
      FixedChar = True
      Size = 1
    end
    object cdsFilialINATIVO: TStringField
      FieldName = 'INATIVO'
      FixedChar = True
      Size = 1
    end
    object cdsFilialINSCMUNICIPAL: TStringField
      FieldName = 'INSCMUNICIPAL'
      Size = 18
    end
    object cdsFilialCNAE: TStringField
      FieldName = 'CNAE'
      Size = 7
    end
    object cdsFilialID_CONTABILISTA: TIntegerField
      FieldName = 'ID_CONTABILISTA'
    end
    object cdsFilialDDDFAX: TIntegerField
      FieldName = 'DDDFAX'
    end
    object cdsFilialFAX: TStringField
      FieldName = 'FAX'
      Size = 15
    end
    object cdsFilialEMAIL_NFE: TStringField
      FieldName = 'EMAIL_NFE'
      Size = 200
    end
  end
  object dsFilial: TDataSource
    DataSet = cdsFilial
    Left = 844
    Top = 16
  end
  object sdsMovimento: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'SELECT M.*, PRO.unidade UNIDADE_PRODUTO_CAD, PRO.nome NOME_PRODU' +
      'TO_CAD, PRO.cod_barra COD_BARRA_CAD,'#13#10'PRO.sped_tipo_item, NCM.NC' +
      'M, CFOP.CODCFOP, CFOP.NOME NOME_CFOP, PES.usa_tamanho_agrupado_n' +
      'fe, pro.ncm_ex'#13#10'FROM MOVIMENTO M'#13#10'LEFT JOIN PRODUTO PRO'#13#10'ON M.id' +
      '_produto = PRO.ID'#13#10'LEFT JOIN PESSOA PES'#13#10'ON M.id_pessoa = PES.CO' +
      'DIGO'#13#10'LEFT JOIN TAB_NCM NCM'#13#10'ON PRO.ID_NCM = NCM.ID'#13#10'LEFT JOIN T' +
      'AB_CFOP CFOP'#13#10'ON M.ID_CFOP = CFOP.ID'#13#10'WHERE (M.dtentradasaida be' +
      'tween :DT_INICIAL AND :DT_FINAL)'#13#10'  and M.FILIAL = :FILIAL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'DT_INICIAL'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DT_FINAL'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'FILIAL'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 56
    Top = 24
  end
  object dspMovimento: TDataSetProvider
    DataSet = sdsMovimento
    Left = 104
    Top = 24
  end
  object cdsMovimento: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMovimento'
    Left = 152
    Top = 24
  end
  object dsMovimento: TDataSource
    DataSet = cdsMovimento
    Left = 200
    Top = 24
  end
  object mAuxiliar: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'DtLancamento'
        DataType = ftDate
      end
      item
        Name = 'Cod_Debito'
        DataType = ftInteger
      end
      item
        Name = 'Cod_Credito'
        DataType = ftInteger
      end
      item
        Name = 'Cod_Historico'
        DataType = ftInteger
      end
      item
        Name = 'Desc_Historico'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'Vlr_Lancamento'
        DataType = ftFloat
      end
      item
        Name = 'Cod_CentroCusto'
        DataType = ftInteger
      end
      item
        Name = 'Clas_Contabil_Deb'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'Clas_Contabil_Cre'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'Sequencia'
        DataType = ftInteger
      end
      item
        Name = 'Obs'
        DataType = ftString
        Size = 90
      end
      item
        Name = 'Cod_CentroCusto2'
        DataType = ftInteger
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 376
    Top = 136
    Data = {
      4D0100009619E0BD01000000180000000C0000000000030000004D010C44744C
      616E63616D656E746F04000600000000000A436F645F44656269746F04000100
      000000000B436F645F4372656469746F04000100000000000D436F645F486973
      746F7269636F04000100000000000E446573635F486973746F7269636F010049
      00000001000557494454480200020096000E566C725F4C616E63616D656E746F
      08000400000000000F436F645F43656E74726F437573746F0400010000000000
      11436C61735F436F6E746162696C5F4465620100490000000100055749445448
      020002000E0011436C61735F436F6E746162696C5F4372650100490000000100
      055749445448020002000E000953657175656E6369610400010000000000034F
      62730100490000000100055749445448020002005A0010436F645F43656E7472
      6F437573746F3204000100000000000000}
    object mAuxiliarDtLancamento: TDateField
      FieldName = 'DtLancamento'
    end
    object mAuxiliarCod_Debito: TIntegerField
      FieldName = 'Cod_Debito'
    end
    object mAuxiliarCod_Credito: TIntegerField
      FieldName = 'Cod_Credito'
    end
    object mAuxiliarCod_Historico: TIntegerField
      FieldName = 'Cod_Historico'
    end
    object mAuxiliarDesc_Historico: TStringField
      FieldName = 'Desc_Historico'
      Size = 150
    end
    object mAuxiliarVlr_Lancamento: TFloatField
      FieldName = 'Vlr_Lancamento'
    end
    object mAuxiliarCod_CentroCusto: TIntegerField
      FieldName = 'Cod_CentroCusto'
    end
    object mAuxiliarClas_Contabil_Deb: TStringField
      FieldName = 'Clas_Contabil_Deb'
      Size = 14
    end
    object mAuxiliarClas_Contabil_Cre: TStringField
      FieldName = 'Clas_Contabil_Cre'
      Size = 14
    end
    object mAuxiliarSequencia: TIntegerField
      FieldName = 'Sequencia'
    end
    object mAuxiliarObs: TStringField
      FieldName = 'Obs'
      Size = 90
    end
    object mAuxiliarCod_CentroCusto2: TIntegerField
      FieldName = 'Cod_CentroCusto2'
    end
  end
  object mErros: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 136
    Data = {
      640000009619E0BD01000000180000000300000000000300000064000C4E756D
      4475706C69636174610100490000000100055749445448020002001400075061
      7263656C610400010000000000044572726F0100490000000100055749445448
      02000200C8000000}
    object mErrosNumDuplicata: TStringField
      FieldName = 'NumDuplicata'
    end
    object mErrosParcela: TIntegerField
      FieldName = 'Parcela'
    end
    object mErrosErro: TStringField
      FieldName = 'Erro'
      Size = 200
    end
  end
  object dsmAuxiliar: TDataSource
    DataSet = mAuxiliar
    Left = 408
    Top = 136
  end
  object dsmErros: TDataSource
    DataSet = mErros
    Left = 512
    Top = 136
  end
  object sdsTitulos_Pagos: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'SELECT D.ID, D.id_pessoa, D.filial, D.id_conta, d.id_conta_orcam' +
      'ento,'#13#10'H.dtlancamento, H.vlr_pagamento, H.vlr_jurospagos, d.numd' +
      'uplicata, d.parcela,'#13#10'CT.cod_contabil COD_CONTABIL_CONTAS, ORC.c' +
      'od_contabil COD_CONTABIL_ORC,'#13#10'P.cod_contabil_cliente, P.cod_con' +
      'tabil_fornecedor, D.tipo_es,'#13#10'FC.cod_contabil_juros_pagos, FC.co' +
      'd_contabil_juros_rec, D.tipo_mov,'#13#10'd.numnota, p.nome NOME_PESSOA' +
      ', FC.id_contabil_ope_baixa_cre,'#13#10'FC.id_contabil_ope_baixa_cpa, f' +
      'c.cod_contabil_desc_cre, fc.cod_contabil_desc_cpa,'#13#10'fc.cod_conta' +
      'bil_multa_cre, fc.cod_contabil_multa_cpa, D.numcheque, D.serie,'#13 +
      #10'd.dtvencimento, d.dtemissao, h.vlr_multa, h.vlr_descontos, d.vl' +
      'r_parcela, d.descricao,'#13#10' d.mes_ref, d.ano_ref,'#13#10'case'#13#10'  when d.' +
      'id_contabil_ope_baixa > 0 and d.tipo_es = '#39'E'#39' then d.id_contabil' +
      '_ope_baixa'#13#10'  when coalesce(d.id_contabil_ope_baixa,0) <= 0 and ' +
      'd.tipo_es = '#39'E'#39' then fc.id_contabil_ope_baixa_cre'#13#10'  when d.id_c' +
      'ontabil_ope_baixa > 0 and d.tipo_es = '#39'S'#39' then d.id_contabil_ope' +
      '_baixa'#13#10'  when coalesce(d.id_contabil_ope_baixa,0) <= 0 and d.ti' +
      'po_es = '#39'S'#39' then fc.id_contabil_ope_baixa_cpa'#13#10'  end id_contabil' +
      '_ope_baixa'#13#10#13#10'FROM DUPLICATA D'#13#10'INNER JOIN DUPLICATA_HIST H'#13#10'ON ' +
      'D.id = H.ID'#13#10'INNER JOIN PESSOA P'#13#10'ON D.id_pessoa = P.codigo'#13#10'INN' +
      'ER JOIN FILIAL F'#13#10'ON D.filial = F.ID'#13#10'LEFT JOIN FILIAL_CONTABIL ' +
      'FC'#13#10'ON D.FILIAL = FC.ID'#13#10'LEFT JOIN CONTAS CT'#13#10'ON D.ID_CONTA = CT' +
      '.ID'#13#10'LEFT JOIN conta_orcamento ORC'#13#10'ON D.id_conta_orcamento = OR' +
      'C.id'#13#10'WHERE H.dtlancamento between :DTINICIAL and :DTFINAL'#13#10'  an' +
      'd D.FILIAL = :FILIAL'#13#10'  and h.tipo_historico = '#39'PAG'#39#13#10
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'DTINICIAL'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DTFINAL'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'FILIAL'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 728
    Top = 184
  end
  object dspTitulos_Pagos: TDataSetProvider
    DataSet = sdsTitulos_Pagos
    Left = 776
    Top = 184
  end
  object cdsTitulos_Pagos: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTitulos_Pagos'
    Left = 816
    Top = 184
    object cdsTitulos_PagosID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsTitulos_PagosID_PESSOA: TIntegerField
      FieldName = 'ID_PESSOA'
    end
    object cdsTitulos_PagosFILIAL: TIntegerField
      FieldName = 'FILIAL'
    end
    object cdsTitulos_PagosID_CONTA: TIntegerField
      FieldName = 'ID_CONTA'
    end
    object cdsTitulos_PagosID_CONTA_ORCAMENTO: TIntegerField
      FieldName = 'ID_CONTA_ORCAMENTO'
    end
    object cdsTitulos_PagosDTLANCAMENTO: TDateField
      FieldName = 'DTLANCAMENTO'
    end
    object cdsTitulos_PagosVLR_PAGAMENTO: TFloatField
      FieldName = 'VLR_PAGAMENTO'
    end
    object cdsTitulos_PagosVLR_JUROSPAGOS: TFloatField
      FieldName = 'VLR_JUROSPAGOS'
    end
    object cdsTitulos_PagosCOD_CONTABIL_CONTAS: TIntegerField
      FieldName = 'COD_CONTABIL_CONTAS'
    end
    object cdsTitulos_PagosCOD_CONTABIL_ORC: TIntegerField
      FieldName = 'COD_CONTABIL_ORC'
    end
    object cdsTitulos_PagosCOD_CONTABIL_CLIENTE: TIntegerField
      FieldName = 'COD_CONTABIL_CLIENTE'
    end
    object cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR: TIntegerField
      FieldName = 'COD_CONTABIL_FORNECEDOR'
    end
    object cdsTitulos_PagosTIPO_ES: TStringField
      FieldName = 'TIPO_ES'
      Size = 1
    end
    object cdsTitulos_PagosNUMDUPLICATA: TStringField
      FieldName = 'NUMDUPLICATA'
    end
    object cdsTitulos_PagosPARCELA: TIntegerField
      FieldName = 'PARCELA'
    end
    object cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS: TIntegerField
      FieldName = 'COD_CONTABIL_JUROS_PAGOS'
    end
    object cdsTitulos_PagosCOD_CONTABIL_JUROS_REC: TIntegerField
      FieldName = 'COD_CONTABIL_JUROS_REC'
    end
    object cdsTitulos_PagosTIPO_MOV: TStringField
      FieldName = 'TIPO_MOV'
      FixedChar = True
      Size = 1
    end
    object cdsTitulos_PagosNUMNOTA: TIntegerField
      FieldName = 'NUMNOTA'
    end
    object cdsTitulos_PagosNOME_PESSOA: TStringField
      FieldName = 'NOME_PESSOA'
      Size = 60
    end
    object cdsTitulos_PagosID_CONTABIL_OPE_BAIXA_CRE: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA_CRE'
    end
    object cdsTitulos_PagosID_CONTABIL_OPE_BAIXA_CPA: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA_CPA'
    end
    object cdsTitulos_PagosCOD_CONTABIL_DESC_CRE: TIntegerField
      FieldName = 'COD_CONTABIL_DESC_CRE'
    end
    object cdsTitulos_PagosCOD_CONTABIL_DESC_CPA: TIntegerField
      FieldName = 'COD_CONTABIL_DESC_CPA'
    end
    object cdsTitulos_PagosCOD_CONTABIL_MULTA_CRE: TIntegerField
      FieldName = 'COD_CONTABIL_MULTA_CRE'
    end
    object cdsTitulos_PagosCOD_CONTABIL_MULTA_CPA: TIntegerField
      FieldName = 'COD_CONTABIL_MULTA_CPA'
    end
    object cdsTitulos_PagosNUMCHEQUE: TIntegerField
      FieldName = 'NUMCHEQUE'
    end
    object cdsTitulos_PagosSERIE: TStringField
      FieldName = 'SERIE'
      Size = 3
    end
    object cdsTitulos_PagosDTVENCIMENTO: TDateField
      FieldName = 'DTVENCIMENTO'
    end
    object cdsTitulos_PagosDTEMISSAO: TDateField
      FieldName = 'DTEMISSAO'
    end
    object cdsTitulos_PagosVLR_MULTA: TFloatField
      FieldName = 'VLR_MULTA'
    end
    object cdsTitulos_PagosVLR_DESCONTOS: TFloatField
      FieldName = 'VLR_DESCONTOS'
    end
    object cdsTitulos_PagosVLR_PARCELA: TFloatField
      FieldName = 'VLR_PARCELA'
    end
    object cdsTitulos_PagosID_CONTABIL_OPE_BAIXA: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA'
    end
    object cdsTitulos_PagosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 70
    end
    object cdsTitulos_PagosMES_REF: TIntegerField
      FieldName = 'MES_REF'
    end
    object cdsTitulos_PagosANO_REF: TIntegerField
      FieldName = 'ANO_REF'
    end
  end
  object sdsFilial_Contabil: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM FILIAL_CONTABIL'#13#10'WHERE ID = :ID'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 720
    Top = 72
    object sdsFilial_ContabilID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object sdsFilial_ContabilCOD_CONTABIL_JUROS_PAGOS: TIntegerField
      FieldName = 'COD_CONTABIL_JUROS_PAGOS'
    end
    object sdsFilial_ContabilCOD_CONTABIL_JUROS_REC: TIntegerField
      FieldName = 'COD_CONTABIL_JUROS_REC'
    end
    object sdsFilial_ContabilNUM_SEQ_LOTE_INTEGRACAO: TIntegerField
      FieldName = 'NUM_SEQ_LOTE_INTEGRACAO'
    end
    object sdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CRE: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA_CRE'
    end
    object sdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CPA: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA_CPA'
    end
  end
  object dspFilial_Contabil: TDataSetProvider
    DataSet = sdsFilial_Contabil
    UpdateMode = upWhereKeyOnly
    Left = 768
    Top = 72
  end
  object cdsFilial_Contabil: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFilial_Contabil'
    Left = 808
    Top = 72
    object cdsFilial_ContabilID: TIntegerField
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsFilial_ContabilCOD_CONTABIL_JUROS_PAGOS: TIntegerField
      FieldName = 'COD_CONTABIL_JUROS_PAGOS'
    end
    object cdsFilial_ContabilCOD_CONTABIL_JUROS_REC: TIntegerField
      FieldName = 'COD_CONTABIL_JUROS_REC'
    end
    object cdsFilial_ContabilNUM_SEQ_LOTE_INTEGRACAO: TIntegerField
      FieldName = 'NUM_SEQ_LOTE_INTEGRACAO'
    end
    object cdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CRE: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA_CRE'
    end
    object cdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CPA: TIntegerField
      FieldName = 'ID_CONTABIL_OPE_BAIXA_CPA'
    end
  end
  object dsFilial_Contabil: TDataSource
    DataSet = cdsFilial_Contabil
    Left = 844
    Top = 72
  end
  object sdsContabil_Ope_Lacto: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 'SELECT *'#13#10'FROM contabil_ope_lacto'#13#10'WHERE ID = :ID'#13#10
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 672
    Top = 288
  end
  object dspContabil_Ope_Lacto: TDataSetProvider
    DataSet = sdsContabil_Ope_Lacto
    Left = 720
    Top = 288
  end
  object cdsContabil_Ope_Lacto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspContabil_Ope_Lacto'
    Left = 760
    Top = 288
    object cdsContabil_Ope_LactoID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsContabil_Ope_LactoITEM: TIntegerField
      FieldName = 'ITEM'
      Required = True
    end
    object cdsContabil_Ope_LactoCONTA_DEBITO: TIntegerField
      FieldName = 'CONTA_DEBITO'
    end
    object cdsContabil_Ope_LactoCONTA_CREDITO: TIntegerField
      FieldName = 'CONTA_CREDITO'
    end
    object cdsContabil_Ope_LactoHISTORICO: TStringField
      FieldName = 'HISTORICO'
      Size = 250
    end
    object cdsContabil_Ope_LactoELEMENTO_VALOR: TStringField
      FieldName = 'ELEMENTO_VALOR'
      Size = 200
    end
    object cdsContabil_Ope_LactoOPERACAO_SD: TStringField
      FieldName = 'OPERACAO_SD'
      FixedChar = True
      Size = 1
    end
    object cdsContabil_Ope_LactoCOD_HISTORICO: TIntegerField
      FieldName = 'COD_HISTORICO'
    end
  end
  object mPlano: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Classificacao_Cont'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Reservado_Ebs'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Cod_Reduzida'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'Nome_Conta'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'Grau'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Tipo_Conta'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'Natureza'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Saldo'
        DataType = ftString
        Size = 12
      end
      item
        Name = 'Sinal'
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'Classificacao_Cont'
    Params = <>
    StoreDefs = True
    Left = 400
    Top = 224
    Data = {
      420100009619E0BD010000001800000009000000000003000000420112436C61
      7373696669636163616F5F436F6E740100490000000100055749445448020002
      0014000D52657365727661646F5F456273010049000000010005574944544802
      00020001000C436F645F526564757A6964610100490000000100055749445448
      0200020006000A4E6F6D655F436F6E7461010049000000010005574944544802
      0002001E00044772617501004900000001000557494454480200020001000A54
      69706F5F436F6E74610100490000000100055749445448020002000500084E61
      747572657A6101004900000001000557494454480200020001000553616C646F
      0100490000000100055749445448020002000C000553696E616C010049000000
      010005574944544802000200010001000D44454641554C545F4F524445520200
      820000000000}
    object mPlanoClassificacao_Cont: TStringField
      FieldName = 'Classificacao_Cont'
    end
    object mPlanoReservado_Ebs: TStringField
      FieldName = 'Reservado_Ebs'
      Size = 1
    end
    object mPlanoCod_Reduzida: TStringField
      FieldName = 'Cod_Reduzida'
      Size = 6
    end
    object mPlanoNome_Conta: TStringField
      FieldName = 'Nome_Conta'
      Size = 30
    end
    object mPlanoGrau: TStringField
      FieldName = 'Grau'
      Size = 1
    end
    object mPlanoTipo_Conta: TStringField
      FieldName = 'Tipo_Conta'
      Size = 5
    end
    object mPlanoNatureza: TStringField
      FieldName = 'Natureza'
      Size = 1
    end
    object mPlanoSaldo: TStringField
      FieldName = 'Saldo'
      Size = 12
    end
    object mPlanoSinal: TStringField
      FieldName = 'Sinal'
      Size = 1
    end
  end
  object dsmPlano: TDataSource
    DataSet = mPlano
    Left = 432
    Top = 224
  end
  object sdsPessoa: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'SELECT P.CODIGO, P.NOME, P.COD_ALFA'#13#10'FROM PESSOA P'#13#10'WHERE (P.cod' +
      '_alfa <> '#39#39')'#13#10'  AND (P.cod_alfa IS NOT NULL)'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = dmDatabase.scoDados
    Left = 664
    Top = 352
  end
  object dspPessoa: TDataSetProvider
    DataSet = sdsPessoa
    Left = 712
    Top = 352
  end
  object cdsPessoa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPessoa'
    Left = 752
    Top = 352
    object cdsPessoaCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object cdsPessoaNOME: TStringField
      FieldName = 'NOME'
      Size = 60
    end
    object cdsPessoaCOD_ALFA: TStringField
      FieldName = 'COD_ALFA'
      Size = 15
    end
  end
  object SQLDataSet1: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'SELECT M.*, PRO.unidade UNIDADE_PRODUTO_CAD, PRO.nome NOME_PRODU' +
      'TO_CAD, PRO.cod_barra COD_BARRA_CAD,'#13#10'PRO.sped_tipo_item, NCM.NC' +
      'M, CFOP.CODCFOP, CFOP.NOME NOME_CFOP, PES.usa_tamanho_agrupado_n' +
      'fe, pro.ncm_ex'#13#10'FROM MOVIMENTO M'#13#10'LEFT JOIN PRODUTO PRO'#13#10'ON M.id' +
      '_produto = PRO.ID'#13#10'LEFT JOIN PESSOA PES'#13#10'ON M.id_pessoa = PES.CO' +
      'DIGO'#13#10'LEFT JOIN TAB_NCM NCM'#13#10'ON PRO.ID_NCM = NCM.ID'#13#10'LEFT JOIN T' +
      'AB_CFOP CFOP'#13#10'ON M.ID_CFOP = CFOP.ID'#13#10'WHERE (M.dtentradasaida be' +
      'tween :DT_INICIAL AND :DT_FINAL)'#13#10'  and M.FILIAL = :FILIAL'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'DT_INICIAL'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'DT_FINAL'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'FILIAL'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 296
    Top = 360
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLDataSet1
    Left = 344
    Top = 360
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMovimento'
    Left = 392
    Top = 360
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 440
    Top = 360
  end
end
