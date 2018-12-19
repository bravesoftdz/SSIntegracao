unit UDMCadContabil_Ope;

interface

uses
  SysUtils, Classes, FMTBcd, DB, DBClient, Provider, SqlExpr, LogTypes, Dialogs,
  frxClass, frxDBSet, frxRich, frxExportMail, frxExportPDF;

type
  TDMCadContabil_Ope = class(TDataModule)
    sdsContabil_Ope: TSQLDataSet;
    sdsContabil_Ope_Lacto: TSQLDataSet;
    dsContabil_Ope: TDataSource;
    sdsContabil_Ope_Mestre: TDataSource;
    cdsContabil_Ope: TClientDataSet;
    cdsContabil_Ope_Lacto: TClientDataSet;
    dspContabil_Ope: TDataSetProvider;
    dsContabil_Ope_Lacto: TDataSource;
    sdsConsulta: TSQLDataSet;
    dspConsulta: TDataSetProvider;
    cdsConsulta: TClientDataSet;
    dsConsulta: TDataSource;
    sdsContabil_OpeID: TIntegerField;
    sdsContabil_OpeNOME: TStringField;
    cdsContabil_OpeID: TIntegerField;
    cdsContabil_OpeNOME: TStringField;
    sdsContabil_Ope_LactoID: TIntegerField;
    sdsContabil_Ope_LactoITEM: TIntegerField;
    sdsContabil_Ope_LactoCONTA_DEBITO: TIntegerField;
    sdsContabil_Ope_LactoCONTA_CREDITO: TIntegerField;
    sdsContabil_Ope_LactoHISTORICO: TStringField;
    sdsContabil_Ope_LactoELEMENTO_VALOR: TStringField;
    cdsContabil_OpesdsContabil_Ope_Lacto: TDataSetField;
    cdsConsultaID: TIntegerField;
    cdsConsultaNOME: TStringField;
    cdsContabil_Ope_LactoID: TIntegerField;
    cdsContabil_Ope_LactoITEM: TIntegerField;
    cdsContabil_Ope_LactoCONTA_DEBITO: TIntegerField;
    cdsContabil_Ope_LactoCONTA_CREDITO: TIntegerField;
    cdsContabil_Ope_LactoHISTORICO: TStringField;
    cdsContabil_Ope_LactoELEMENTO_VALOR: TStringField;
    sdsContabil_Ope_LactoOPERACAO_SD: TStringField;
    sdsContabil_Ope_LactoCOD_HISTORICO: TIntegerField;
    cdsContabil_Ope_LactoOPERACAO_SD: TStringField;
    cdsContabil_Ope_LactoCOD_HISTORICO: TIntegerField;
    cdsContabil_Ope_LactoDESC_CONTA_DEBITO: TStringField;
    cdsContabil_Ope_LactoDESC_CONTA_CREDITO: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure dspContabil_OpeUpdateError(Sender: TObject;
      DataSet: TCustomClientDataSet; E: EUpdateError;
      UpdateKind: TUpdateKind; var Response: TResolverResponse);
    procedure cdsContabil_Ope_LactoCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
    procedure DoLogAdditionalValues(ATableName: string; var AValues: TArrayLogData; var UserName: string);
  public
    { Public declarations }
    vMsgErro : String;
    ctCommand : String;
    ctConsulta : String;
    procedure prc_Localizar(ID : Integer);
    procedure prc_Inserir;
    procedure prc_Gravar;
    procedure prc_Excluir;

    procedure prc_Inserir_Lacto;
  end;

var
  DMCadContabil_Ope: TDMCadContabil_Ope;

implementation

uses DmdDatabase, LogProvider, uUtilPadrao;

{$R *.dfm}

{ TDMCadContabil_Ope}

procedure TDMCadContabil_Ope.prc_Inserir;
var
  vAux : Integer;
begin
  if not cdsContabil_Ope.Active then
    prc_Localizar(-1);
  vAux := dmDatabase.ProximaSequencia('CONTABIL_OPE',0);

  cdsContabil_Ope.Insert;
  cdsContabil_OpeID.AsInteger := vAux;
end;

procedure TDMCadContabil_Ope.prc_Excluir;
begin
  if not(cdsContabil_Ope.Active) or (cdsContabil_Ope.IsEmpty) then
    exit;
  cdsContabil_Ope_Lacto.First;
  while not cdsContabil_Ope_Lacto.Eof do
    cdsContabil_Ope_Lacto.Delete;
  cdsContabil_Ope.Delete;
  cdsContabil_Ope.ApplyUpdates(0);
end;

procedure TDMCadContabil_Ope.prc_Gravar;
begin
  vMsgErro := '';
  if trim(cdsContabil_OpeNOME.AsString) = '' then
    vMsgErro := vMsgErro + #13 + '*** Nome não informado!';
  if trim(vMsgErro) <> '' then
    exit;
  cdsContabil_Ope.Post;
  cdsContabil_Ope.ApplyUpdates(0);
end;

procedure TDMCadContabil_Ope.prc_Localizar(ID : Integer); //-1 é para inclusão
begin
  cdsContabil_Ope.Close;
  sdsContabil_Ope.CommandText := ctCommand;
  if ID <> 0 then
    sdsContabil_Ope.CommandText := sdsContabil_Ope.CommandText
                                 + ' WHERE ID = ' + IntToStr(ID);
  cdsContabil_Ope.Open;
  cdsContabil_Ope_Lacto.Close;
  cdsContabil_Ope_Lacto.Open;
  cdsContabil_Ope_Lacto.First;
end;

procedure TDMCadContabil_Ope.DataModuleCreate(Sender: TObject);
var
  i, x: Integer;
  SR: TSearchRec;
  Origem, Destino: string;
  vIndices: string;
  aIndices: array of string;
begin
  ctCommand  := sdsContabil_Ope.CommandText;
  ctConsulta := sdsConsulta.CommandText;
  
  LogProviderList.OnAdditionalValues := DoLogAdditionalValues;
  for i := 0 to (Self.ComponentCount - 1) do
  begin
    if (Self.Components[i] is TClientDataSet) then
    begin
      SetLength(aIndices, 0);
      vIndices := TClientDataSet(Components[i]).IndexFieldNames;
      while (vIndices <> EmptyStr) do
      begin
        SetLength(aIndices, Length(aIndices) + 1);
        x := Pos(';', vIndices);
        if (x = 0) then
        begin
          aIndices[Length(aIndices) - 1] := vIndices;
          vIndices := EmptyStr;
        end
        else
        begin
          aIndices[Length(aIndices) - 1] := Copy(vIndices, 1, x - 1);
          vIndices := Copy(vIndices, x + 1, MaxInt);
        end;
      end;
      LogProviderList.AddProvider(TClientDataSet(Self.Components[i]), TClientDataSet(Self.Components[i]).Name, aIndices);
    end;
  end;
  //***********************
end;

procedure TDMCadContabil_Ope.DoLogAdditionalValues(ATableName: string;
  var AValues: TArrayLogData; var UserName: string);
begin
  UserName := vUsuario;
end;

procedure TDMCadContabil_Ope.dspContabil_OpeUpdateError(Sender: TObject;
  DataSet: TCustomClientDataSet; E: EUpdateError; UpdateKind: TUpdateKind;
  var Response: TResolverResponse);
begin
  dmDatabase.prc_UpdateError(DataSet.Name,UpdateKind,E);
end;

procedure TDMCadContabil_Ope.prc_Inserir_Lacto;
var
  vItemAux : Integer;
begin
  cdsContabil_Ope_Lacto.Last;
  vItemAux := cdsContabil_Ope_LactoITEM.AsInteger;

  cdsContabil_Ope_Lacto.Insert;
  cdsContabil_Ope_LactoID.AsInteger   := cdsContabil_OpeID.AsInteger;
  cdsContabil_Ope_LactoITEM.AsInteger := vItemAux + 1;
end;

procedure TDMCadContabil_Ope.cdsContabil_Ope_LactoCalcFields(
  DataSet: TDataSet);
begin
  cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := '';
  case cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger of
    1 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Contas/Banco';
    2 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Cliente';
    3 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Fornecedor';
    4 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Juros Pagos';
    5 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Juros Recebidos';
    6 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Cadastro do Orcamento';
    7 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Desconto (C.Receber)';
    8 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Desconto (C.Pagar)';
    9 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Multa (C.Receber)';
   10 : cdsContabil_Ope_LactoDESC_CONTA_DEBITO.AsString := 'Conta Multa (C.Pagar)';
  end;
  cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := '';
  case cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger of
    1 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Contas/Banco';
    2 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Cliente';
    3 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Fornecedor';
    4 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Juros Pagos';
    5 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Juros Recebidos';
    6 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Cadastro do Orcamento';
    7 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Desconto (C.Receber)';
    8 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Desconto (C.Pagar)';
    9 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Multa (C.Receber)';
   10 : cdsContabil_Ope_LactoDESC_CONTA_CREDITO.AsString := 'Conta Multa (C.Pagar)';
  end;
end;

end.
