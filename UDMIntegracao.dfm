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
  object sdsNota: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'SELECT N.ID, N.tipo_reg, N.tipo_nota, N.numnota, N.serie, N.id_c' +
      'liente, N.dtemissao,'#13#10'N.dtsaidaentrada, coalesce(COND.TIPO,'#39'X'#39') ' +
      'TIPO_CONDICAO,'#13#10'coalesce(N.tipo_frete,'#39#39') tipo_frete, '#39'N'#39' TIPO_N' +
      'S'#13#10#13#10'FROM NOTAFISCAL N'#13#10'LEFT JOIN condpgto COND'#13#10'ON N.id_condpgt' +
      'o = COND.ID'#13#10'WHERE N.TIPO_REG = '#39'NTE'#39#13#10'and n.dtsaidaentrada betw' +
      'een :Data1 and :Data2'#13#10'and n.FILIAL = :FILIAL'#13#10#13#10'UNION'#13#10#13#10'SELECT' +
      ' NS.ID, NS.tipo_doc, NS.tipo_es, NS.numnota, NS.serie, NS.id_cli' +
      'ente, NS.dtemissao_cad,'#13#10'NS.dtentrada, coalesce(COND.TIPO,'#39'X'#39') T' +
      'IPO_CONDICAO, '#39#39' AS TIPO_FRETE, '#39'S'#39' TIPO_NS'#13#10'FROM NOTASERVICO NS' +
      #13#10'LEFT JOIN condpgto COND'#13#10'ON NS.id_condpgto = COND.ID'#13#10'WHERE NS' +
      '.TIPO_ES = '#39'E'#39#13#10'  and ns.dtentrada between :Data1 and :Data2'#13#10'  ' +
      'and nS.FILIAL = :FILIAL'#13#10#13#10#13#10
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftDate
        Name = 'Data1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'Data2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'FILIAL'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'Data1'
        ParamType = ptInput
      end
      item
        DataType = ftDate
        Name = 'Data2'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'FILIAL'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 208
    Top = 320
  end
  object dspNota: TDataSetProvider
    DataSet = sdsNota
    Left = 256
    Top = 320
  end
  object cdsNota: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspNota'
    Left = 304
    Top = 320
    object cdsNotaID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object cdsNotaTIPO_REG: TStringField
      FieldName = 'TIPO_REG'
      Size = 3
    end
    object cdsNotaTIPO_NOTA: TStringField
      FieldName = 'TIPO_NOTA'
      FixedChar = True
      Size = 1
    end
    object cdsNotaNUMNOTA: TIntegerField
      FieldName = 'NUMNOTA'
    end
    object cdsNotaSERIE: TStringField
      FieldName = 'SERIE'
      Size = 5
    end
    object cdsNotaID_CLIENTE: TIntegerField
      FieldName = 'ID_CLIENTE'
    end
    object cdsNotaDTEMISSAO: TDateField
      FieldName = 'DTEMISSAO'
    end
    object cdsNotaDTSAIDAENTRADA: TDateField
      FieldName = 'DTSAIDAENTRADA'
    end
    object cdsNotaTIPO_CONDICAO: TStringField
      FieldName = 'TIPO_CONDICAO'
      FixedChar = True
      Size = 1
    end
    object cdsNotaTIPO_FRETE: TStringField
      FieldName = 'TIPO_FRETE'
      Size = 1
    end
    object cdsNotaTIPO_NS: TStringField
      FieldName = 'TIPO_NS'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  object dsNota: TDataSource
    DataSet = cdsNota
    Left = 352
    Top = 320
  end
  object sdsItens: TSQLDataSet
    NoMetadata = True
    GetMetadata = False
    CommandText = 
      'select aux.*'#13#10'from ('#13#10'SELECT I.ID_CFOP, I.ID_PRODUTO, I.QTD, I.V' +
      'LR_UNITARIO, I.vlr_total, I.base_ipi,'#13#10'I.base_icms, I.base_icmss' +
      'ubst, I.vlr_icms, I.vlr_ipi, I.vlr_icmssubst, '#39'N'#39' TIPO_NS,'#13#10'i.id' +
      ' id_nota, i.perc_icms, i.vlr_icms_uf_dest, i.vlr_icms_uf_remet, ' +
      'i.vlr_icms_fcp_dest,'#13#10'0 base_inss,'#13#10'0 vlr_inss,'#13#10'0 base_calculo,' +
      #13#10'0 vlr_iss,'#13#10'0 vlr_iss_retido,'#13#10'0 vlr_ir,'#13#10'0 vlr_pis,'#13#10'0 vlr_co' +
      'fins,'#13#10'0 vlr_csll,'#13#10'0 retem_inss'#13#10'FROM NOTAFISCAL_ITENS I'#13#10'where' +
      ' i.id = :ID'#13#10#13#10'UNION'#13#10#13#10'SELECT 0, SI.id_servico_int ID_PRODUTO, ' +
      'SI.QTD, SI.VLR_UNITARIO, SI.vlr_total, 0,'#13#10'0, 0, 0, 0, 0, '#39'S'#39' TI' +
      'PO_NS, s.id id_nota, 0 perc_icms, 0 vlr_icms_uf_dest,'#13#10'0 vlr_icm' +
      's_uf_remet, 0 vlr_icms_fcp_dest,'#13#10'si.base_inss,'#13#10'si.vlr_inss,'#13#10's' +
      'i.base_calculo,'#13#10'si.vlr_iss,'#13#10'si.vlr_iss_retido,'#13#10'si.vlr_ir,'#13#10'si' +
      '.vlr_pis,'#13#10'si.vlr_cofins,'#13#10'si.vlr_csll,'#13#10's.retem_inss'#13#10'FROM nota' +
      'servico S'#13#10'INNER JOIN notaservico_itens SI'#13#10'on s.id = si.id'#13#10'whe' +
      're SI.id = :ID) aux'#13#10'where aux.tipo_ns = :TIPO_NS'#13#10#13#10
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ID'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TIPO_NS'
        ParamType = ptInput
      end>
    SQLConnection = dmDatabase.scoDados
    Left = 208
    Top = 376
  end
  object dspItens: TDataSetProvider
    DataSet = sdsItens
    Left = 256
    Top = 376
  end
  object cdsItens: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ID_CFOP'
    Params = <>
    ProviderName = 'dspItens'
    Left = 304
    Top = 376
    object cdsItensID_CFOP: TIntegerField
      FieldName = 'ID_CFOP'
    end
    object cdsItensID_PRODUTO: TIntegerField
      FieldName = 'ID_PRODUTO'
    end
    object cdsItensQTD: TFloatField
      FieldName = 'QTD'
    end
    object cdsItensVLR_UNITARIO: TFloatField
      FieldName = 'VLR_UNITARIO'
    end
    object cdsItensVLR_TOTAL: TFloatField
      FieldName = 'VLR_TOTAL'
    end
    object cdsItensBASE_IPI: TFloatField
      FieldName = 'BASE_IPI'
    end
    object cdsItensBASE_ICMS: TFloatField
      FieldName = 'BASE_ICMS'
    end
    object cdsItensBASE_ICMSSUBST: TFloatField
      FieldName = 'BASE_ICMSSUBST'
    end
    object cdsItensVLR_ICMS: TFloatField
      FieldName = 'VLR_ICMS'
    end
    object cdsItensVLR_IPI: TFloatField
      FieldName = 'VLR_IPI'
    end
    object cdsItensVLR_ICMSSUBST: TFloatField
      FieldName = 'VLR_ICMSSUBST'
    end
    object cdsItensTIPO_NS: TStringField
      FieldName = 'TIPO_NS'
      Required = True
      FixedChar = True
      Size = 1
    end
    object cdsItensID_NOTA: TIntegerField
      FieldName = 'ID_NOTA'
      Required = True
    end
    object cdsItensPERC_ICMS: TFloatField
      FieldName = 'PERC_ICMS'
    end
    object cdsItensVLR_ICMS_UF_DEST: TFloatField
      FieldName = 'VLR_ICMS_UF_DEST'
    end
    object cdsItensVLR_ICMS_UF_REMET: TFloatField
      FieldName = 'VLR_ICMS_UF_REMET'
    end
    object cdsItensVLR_ICMS_FCP_DEST: TFloatField
      FieldName = 'VLR_ICMS_FCP_DEST'
    end
    object cdsItensBASE_INSS: TFloatField
      FieldName = 'BASE_INSS'
    end
    object cdsItensVLR_INSS: TFloatField
      FieldName = 'VLR_INSS'
    end
    object cdsItensBASE_CALCULO: TFloatField
      FieldName = 'BASE_CALCULO'
    end
    object cdsItensVLR_ISS: TFloatField
      FieldName = 'VLR_ISS'
    end
    object cdsItensVLR_ISS_RETIDO: TFloatField
      FieldName = 'VLR_ISS_RETIDO'
    end
    object cdsItensVLR_IR: TFloatField
      FieldName = 'VLR_IR'
    end
    object cdsItensVLR_PIS: TFloatField
      FieldName = 'VLR_PIS'
    end
    object cdsItensVLR_COFINS: TFloatField
      FieldName = 'VLR_COFINS'
    end
    object cdsItensVLR_CSLL: TFloatField
      FieldName = 'VLR_CSLL'
    end
    object cdsItensRETEM_INSS: TStringField
      FieldName = 'RETEM_INSS'
      Size = 11
    end
  end
  object dsItens: TDataSource
    DataSet = cdsItens
    Left = 352
    Top = 376
  end
  object mCFOP: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    Left = 472
    Top = 312
    Data = {
      010200009619E0BD0100000018000000170000000000030000000102074E756D
      4E6F746104000100000000000553657269650100490000000100055749445448
      0200020003000749445F43464F50040001000000000007436F6443464F500100
      4900000001000557494454480200020004000949445F506573736F6104000100
      000000000D434E504A5F454D4954454E54450100490000000100055749445448
      02000200120009566C725F546F74616C080004000000000007566C725F495049
      080004000000000008426173655F495049080004000000000007426173655F53
      5408000400000000000A566C725F49434D535354080004000000000011566C72
      5F49434D535F446966657269646F080004000000000008426173655F49535308
      0004000000000007566C725F49535308000400000000000E566C725F4953535F
      4973656E746F080004000000000006566C725F4952080004000000000007566C
      725F50697308000400000000000A566C725F436F66696E730800040000000000
      08566C725F43534C4C08000400000000000B494E53535F52657469646F010049
      00000001000557494454480200020001000A4953535F52657469646F01004900
      0000010005574944544802000200010010566C725F49434D535F55465F446573
      74080004000000000011566C725F49434D535F55465F52656D65740800040000
      0000000000}
    object mCFOPNumNota: TIntegerField
      FieldName = 'NumNota'
    end
    object mCFOPSerie: TStringField
      FieldName = 'Serie'
      Size = 3
    end
    object mCFOPID_CFOP: TIntegerField
      FieldName = 'ID_CFOP'
    end
    object mCFOPCodCFOP: TStringField
      FieldName = 'CodCFOP'
      Size = 4
    end
    object mCFOPID_Pessoa: TIntegerField
      FieldName = 'ID_Pessoa'
    end
    object mCFOPCNPJ_EMITENTE: TStringField
      FieldName = 'CNPJ_EMITENTE'
      Size = 18
    end
    object mCFOPVlr_Total: TFloatField
      FieldName = 'Vlr_Total'
    end
    object mCFOPVlr_IPI: TFloatField
      FieldName = 'Vlr_IPI'
    end
    object mCFOPBase_IPI: TFloatField
      FieldName = 'Base_IPI'
    end
    object mCFOPBase_ST: TFloatField
      FieldName = 'Base_ST'
    end
    object mCFOPVlr_ICMSST: TFloatField
      FieldName = 'Vlr_ICMSST'
    end
    object mCFOPVlr_ICMS_Diferido: TFloatField
      FieldName = 'Vlr_ICMS_Diferido'
    end
    object mCFOPBase_ISS: TFloatField
      FieldName = 'Base_ISS'
    end
    object mCFOPVlr_ISS: TFloatField
      FieldName = 'Vlr_ISS'
    end
    object mCFOPVlr_ISS_Isento: TFloatField
      FieldName = 'Vlr_ISS_Isento'
    end
    object mCFOPVlr_IR: TFloatField
      FieldName = 'Vlr_IR'
    end
    object mCFOPVlr_Pis: TFloatField
      FieldName = 'Vlr_Pis'
    end
    object mCFOPVlr_Cofins: TFloatField
      FieldName = 'Vlr_Cofins'
    end
    object mCFOPVlr_CSLL: TFloatField
      FieldName = 'Vlr_CSLL'
    end
    object mCFOPINSS_Retido: TStringField
      FieldName = 'INSS_Retido'
      Size = 1
    end
    object mCFOPISS_Retido: TStringField
      FieldName = 'ISS_Retido'
      Size = 1
    end
    object mCFOPVlr_ICMS_UF_Dest: TFloatField
      FieldName = 'Vlr_ICMS_UF_Dest'
    end
    object mCFOPVlr_ICMS_UF_Remet: TFloatField
      FieldName = 'Vlr_ICMS_UF_Remet'
    end
  end
  object mProd: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'ID_CFOP'
        DataType = ftInteger
      end
      item
        Name = 'Cod_Produto'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'Qtd'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Unitario'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Total'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Desconto'
        DataType = ftFloat
      end
      item
        Name = 'Base_ICMS'
        DataType = ftFloat
      end
      item
        Name = 'Perc_ICMS'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_IPI'
        DataType = ftFloat
      end
      item
        Name = 'Base_ICMSST'
        DataType = ftFloat
      end
      item
        Name = 'Perc_IPI'
        DataType = ftFloat
      end
      item
        Name = 'Perc_Red_ICMS'
        DataType = ftFloat
      end
      item
        Name = 'CODCST_ICMS'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Identificacao'
        DataType = ftString
        Size = 15
      end
      item
        Name = 'CODCST_IPI'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'Base_IPI'
        DataType = ftFloat
      end
      item
        Name = 'CODCST_PIS'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Base_PIS'
        DataType = ftFloat
      end
      item
        Name = 'Perc_Pis'
        DataType = ftFloat
      end
      item
        Name = 'Qtd_Base_Pis'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Pis'
        DataType = ftFloat
      end
      item
        Name = 'CODCST_Cofins'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'Base_Cofins'
        DataType = ftFloat
      end
      item
        Name = 'Perc_Cofins'
        DataType = ftFloat
      end
      item
        Name = 'Qtd_Base_Cofins'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Cofins'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Icms_ST'
        DataType = ftFloat
      end
      item
        Name = 'Perc_Icms_ST'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Icms'
        DataType = ftFloat
      end
      item
        Name = 'CodCFOP'
        DataType = ftString
        Size = 4
      end
      item
        Name = 'Unidade'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'Base_Icms_Diferencial'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Icms_Origem'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Icms_Interno'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Icms_Recolher'
        DataType = ftFloat
      end
      item
        Name = 'Base_Icms_Ant'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Icms_Ori_Ant'
        DataType = ftFloat
      end
      item
        Name = 'Simples'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Proprio_Terceiro'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'Vlr_Frete'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Seguro'
        DataType = ftFloat
      end
      item
        Name = 'Vlr_Despesas'
        DataType = ftFloat
      end>
    IndexDefs = <>
    IndexFieldNames = 'ID_CFOP'
    MasterFields = 'ID_CFOP'
    MasterSource = dsmCFOP
    PacketRecords = 0
    Params = <>
    StoreDefs = True
    Left = 472
    Top = 368
    Data = {
      D30300009619E0BD01000000180000002A000000000003000000D3030749445F
      43464F5004000100000000000B436F645F50726F6475746F0100490000000100
      055749445448020002000A000351746408000400000000000C566C725F556E69
      746172696F080004000000000009566C725F546F74616C08000400000000000C
      566C725F446573636F6E746F080004000000000009426173655F49434D530800
      04000000000009506572635F49434D53080004000000000007566C725F495049
      08000400000000000B426173655F49434D535354080004000000000008506572
      635F49504908000400000000000D506572635F5265645F49434D530800040000
      0000000B434F444353545F49434D530100490000000100055749445448020002
      0003000D4964656E74696669636163616F010049000000010005574944544802
      0002000F000A434F444353545F49504901004900000001000557494454480200
      0200030008426173655F49504908000400000000000A434F444353545F504953
      010049000000010005574944544802000200020008426173655F504953080004
      000000000008506572635F50697308000400000000000C5174645F426173655F
      506973080004000000000007566C725F50697308000400000000000D434F4443
      53545F436F66696E7301004900000001000557494454480200020002000B4261
      73655F436F66696E7308000400000000000B506572635F436F66696E73080004
      00000000000F5174645F426173655F436F66696E7308000400000000000A566C
      725F436F66696E7308000400000000000B566C725F49636D735F535408000400
      000000000C506572635F49636D735F5354080004000000000008566C725F4963
      6D73080004000000000007436F6443464F500100490000000100055749445448
      02000200040007556E6964616465010049000000010005574944544802000200
      060015426173655F49636D735F4469666572656E6369616C0800040000000000
      0F566C725F49636D735F4F726967656D080004000000000010566C725F49636D
      735F496E7465726E6F080004000000000011566C725F49636D735F5265636F6C
      68657208000400000000000D426173655F49636D735F416E7408000400000000
      0010566C725F49636D735F4F72695F416E7408000400000000000753696D706C
      657301004900000001000557494454480200020001001050726F7072696F5F54
      6572636569726F010049000000010005574944544802000200010009566C725F
      467265746508000400000000000A566C725F53656775726F0800040000000000
      0C566C725F446573706573617308000400000000000000}
    object mProdID_CFOP: TIntegerField
      FieldName = 'ID_CFOP'
    end
    object mProdCod_Produto: TStringField
      FieldName = 'Cod_Produto'
      Size = 10
    end
    object mProdQtd: TFloatField
      FieldName = 'Qtd'
    end
    object mProdVlr_Unitario: TFloatField
      FieldName = 'Vlr_Unitario'
    end
    object mProdVlr_Total: TFloatField
      FieldName = 'Vlr_Total'
    end
    object mProdVlr_Desconto: TFloatField
      FieldName = 'Vlr_Desconto'
    end
    object mProdBase_ICMS: TFloatField
      FieldName = 'Base_ICMS'
    end
    object mProdPerc_ICMS: TFloatField
      FieldName = 'Perc_ICMS'
    end
    object mProdVlr_IPI: TFloatField
      FieldName = 'Vlr_IPI'
    end
    object mProdBase_ICMSST: TFloatField
      FieldName = 'Base_ICMSST'
    end
    object mProdPerc_IPI: TFloatField
      FieldName = 'Perc_IPI'
    end
    object mProdPerc_Red_ICMS: TFloatField
      FieldName = 'Perc_Red_ICMS'
    end
    object mProdCODCST_ICMS: TStringField
      FieldName = 'CODCST_ICMS'
      Size = 3
    end
    object mProdIdentificacao: TStringField
      FieldName = 'Identificacao'
      Size = 15
    end
    object mProdCODCST_IPI: TStringField
      FieldName = 'CODCST_IPI'
      Size = 3
    end
    object mProdBase_IPI: TFloatField
      FieldName = 'Base_IPI'
    end
    object mProdCODCST_PIS: TStringField
      FieldName = 'CODCST_PIS'
      Size = 2
    end
    object mProdBase_PIS: TFloatField
      FieldName = 'Base_PIS'
    end
    object mProdPerc_Pis: TFloatField
      FieldName = 'Perc_Pis'
    end
    object mProdQtd_Base_Pis: TFloatField
      FieldName = 'Qtd_Base_Pis'
    end
    object mProdVlr_Pis: TFloatField
      FieldName = 'Vlr_Pis'
    end
    object mProdCODCST_Cofins: TStringField
      FieldName = 'CODCST_Cofins'
      Size = 2
    end
    object mProdBase_Cofins: TFloatField
      FieldName = 'Base_Cofins'
    end
    object mProdPerc_Cofins: TFloatField
      FieldName = 'Perc_Cofins'
    end
    object mProdQtd_Base_Cofins: TFloatField
      FieldName = 'Qtd_Base_Cofins'
    end
    object mProdVlr_Cofins: TFloatField
      FieldName = 'Vlr_Cofins'
    end
    object mProdVlr_Icms_ST: TFloatField
      FieldName = 'Vlr_Icms_ST'
    end
    object mProdPerc_Icms_ST: TFloatField
      FieldName = 'Perc_Icms_ST'
    end
    object mProdVlr_Icms: TFloatField
      FieldName = 'Vlr_Icms'
    end
    object mProdCodCFOP: TStringField
      FieldName = 'CodCFOP'
      Size = 4
    end
    object mProdUnidade: TStringField
      FieldName = 'Unidade'
      Size = 6
    end
    object mProdBase_Icms_Diferencial: TFloatField
      FieldName = 'Base_Icms_Diferencial'
    end
    object mProdVlr_Icms_Origem: TFloatField
      FieldName = 'Vlr_Icms_Origem'
    end
    object mProdVlr_Icms_Interno: TFloatField
      FieldName = 'Vlr_Icms_Interno'
    end
    object mProdVlr_Icms_Recolher: TFloatField
      FieldName = 'Vlr_Icms_Recolher'
    end
    object mProdBase_Icms_Ant: TFloatField
      FieldName = 'Base_Icms_Ant'
    end
    object mProdVlr_Icms_Ori_Ant: TFloatField
      FieldName = 'Vlr_Icms_Ori_Ant'
    end
    object mProdSimples: TStringField
      FieldName = 'Simples'
      Size = 1
    end
    object mProdProprio_Terceiro: TStringField
      FieldName = 'Proprio_Terceiro'
      Size = 1
    end
    object mProdVlr_Frete: TFloatField
      FieldName = 'Vlr_Frete'
    end
    object mProdVlr_Seguro: TFloatField
      FieldName = 'Vlr_Seguro'
    end
    object mProdVlr_Despesas: TFloatField
      FieldName = 'Vlr_Despesas'
    end
  end
  object dsmCFOP: TDataSource
    DataSet = mCFOP
    Left = 496
    Top = 312
  end
end
