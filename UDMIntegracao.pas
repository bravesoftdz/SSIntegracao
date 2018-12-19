unit UDMIntegracao;

interface

uses
  SysUtils, Classes, FMTBcd, DB, SqlExpr, DBClient, Provider;

type
  TDMIntegracao = class(TDataModule)
    qParametros_Geral: TSQLQuery;
    sdsFilial: TSQLDataSet;
    dspFilial: TDataSetProvider;
    cdsFilial: TClientDataSet;
    dsFilial: TDataSource;
    sdsMovimento: TSQLDataSet;
    dspMovimento: TDataSetProvider;
    cdsMovimento: TClientDataSet;
    dsMovimento: TDataSource;
    cdsFilialID: TIntegerField;
    cdsFilialNOME: TStringField;
    cdsFilialENDERECO: TStringField;
    cdsFilialBAIRRO: TStringField;
    cdsFilialCEP: TStringField;
    cdsFilialID_CIDADE: TIntegerField;
    cdsFilialCIDADE: TStringField;
    cdsFilialUF: TStringField;
    cdsFilialNOME_INTERNO: TStringField;
    cdsFilialCOMPLEMENTO_END: TStringField;
    cdsFilialNUM_END: TStringField;
    cdsFilialDDD1: TIntegerField;
    cdsFilialFONE1: TStringField;
    cdsFilialDDD2: TIntegerField;
    cdsFilialFONE: TStringField;
    cdsFilialPESSOA: TStringField;
    cdsFilialCNPJ_CPF: TStringField;
    cdsFilialINSCR_EST: TStringField;
    cdsFilialSIMPLES: TStringField;
    cdsFilialINATIVO: TStringField;
    cdsFilialINSCMUNICIPAL: TStringField;
    cdsFilialCNAE: TStringField;
    cdsFilialID_CONTABILISTA: TIntegerField;
    cdsFilialDDDFAX: TIntegerField;
    cdsFilialFAX: TStringField;
    cdsFilialEMAIL_NFE: TStringField;
    mAuxiliar: TClientDataSet;
    mAuxiliarDtLancamento: TDateField;
    mAuxiliarCod_Debito: TIntegerField;
    mAuxiliarCod_Credito: TIntegerField;
    mAuxiliarCod_Historico: TIntegerField;
    mAuxiliarDesc_Historico: TStringField;
    mAuxiliarVlr_Lancamento: TFloatField;
    mAuxiliarCod_CentroCusto: TIntegerField;
    mAuxiliarClas_Contabil_Deb: TStringField;
    mAuxiliarClas_Contabil_Cre: TStringField;
    mAuxiliarSequencia: TIntegerField;
    mAuxiliarObs: TStringField;
    mAuxiliarCod_CentroCusto2: TIntegerField;
    mErros: TClientDataSet;
    mErrosNumDuplicata: TStringField;
    mErrosParcela: TIntegerField;
    mErrosErro: TStringField;
    dsmAuxiliar: TDataSource;
    dsmErros: TDataSource;
    sdsTitulos_Pagos: TSQLDataSet;
    dspTitulos_Pagos: TDataSetProvider;
    cdsTitulos_Pagos: TClientDataSet;
    cdsTitulos_PagosID: TIntegerField;
    cdsTitulos_PagosID_PESSOA: TIntegerField;
    cdsTitulos_PagosFILIAL: TIntegerField;
    cdsTitulos_PagosID_CONTA: TIntegerField;
    cdsTitulos_PagosID_CONTA_ORCAMENTO: TIntegerField;
    cdsTitulos_PagosDTLANCAMENTO: TDateField;
    cdsTitulos_PagosVLR_PAGAMENTO: TFloatField;
    cdsTitulos_PagosVLR_JUROSPAGOS: TFloatField;
    cdsTitulos_PagosCOD_CONTABIL_CONTAS: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_ORC: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_CLIENTE: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR: TIntegerField;
    cdsTitulos_PagosTIPO_ES: TStringField;
    qParametros_GeralEND_ARQ_INT_CONTABIL: TStringField;
    qParametros_GeralID: TIntegerField;
    cdsTitulos_PagosNUMDUPLICATA: TStringField;
    cdsTitulos_PagosPARCELA: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_JUROS_REC: TIntegerField;
    cdsTitulos_PagosTIPO_MOV: TStringField;
    cdsTitulos_PagosNUMNOTA: TIntegerField;
    cdsTitulos_PagosNOME_PESSOA: TStringField;
    sdsFilial_Contabil: TSQLDataSet;
    dspFilial_Contabil: TDataSetProvider;
    cdsFilial_Contabil: TClientDataSet;
    dsFilial_Contabil: TDataSource;
    sdsFilial_ContabilID: TIntegerField;
    sdsFilial_ContabilCOD_CONTABIL_JUROS_PAGOS: TIntegerField;
    sdsFilial_ContabilCOD_CONTABIL_JUROS_REC: TIntegerField;
    sdsFilial_ContabilNUM_SEQ_LOTE_INTEGRACAO: TIntegerField;
    sdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CRE: TIntegerField;
    sdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CPA: TIntegerField;
    cdsFilial_ContabilID: TIntegerField;
    cdsFilial_ContabilCOD_CONTABIL_JUROS_PAGOS: TIntegerField;
    cdsFilial_ContabilCOD_CONTABIL_JUROS_REC: TIntegerField;
    cdsFilial_ContabilNUM_SEQ_LOTE_INTEGRACAO: TIntegerField;
    cdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CRE: TIntegerField;
    cdsFilial_ContabilID_CONTABIL_OPE_BAIXA_CPA: TIntegerField;
    cdsTitulos_PagosID_CONTABIL_OPE_BAIXA_CRE: TIntegerField;
    cdsTitulos_PagosID_CONTABIL_OPE_BAIXA_CPA: TIntegerField;
    dspContabil_Ope_Lacto: TDataSetProvider;
    cdsContabil_Ope_Lacto: TClientDataSet;
    sdsContabil_Ope_Lacto: TSQLDataSet;
    cdsContabil_Ope_LactoID: TIntegerField;
    cdsContabil_Ope_LactoITEM: TIntegerField;
    cdsContabil_Ope_LactoCONTA_DEBITO: TIntegerField;
    cdsContabil_Ope_LactoCONTA_CREDITO: TIntegerField;
    cdsContabil_Ope_LactoHISTORICO: TStringField;
    cdsContabil_Ope_LactoELEMENTO_VALOR: TStringField;
    cdsContabil_Ope_LactoOPERACAO_SD: TStringField;
    cdsContabil_Ope_LactoCOD_HISTORICO: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_DESC_CRE: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_DESC_CPA: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_MULTA_CRE: TIntegerField;
    cdsTitulos_PagosCOD_CONTABIL_MULTA_CPA: TIntegerField;
    cdsTitulos_PagosNUMCHEQUE: TIntegerField;
    cdsTitulos_PagosSERIE: TStringField;
    cdsTitulos_PagosDTVENCIMENTO: TDateField;
    cdsTitulos_PagosDTEMISSAO: TDateField;
    cdsTitulos_PagosVLR_MULTA: TFloatField;
    cdsTitulos_PagosVLR_DESCONTOS: TFloatField;
    cdsTitulos_PagosVLR_PARCELA: TFloatField;
    cdsTitulos_PagosID_CONTABIL_OPE_BAIXA: TIntegerField;
    cdsTitulos_PagosDESCRICAO: TStringField;
    cdsTitulos_PagosMES_REF: TIntegerField;
    cdsTitulos_PagosANO_REF: TIntegerField;
    mPlano: TClientDataSet;
    mPlanoClassificacao_Cont: TStringField;
    mPlanoReservado_Ebs: TStringField;
    mPlanoCod_Reduzida: TStringField;
    mPlanoNome_Conta: TStringField;
    mPlanoGrau: TStringField;
    mPlanoTipo_Conta: TStringField;
    mPlanoNatureza: TStringField;
    mPlanoSinal: TStringField;
    dsmPlano: TDataSource;
    mPlanoSaldo: TStringField;
    sdsPessoa: TSQLDataSet;
    dspPessoa: TDataSetProvider;
    cdsPessoa: TClientDataSet;
    cdsPessoaCODIGO: TIntegerField;
    cdsPessoaNOME: TStringField;
    cdsPessoaCOD_ALFA: TStringField;
    SQLDataSet1: TSQLDataSet;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ctNotaFiscal : String;
  end;

var
  DMIntegracao: TDMIntegracao;

implementation

uses DmdDatabase;

{$R *.dfm}

procedure TDMIntegracao.DataModuleCreate(Sender: TObject);
begin
  qParametros_Geral.Open;
  cdsFilial.Open;
end;


end.
