unit UIntegracao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, UDMIntegracao, RxLookup, NxEdit, Mask,
  ToolEdit, CurrEdit, NxCollection, Grids, DBGrids, SMDBGrid, RzPanel,
  RzPrgres, RzTabs;

type
  TfrmIntegracao = class(TForm)
    RzPageControl1: TRzPageControl;
    TS_Geracao: TRzTabSheet;
    gbxVendedor: TRzGroupBox;
    SMDBGrid1: TSMDBGrid;
    Panel2: TPanel;
    Label6: TLabel;
    RzProgressBar1: TRzProgressBar;
    Label7: TLabel;
    RzProgressBar2: TRzProgressBar;
    Label8: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label9: TLabel;
    RxDBLookupCombo1: TRxDBLookupCombo;
    NxDatePicker1: TNxDatePicker;
    NxDatePicker2: TNxDatePicker;
    btnGerar: TNxButton;
    DirectoryEdit1: TDirectoryEdit;
    btnFechar: TNxButton;
    NxDatePicker3: TNxDatePicker;
    RzGroupBox1: TRzGroupBox;
    Label4: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    CurrencyEdit1: TCurrencyEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    TS_Menu: TRzTabSheet;
    btnOperacoes: TNxButton;
    btnPlanoContas: TNxButton;
    TS_NotaEnt: TRzTabSheet;
    Panel3: TPanel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    RxDBLookupCombo2: TRxDBLookupCombo;
    btnGerarNotaEnt: TNxButton;
    edtDiretorioArquivo: TDirectoryEdit;
    NxButton2: TNxButton;
    RzGroupBox2: TRzGroupBox;
    Label17: TLabel;
    CurrencyEdit2: TCurrencyEdit;
    Label20: TLabel;
    ComboBox2: TComboBox;
    Label18: TLabel;
    Edit3: TEdit;
    dateInicial: TDateEdit;
    dateFinal: TDateEdit;
    dateGeracao: TDateEdit;
    Panel4: TPanel;
    Label19: TLabel;
    RzProgressBar3: TRzProgressBar;
    Label22: TLabel;
    Label21: TLabel;
    RzProgressBar4: TRzProgressBar;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure NxDatePicker2Exit(Sender: TObject);
    procedure btnOperacoesClick(Sender: TObject);
    procedure RxDBLookupCombo1Exit(Sender: TObject);
    procedure btnPlanoContasClick(Sender: TObject);
    procedure btnGerarNotaEntClick(Sender: TObject);
  private
    { Private declarations }
    fDMIntegracao: TDMIntegracao;
    vContador : Integer;
    vVlrTotal : Real;
    vArqTxt : TextFile;
    vHistorico : String;
    vCod_Debito, vCod_Credito : Integer;
    vVlr_Lacto : Real;
    Txt  : TextFile;
    vRegistro : String;
    vArquivo : String;
    vVlrContabil : Real;
    vCont_Hist : Integer;

    procedure prc_Consultar_Titulos_Pagos;
    procedure prc_Consultar_Transferencia;
    procedure prc_Gravar_mAuxiliar(Tipo_Lanc : String); //L=Lancamento  J=Juros
    procedure prc_Gravar_mAuxiliar_Novo(Tipo_Lanc : String); //L=Lancamento  J=Juros
    procedure prc_gravar_mErro(Erro : String);
    procedure prc_Le_Contabil_Ope_Lacto(Tipo_ES : String);
    procedure prc_Le_Contabil_Ope_Lacto_Transf(Tipo_ES : String);
    procedure prc_Montar_DadosComplementares;

    procedure prc_Grava_Lote;
    procedure prc_Grava_Lancamentos;
    procedure prc_Gravar_Historico_H;

    procedure prc_Le_cdsNota;

    function fnc_Monta_Hist(Transferencia : Boolean) : String;
    function fnc_Monta_Vlr(Transferencia : Boolean) : Real;

    procedure prc_Header;
    procedure prc_Emitente_Destinatario;
    procedure prc_Nota_Fiscal;
    procedure prc_Itens_Nota_Fiscal;
    procedure prc_Exclui_mCFOP;
    procedure prc_Montar_CliFor;
    procedure prc_Montar_Trailler;
    function Monta_Numero(Campo: String; Tamanho: Integer): String;

  public
    { Public declarations }
  end;

var
  frmIntegracao: TfrmIntegracao;

implementation

uses rsDBUtils, DB, UCadContabil_Ope, uUtilPadrao, StrUtils,
  UConvPlanoContas, DateUtils;

{$R *.dfm}

procedure TfrmIntegracao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := Cafree;
end;

procedure TfrmIntegracao.FormShow(Sender: TObject);
begin
  fDMIntegracao := TDMIntegracao.Create(Self);
  oDBUtils.SetDataSourceProperties(Self, fDMIntegracao);
  if fDMIntegracao.cdsFilial.RecordCount = 1 then
    RxDBLookupCombo1.KeyValue := fDMIntegracao.cdsFilialID.AsInteger;
  //CurrencyEdit1.AsInteger := fDMIntegracao.cdsFilialNUM_SEQ_LOTE_INTEGRACAO.AsInteger;
  dateGeracao.Date := Date;
  DirectoryEdit1.Text := fDMIntegracao.qParametros_GeralEND_ARQ_INT_CONTABIL.AsString;
  edtDiretorioArquivo.Text := fDMIntegracao.qParametros_GeralEND_ARQ_INT_CONTABIL.AsString;

  NxDatePicker1.Date := EncodeDate(YearOf(Date),MonthOf(Date),01);
  NxDatePicker1.Date := IncMonth(NxDatePicker1.Date,-1);

  NxDatePicker2.Date := EncodeDate(YearOf(Date),MonthOf(NxDatePicker1.Date),DaysInMonth(NxDatePicker1.Date));
  NxDatePicker3.Date := NxDatePicker2.Date;
end;

procedure TfrmIntegracao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fDMIntegracao);
end;

procedure TfrmIntegracao.btnGerarClick(Sender: TObject);
var
  vMSGErro : String;
  vSeparador : String;
  vNomeArq : String;
  i : Integer;
  vTexto1 : String;
begin
  Label8.Visible := False;
  vMSGErro       := '';
  if NxDatePicker1.Date < 10 then
    vMSGErro := vMSGErro + #13 + '*** Data inicial não informada!';
  if NxDatePicker2.Date < 10 then
    vMSGErro := vMSGErro + #13 + '*** Data final não informada!';
  if NxDatePicker1.Date > NxDatePicker2.Date then
    vMSGErro := vMSGErro + #13 + '*** Data inicial não pode ser maior que a final!';
  if trim(RxDBLookupCombo1.Text) = '' then
    vMSGErro := vMSGErro + #13 + '*** Filial não informada!';
  if CurrencyEdit1.AsInteger <= 0 then
    vMSGErro := vMSGErro + #13 + '*** Nº Sequencial do lote não informado!';
  if trim(Edit1.Text) = '' then
    vMSGErro := vMSGErro + #13 + '*** Descrição do lote não informadada!';
  //if trim(Edit2.Text) = '' then
  //  vMSGErro := vMSGErro + #13 + '*** Identificador do lote não informadado!';
  if trim(vMSGErro) <> '' then
  begin
    MessageDlg(vMSGErro, mtError, [mbOk], 0);
    exit;
  end;

  if MessageDlg('Deseja gerar o arquivo auxiliar da integração?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  vContador := 0;
  vVlrTotal := 0;
  fDMIntegracao.mAuxiliar.EmptyDataSet;
  fDMIntegracao.mErros.EmptyDataSet;
  prc_Consultar_Titulos_Pagos;
  prc_Consultar_Transferencia;
  if (fDMIntegracao.cdsTitulos_Pagos.IsEmpty) and (fDMIntegracao.cdsTransferencia.IsEmpty) then
  begin
    MessageDlg('*** Não existe registro para ser gerado!', mtError, [mbOk], 0);
    exit;
  end;

  if Copy(DirectoryEdit1.Text,(Length(DirectoryEdit1.Text)),1) = '\' then
    vSeparador := ''
  else
    vSeparador := '\';

  vTexto1 := Monta_Numero(fDMIntegracao.cdsFilialCNPJ_CPF.AsString,14);
  vNomeArq := 'LOTD' + FormatFloat('00000',CurrencyEdit1.AsInteger) + '_' + vTexto1 + '.TXT';
  vNomeArq := DirectoryEdit1.Text + vSeparador + vNomeArq;

  AssignFile(vArqTxt, vNomeArq);
  ReWrite(vArqTxt);

  try
    RzProgressBar2.TotalParts    := 0;
    RzProgressBar2.PartsComplete := 0;

    RzProgressBar1.TotalParts    := fDMIntegracao.cdsTitulos_Pagos.RecordCount;
    RzProgressBar1.PartsComplete := 0;

    fDMIntegracao.cdsTitulos_Pagos.IndexFieldNames := 'TIPO_ES;DTLANCAMENTO';
    fDMIntegracao.cdsTitulos_Pagos.First;

    while not fDMIntegracao.cdsTitulos_Pagos.Eof do
    begin
      RzProgressBar1.PartsComplete := RzProgressBar1.PartsComplete + 1;
      prc_Le_Contabil_Ope_Lacto(fDMIntegracao.cdsTitulos_PagosTIPO_ES.AsString);
      //prc_Gravar_mAuxiliar('L');
      {prc_Gravar_mAuxiliar_Novo('L');
      if StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_JUROSPAGOS.AsFloat)) > 0 then
        //prc_Gravar_mAuxiliar('J');
        prc_Gravar_mAuxiliar_Novo('J');}
      fDMIntegracao.cdsTitulos_Pagos.Next;
    end;

    //16/09/2019
    RzProgressBar4.TotalParts    := fDMIntegracao.cdsTransferencia.RecordCount;
    RzProgressBar4.PartsComplete := 0;
    fDMIntegracao.cdsTransferencia.First;
    while not fDMIntegracao.cdsTransferencia.Eof do
    begin
      RzProgressBar4.PartsComplete := RzProgressBar1.PartsComplete + 1;
      prc_Le_Contabil_Ope_Lacto_Transf(fDMIntegracao.cdsTransferenciaTIPO_ES.AsString);
      fDMIntegracao.cdsTransferencia.Next;
    end;
    //*******************


    RzProgressBar2.TotalParts    := fDMIntegracao.mAuxiliar.RecordCount;
    RzProgressBar2.PartsComplete := 0;
    prc_Grava_Lote;
    fDMIntegracao.mAuxiliar.First;
    while not fDMIntegracao.mAuxiliar.Eof do
    begin
      RzProgressBar2.PartsComplete := RzProgressBar2.PartsComplete + 1;
      prc_Grava_Lancamentos;
      fDMIntegracao.mAuxiliar.Next;
    end;
    if fDMIntegracao.mErros.IsEmpty then
    begin
      Label8.Font.Color := clBlue;
      Label8.Caption    := 'Arquivo gerado com sucesso'
    end
    else
    begin
      Label8.Font.Color := clRed;
      Label8.Caption    := 'Arquivo gerado com erro';
    end;
    Label8.Visible := True;
  finally
    CloseFile(vArqTxt);
  end;
end;

procedure TfrmIntegracao.prc_Consultar_Titulos_Pagos;
begin
  fDMIntegracao.cdsTitulos_Pagos.Close;
  fDMIntegracao.sdsTitulos_Pagos.ParamByName('DTINICIAL').AsDate := NxDatePicker1.Date;
  fDMIntegracao.sdsTitulos_Pagos.ParamByName('DTFINAL').AsDate   := NxDatePicker2.Date;
  fDMIntegracao.sdsTitulos_Pagos.ParamByName('FILIAL').AsInteger := RxDBLookupCombo1.KeyValue;
  fDMIntegracao.cdsTitulos_Pagos.Open;
end;

procedure TfrmIntegracao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmIntegracao.prc_Grava_Lote;
var
  texto1, texto2 : String;
  i : Integer;

  ano,mes,dia : Word;
begin
  //Tipo Registro
  texto1 := 'C';

  //Tipo do Lote - Diário ou Mensal
  texto1 := texto1 + 'M';

  //Data do Lote
  DecodeDate(NxDatePicker3.Date,ano,mes,dia);
  texto1 := texto1 + FormatFloat('00',dia) + FormatFloat('00',mes) + FormatFloat('0000',ano);

  //Valor Total do Lote
  texto2 := FormatFloat('0000000000000.00',vVlrTotal);
  Delete(texto2,14,1);
  texto1 := texto1 + texto2;

  //Descrição do Lote
  texto2 := copy(Edit1.Text,1,20);
  for i := 1 to 20 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Origem Lançamento
  texto1 := texto1 + 'OUT';

  //Identificador do Lote
  texto2 := copy(Edit2.Text,1,10);
  for i := 1 to 10 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Situação do lote
  texto1 := texto1 + 'L';

  //Situação do lote
  texto2 := Monta_Numero(fDMIntegracao.cdsFilialCNPJ_CPF.AsString,0);
  for i := 1 to 14 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Reservado
  texto2 := '';
  for i := 1 to 22 do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Sequencia
  vContador := 1;
  texto1 := texto1 + FormatFloat('00000',vContador);

  Writeln(vArqTxt,Texto1);
end;

procedure TfrmIntegracao.prc_Grava_Lancamentos;
var
  texto1, texto2 : String;
  i : Integer;
  ano,mes,dia : Word;
begin
  //Tipo Registro
  texto1 := 'L';

  //Data do lançamento - 2 a 9
  DecodeDate(fDMIntegracao.mAuxiliarDtLancamento.AsDateTime,ano,mes,dia);
  texto1 := texto1 + FormatFloat('00',dia) + FormatFloat('00',mes) + FormatFloat('0000',ano);

  //Conta Reduzida a Débito - 10 a 15
  texto2 := fDMIntegracao.mAuxiliarCod_Debito.AsString;
  for i := 1 to 6 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Conta Reduzida a Crédito - 16 a 21
  texto2 := fDMIntegracao.mAuxiliarCod_Credito.AsString;
  for i := 1 to 6 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Histórico Padrão - 22 a 24
  texto2 := Copy(fDMIntegracao.mAuxiliarCod_Historico.AsString,1,3);
  for i := 1 to 3 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Complemento - 25 a 49
  //texto2 := Copy(fDMIntegracao.mAuxiliarDesc_Historico.AsString,1,25);
  vHistorico := fDMIntegracao.mAuxiliarDesc_Historico.AsString;
  texto2 := copy(vHistorico,1,25);
  for i := 1 to 25 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;
  delete(vHistorico,1,25);

  //Valor do lançamento - 50 a 64
  texto2 := FormatFloat('0000000000000.00',fDMIntegracao.mAuxiliarVlr_Lancamento.AsFloat);
  Delete(texto2,14,1);
  texto1 := texto1 + texto2;

  //Código do Centro de Custo - 65 a 67
  texto2 := Copy(fDMIntegracao.mAuxiliarCod_CentroCusto.AsString,1,3);
  for i := 1 to 3 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Classificação Contábil a Débito - 68 a 81
  texto2 := Copy(fDMIntegracao.mAuxiliarClas_Contabil_Deb.AsString,1,14);
  for i := 1 to 14 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Classificação Contábil a Crédito - 82 a 95
  texto2 := Copy(fDMIntegracao.mAuxiliarClas_Contabil_Cre.AsString,1,14);
  for i := 1 to 14 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Sequencia - 96 a 100
  vContador := vContador + 1;
  texto1 := texto1 + FormatFloat('00000',vContador);

  //Delimitador - 101 a 101
  texto1 := texto1 + '|';

  //Observações - 102 a 191
  texto2 := fDMIntegracao.mAuxiliarObs.AsString;
  for i := 1 to 90 do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Centro de Custo com mais de 3 digitos - 192 a 197
  texto2 := fDMIntegracao.mAuxiliarCod_CentroCusto2.AsString;
  for i := 1 to 6 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Reservado - 198 a 199
  texto1 := texto1 + '  ';

  //Delimitador - 200 a 200
  texto1 := texto1 + '|';

  //Identificador - 201 a 232
  texto2 := '';
  for i := 1 to 32 do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  Writeln(vArqTxt,Texto1);

  //06/08/2019
  //if trim(vHistorico) <> '' then
  vCont_Hist := 0;
  while (trim(vHistorico) <> '') and (vCont_Hist <= 3)  do
    prc_Gravar_Historico_H;
end;

procedure TfrmIntegracao.prc_Gravar_Historico_H;
var
  texto1, texto2 : String;
  i : Integer;
begin
  //Tipo Registro
  texto1 := 'H';

  //Histórico - 02 ao 51
  //texto2 := copy(fDMIntegracao.mAuxiliarDesc_Historico.AsString,1,50);
  texto2 := copy(vHistorico,1,50);
  for i := 1 to 50 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;
  //06/08/2019
  delete(vHistorico,1,50);

  //Reservado - 51 ao 95
  for i := 1 to 44 do
    texto1 := texto1 + ' ';

  //Sequencia - 96 ao 100
  vContador := vContador + 1;
  texto1 := texto1 + FormatFloat('00000',vContador);
  Writeln(vArqTxt,Texto1);

  vCont_Hist := vCont_Hist + 1;
end;

procedure TfrmIntegracao.prc_Gravar_mAuxiliar(Tipo_Lanc : String); //L=Lancamento  J=Juros
var
  vHist1, vHist2, vHist3 : String;
begin
  vHist1 := '';
  vHist2 := '';
  if Tipo_Lanc = 'J' then
    vHist2 := 'de juros';
  if fDMIntegracao.cdsTitulos_PagosTIPO_ES.AsString = 'E' then
    vHist1 := 'Recto.'
  else
    vHist1 := 'Pagto.';
  if fDMIntegracao.cdsTitulos_PagosTIPO_MOV.AsString = 'N' then
    vHist3 := 'Nota ' + fDMIntegracao.cdsTitulos_PagosNUMNOTA.AsString
  else
    vHist3 := 'Doc.' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString;
  fDMIntegracao.mAuxiliar.Insert;
  fDMIntegracao.mAuxiliarDtLancamento.AsDateTime := fDMIntegracao.cdsTitulos_PagosDTLANCAMENTO.AsDateTime;
  if Tipo_Lanc = 'J' then
  begin
    if fDMIntegracao.cdsTitulos_PagosTIPO_ES.AsString = 'E' then
    begin
      fDMIntegracao.mAuxiliarCod_Debito.AsInteger  := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      fDMIntegracao.mAuxiliarCod_Credito.AsInteger := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_REC.AsInteger;
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_REC.AsInteger <= 0 then
        prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não possui cód. contábil de juros recebidos "Cadastro de Filial"');
    end
    else
    begin
      fDMIntegracao.mAuxiliarCod_Debito.AsInteger  := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS.AsInteger;
      fDMIntegracao.mAuxiliarCod_Credito.AsInteger := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS.AsInteger <= 0 then
        prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não possui cód. contábil de juros pagos "Cadastro de Filial"');
    end;
    fDMIntegracao.mAuxiliarVlr_Lancamento.AsFloat := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_JUROSPAGOS.AsFloat));
  end
  else
  begin
    if fDMIntegracao.cdsTitulos_PagosTIPO_ES.AsString = 'E' then
    begin
      fDMIntegracao.mAuxiliarCod_Debito.AsInteger  := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      fDMIntegracao.mAuxiliarCod_Credito.AsInteger := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CLIENTE.AsInteger;
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger <= 0 then
        prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não possui cód. débito "Cadastro de Contas"');
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CLIENTE.AsInteger <= 0 then
        prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não possui cód. crédito "Cadastro de Clientes"');
    end
    else
    begin
      fDMIntegracao.mAuxiliarCod_Debito.AsInteger  :=  fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR.AsInteger;
      fDMIntegracao.mAuxiliarCod_Credito.AsInteger := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR.AsInteger <= 0 then
        prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não possui cód. crédito "Cadastro de Fornecedores"');
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger <= 0 then
        prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não possui cód. débito "Cadastro de Contas"');
    end;
    fDMIntegracao.mAuxiliarVlr_Lancamento.AsFloat := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_PAGAMENTO.AsFloat));
  end;
  //fDMIntegracao.mAuxiliarDesc_Historico.AsString := vHist1 + ' ' + vHist2 + ' ref. ' + vHist3 + ' ' + fDMIntegracao.cdsTitulos_PagosNUMNOTA.AsString + '/'
  fDMIntegracao.mAuxiliarDesc_Historico.AsString := vHist1 + ' ' + vHist2 + ' ref. ' + vHist3 + '/'
                                                  + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' de '
                                                  + fDMIntegracao.cdsTitulos_PagosNOME_PESSOA.AsString;
  fDMIntegracao.mAuxiliarCod_Historico.Clear;
  fDMIntegracao.mAuxiliarCod_CentroCusto.Clear;
  fDMIntegracao.mAuxiliarClas_Contabil_Deb.Clear;
  fDMIntegracao.mAuxiliarClas_Contabil_Cre.Clear;
  fDMIntegracao.mAuxiliarSequencia.Clear;
  fDMIntegracao.mAuxiliarObs.Clear;
  fDMIntegracao.mAuxiliarCod_CentroCusto2.Clear;
  vVlrTotal := StrToFloat(FormatFloat('0.00',vVlrTotal + fDMIntegracao.mAuxiliarVlr_Lancamento.AsFloat));

  fDMIntegracao.mAuxiliar.Post;
end;

procedure TfrmIntegracao.prc_gravar_mErro(Erro : String);
begin
  fDMIntegracao.mErros.Insert;
  fDMIntegracao.mErrosErro.AsString := Erro;
  fDMIntegracao.mErros.Post;
end;

procedure TfrmIntegracao.NxDatePicker2Exit(Sender: TObject);
begin
  NxDatePicker3.Date := NxDatePicker2.Date;
end;

function TfrmIntegracao.Monta_Numero(Campo: String;
  Tamanho: Integer): String;
var
  texto2: String;
  i: Integer;
begin
  texto2 := '';
  for i := 1 to Length(Campo) do
    if Campo[i] in ['0','1','2','3','4','5','6','7','8','9'] then
      Texto2 := Texto2 + Copy(Campo,i,1);
  for i := 1 to Tamanho - Length(texto2) do
    texto2 := '0' + texto2;
  Result := texto2;
end;

procedure TfrmIntegracao.btnOperacoesClick(Sender: TObject);
begin
  frmCadContabil_Ope := TfrmCadContabil_Ope.Create(self);
  frmCadContabil_Ope.ShowModal;
  FreeAndNil(frmCadContabil_Ope);
end;

procedure TfrmIntegracao.RxDBLookupCombo1Exit(Sender: TObject);
begin
  if RxDBLookupCombo1.Text <> '' then
  begin
    fDMIntegracao.cdsFilial_Contabil.Close;
    fDMIntegracao.sdsFilial_Contabil.ParamByName('ID').AsInteger := RxDBLookupCombo1.KeyValue;
    fDMIntegracao.cdsFilial_Contabil.Open;
    CurrencyEdit1.AsInteger := fDMIntegracao.cdsFilial_ContabilNUM_SEQ_LOTE_INTEGRACAO.AsInteger;
  end;
end;

procedure TfrmIntegracao.prc_Gravar_mAuxiliar_Novo(Tipo_Lanc: String);
begin
  fDMIntegracao.mAuxiliar.Insert;
  fDMIntegracao.mAuxiliarDtLancamento.AsDateTime := fDMIntegracao.cdsTitulos_PagosDTLANCAMENTO.AsDateTime;
  fDMIntegracao.mAuxiliarCod_Credito.AsInteger   := vCod_Credito;
  fDMIntegracao.mAuxiliarCod_Debito.AsInteger    := vCod_Debito;
  fDMIntegracao.mAuxiliarCod_Historico.AsInteger := fDMIntegracao.cdsContabil_Ope_LactoCOD_HISTORICO.AsInteger;
  fDMIntegracao.mAuxiliarDesc_Historico.AsString := vHistorico;
  fDMIntegracao.mAuxiliarObs.Clear;
  fDMIntegracao.mAuxiliarSequencia.Clear;
  fDMIntegracao.mAuxiliarClas_Contabil_Cre.Clear;
  fDMIntegracao.mAuxiliarClas_Contabil_Deb.Clear;
  fDMIntegracao.mAuxiliarCod_CentroCusto.Clear;
  fDMIntegracao.mAuxiliarCod_CentroCusto2.Clear;
  fDMIntegracao.mAuxiliarVlr_Lancamento.AsFloat := vVlr_Lacto;
  fDMIntegracao.mAuxiliar.Post;
  //if (fDMIntegracao.mAuxiliarCod_Credito.AsInteger <= 0) and (fDMIntegracao.mAuxiliarCod_Debito.AsInteger <= 0) then
   // prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não possui cód. contábil débito e crédito');
end;

procedure TfrmIntegracao.prc_Le_Contabil_Ope_Lacto(Tipo_ES : String);
const
  vContasAux : array[1..10] of String = ('Contas','Cliente','Fornecedor','Juros_Pagos','Juros_Rec','Contas de Orçamento','Desconto C.Receber',
                                         'Desconto C.Pagar','Multa C.Receber','Multa C.Pagar');
var
  vVlr_Conferencia_Deb : Real;
  vVlr_Conferencia_Cre : Real;
begin
  vVlr_Conferencia_Deb := 0;
  vVlr_Conferencia_Cre := 0;
  fDMIntegracao.cdsContabil_Ope_Lacto.Close;
  //if Tipo_ES = 'E' then
  //  fDMIntegracao.sdsContabil_Ope_Lacto.ParamByName('ID').AsInteger := fDMIntegracao.cdsTitulos_PagosID_CONTABIL_OPE_BAIXA_CRE.AsInteger
  //else
  fDMIntegracao.sdsContabil_Ope_Lacto.ParamByName('ID').AsInteger := fDMIntegracao.cdsTitulos_PagosID_CONTABIL_OPE_BAIXA.AsInteger;
  fDMIntegracao.cdsContabil_Ope_Lacto.Open;

  if fDMIntegracao.cdsContabil_Ope_Lacto.IsEmpty then
    prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' não gravado a operação de baixa de títulos no cadastro de Filial!');

  fDMIntegracao.cdsContabil_Ope_Lacto.First;
  while not fDMIntegracao.cdsContabil_Ope_Lacto.Eof do
  begin
    vCod_Debito  := 0;
    vCod_Credito := 0;
    case fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger of
      1 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      2 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CLIENTE.AsInteger;
      3 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR.AsInteger;
      4 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS.AsInteger;
      5 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_REC.AsInteger;
      6 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_ORC.AsInteger;
      7 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_DESC_CRE.AsInteger;
      8 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_DESC_CPA.AsInteger;
      9 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_MULTA_CRE.AsInteger;
     10 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_MULTA_CPA.AsInteger;
     11 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_TXBANCARIA_CRE.AsInteger;
     12 : vCod_Debito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_TXBANCARIA_CPA.AsInteger;
    end;
    if (fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger > 0) and (vCod_Debito <= 0) then
      prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' sem conta contabil (' + vContasAux[fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger] + ') no lançamento debito' );
    case fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger of
      1 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      2 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CLIENTE.AsInteger;
      3 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR.AsInteger;
      4 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS.AsInteger;
      5 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_REC.AsInteger;
      6 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_ORC.AsInteger;
      7 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_DESC_CRE.AsInteger;
      8 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_DESC_CPA.AsInteger;
      9 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_MULTA_CRE.AsInteger;
     10 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_MULTA_CPA.AsInteger;
     11 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_TXBANCARIA_CRE.AsInteger;
     12 : vCod_Credito := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_TXBANCARIA_CPA.AsInteger;
    end;
    if (fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger > 0) and (vCod_Credito <= 0) then
      prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' sem conta contabil (' + vContasAux[fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger] + ') no lançamento crédito' );

    vHistorico := fnc_Monta_Hist(False);
    vVlr_Lacto := fnc_Monta_Vlr(False);
    if (StrToFloat(FormatFloat('0.00',vVlr_Lacto)) > 0) then
    begin
      if vCod_Debito > 0 then
        vVlr_Conferencia_Deb := vVlr_Conferencia_Deb + vVlr_Lacto;
      if vCod_Credito > 0 then
        vVlr_Conferencia_Cre := vVlr_Conferencia_Cre + vVlr_Lacto;
      prc_Gravar_mAuxiliar_Novo(Tipo_ES);
    end;

    fDMIntegracao.cdsContabil_Ope_Lacto.Next;
  end;
  if StrToFloat(FormatFloat('0.00',vVlr_Conferencia_Cre)) <> StrToFloat(FormatFloat('0.00',vVlr_Conferencia_Deb)) then
    prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' com diferença de valores para débito e crédito');
end;

function TfrmIntegracao.fnc_Monta_Hist(Transferencia : Boolean) : String;
var
  vTexto : String;
begin
  if Transferencia then
  begin
    vTexto := fDMIntegracao.cdsContabil_Ope_LactoHISTORICO.AsString;
    if posex('<NUMNOTA>',vTexto) > 0 then
      vTexto := Replace2(vTexto,'<NUMNOTA>',fDMIntegracao.cdsTransferenciaID_TRANSFERENCIA.AsString);
    if (posex('<NUMCHEQUE>',vTexto) > 0) then
    begin
      if (fDMIntegracao.cdsTransferenciaNUMCHEQUE.AsInteger > 0) then
        vTexto := Replace2(vTexto,'<NUMCHEQUE>',fDMIntegracao.cdsTransferenciaNUMCHEQUE.AsString)
      else
        vTexto := Replace2(vTexto,'<NUMCHEQUE>','');
    end;
    if (posex('<NUMTITULO>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<NUMTITULO>',fDMIntegracao.cdsTransferenciaID_TRANSFERENCIA.AsString);
    if (posex('<DTEMISSAO>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<DTEMISSAO>',fDMIntegracao.cdsTransferenciaDTMOVIMENTO.AsString);
    if (posex('<DESCRICAO_OBS>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<DESCRICAO_OBS>',fDMIntegracao.cdsTransferenciaHISTORICO_COMPL.AsString);
    if (posex('<HIST_DUPLICATA>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<HIST_DUPLICATA>',fDMIntegracao.cdsTransferenciaHISTORICO_COMPL.AsString);
  end
  else
  begin
    vTexto := fDMIntegracao.cdsContabil_Ope_LactoHISTORICO.AsString;
    if posex('<NUMNOTA>',vTexto) > 0 then
      vTexto := Replace2(vTexto,'<NUMNOTA>',fDMIntegracao.cdsTitulos_PagosNUMNOTA.AsString);
    if posex('<PARCELA>',vTexto) > 0 then
      vTexto := Replace2(vTexto,'<PARCELA>',fDMIntegracao.cdsTitulos_PagosPARCELA.AsString);
    if posex('<RAZAO_EMPRESA>',vTexto) > 0 then
      vTexto := Replace2(vTexto,'<RAZAO_EMPRESA>',fDMIntegracao.cdsTitulos_PagosNOME_PESSOA.AsString);
    if (posex('<NUMCHEQUE>',vTexto) > 0) then
    begin
      if (fDMIntegracao.cdsTitulos_PagosNUMCHEQUE.AsInteger > 0) then
        vTexto := Replace2(vTexto,'<NUMCHEQUE>',fDMIntegracao.cdsTitulos_PagosNUMCHEQUE.AsString)
      else
        vTexto := Replace2(vTexto,'<NUMCHEQUE>','');
    end;
    if (posex('<SERIENOTA>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<SERIENOTA>',fDMIntegracao.cdsTitulos_PagosSERIE.AsString);
    if (posex('<NUMTITULO>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<NUMTITULO>',fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString);
    if (posex('<DTEMISSAO>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<DTEMISSAO>',fDMIntegracao.cdsTitulos_PagosDTEMISSAO.AsString);
    if (posex('<DTVENCIMENTO>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<DTVENCIMENTO>',fDMIntegracao.cdsTitulos_PagosDTVENCIMENTO.AsString);
    if (posex('<DESCRICAO_OBS>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<DESCRICAO_OBS>',fDMIntegracao.cdsTitulos_PagosDESCRICAO.AsString);
    if (posex('<MES_ANO_COMP>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<MES_ANO_COMP>',fDMIntegracao.cdsTitulos_PagosMES_REF.AsString + '/' + fDMIntegracao.cdsTitulos_PagosANO_REF.AsString);
    //06/08/2019
    if (posex('<HIST_DUPLICATA>',vTexto) > 0) then
      vTexto := Replace2(vTexto,'<HIST_DUPLICATA>',fDMIntegracao.cdsTitulos_PagosHIST_DUPLICATA.AsString);
  end;
  Result := vTexto;
end;

function TfrmIntegracao.fnc_Monta_Vlr(Transferencia : Boolean) : Real;
var
  vTexto : String;
  vVlr_Aux : Real;
  vFlag : Boolean;
  i : Integer;
  vSD : String;
  vVlr_Aux2 : Real;
begin
  vTexto     := trim(fDMIntegracao.cdsContabil_Ope_LactoELEMENTO_VALOR.AsString);
  vFlag      := False;
  vVlr_Aux   := 0;
  vVlr_Aux2 := 0;
  vSD        := '+';
  if Transferencia then
  begin
    while not vFlag  do
    begin
      if copy(vTexto,1,1) = '+' then
        vSD := '+'
      else
      if copy(vTexto,1,1) = '-' then
        vSD := '-';
      if copy(vTexto,1,1) <> '<' then
        delete(vTexto,1,1);
      vTexto := trim(vTexto);
      if posex('<VLR_LANCAMENTO>',vTexto) = 1 then
        vVlr_Aux := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTransferenciaVLR_MOVIMENTO.AsFloat));
      if vSD = '-' then
        vVlr_Aux := vVlr_Aux * -1;
      vVlr_Aux2 := vVlr_Aux2 + vVlr_Aux;
      delete(vTexto,1,pos('>',vTexto));
      vTexto := trim(vTexto);
      if (trim(vTexto) = '') or (pos('<',vTexto) <= 0) then
        vFlag := True;
    end;
  end
  else
  begin
    while not vFlag  do
    begin
      //if posex('+',vTexto) > 0 then
      if copy(vTexto,1,1) = '+' then
        vSD := '+'
      else
      //if posex('-',vTexto) > 0 then
      if copy(vTexto,1,1) = '-' then
        vSD := '-';
      if copy(vTexto,1,1) <> '<' then
        delete(vTexto,1,1);
      vTexto := trim(vTexto);
      if posex('<VLR_LANCAMENTO>',vTexto) = 1 then
        vVlr_Aux := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_PARCELA.AsFloat))
      else
      if posex('<VLR_PAGAMENTO>',vTexto) = 1 then
        vVlr_Aux := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_PAGAMENTO.AsFloat))
      else
      if posex('<VLR_JUROS>',vTexto) = 1 then
        vVlr_Aux := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_JUROSPAGOS.AsFloat))
      else
      if posex('<VLR_MULTA>',vTexto) = 1 then
        vVlr_Aux := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_MULTA.AsFloat))
      else
      if posex('<VLR_DESCONTO>',vTexto) = 1 then
        vVlr_Aux := StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsTitulos_PagosVLR_DESCONTOS.AsFloat));
      if vSD = '-' then
        vVlr_Aux := vVlr_Aux * -1;
      vVlr_Aux2 := vVlr_Aux2 + vVlr_Aux;
      delete(vTexto,1,pos('>',vTexto));
      vTexto := trim(vTexto);
      if (trim(vTexto) = '') or (pos('<',vTexto) <= 0) then
        vFlag := True;
    end;
  end;
  Result := vVlr_Aux2;
end;

procedure TfrmIntegracao.btnPlanoContasClick(Sender: TObject);
begin
  frmConvPlanoContas := TfrmConvPlanoContas.Create(self);
  frmConvPlanoContas.ShowModal;
  FreeAndNil(frmConvPlanoContas);
end;

procedure TfrmIntegracao.btnGerarNotaEntClick(Sender: TObject);
begin
  Label22.Visible := False;
  if trim(RxDBLookupCombo2.Text) = '' then
  begin
    MessageDlg('*** Filial não informada!', mtInformation, [mbOk], 0);
    exit;
  end;
  if (dateInicial.Date <= 10) or (dateInicial.Date > dateFinal.Date) then
  begin
    MessageDlg('*** Data inicial inválida!', mtInformation, [mbOk], 0);
    exit;
  end;
  if (dateFinal.Date <= 10) then
  begin
    MessageDlg('*** Data Final inválida!', mtInformation, [mbOk], 0);
    exit;
  end;
  fDMIntegracao.cdsNota.Close;
  fDMIntegracao.sdsNota.ParamByName('FILIAL').AsInteger := RxDBLookupCombo2.KeyValue;
  fDMIntegracao.sdsNota.ParamByName('DATA1').AsDate     := dateInicial.Date;
  fDMIntegracao.sdsNota.ParamByName('DATA2').AsDate     := dateFinal.Date;
  fDMIntegracao.cdsNota.Open;
  prc_Le_cdsNota;
end;

procedure TfrmIntegracao.prc_Le_cdsNota;
begin
  vContador    := 0;
  vVlrContabil := 0;
  vRegistro    := '';
  vArquivo  := edtDiretorioArquivo.Text;
  if Copy(vArquivo,(Length(vArquivo)),1) <> '\' then
    vArquivo := vArquivo + '\';
  AssignFile(Txt,vArquivo + 'NOTAENT.TXT');
  ReWrite(Txt);
  prc_Header;
  RzProgressBar3.TotalParts    := 0;
  RzProgressBar3.PartsComplete := 0;
  RzProgressBar3.TotalParts    := fDMIntegracao.cdsNota.RecordCount;

  fDMIntegracao.cdsNota.First;
  while not fDMIntegracao.cdsNota.Eof do
  begin
  
    RzProgressBar3.PartsComplete := RzProgressBar3.PartsComplete + 1;
    prc_Emitente_Destinatario;
    prc_Nota_Fiscal;
    fDMIntegracao.cdsItens.Close;
    fDMIntegracao.sdsItens.ParamByName('ID').AsInteger     := fDMIntegracao.cdsNotaID.AsInteger;
    fDMIntegracao.sdsItens.ParamByName('TIPO_NS').AsString := fDMIntegracao.cdsNotaTIPO_NS.AsString;
    fDMIntegracao.cdsItens.Open;
    prc_Exclui_mCFOP;

    fDMIntegracao.cdsItens.First;
    while not fDMIntegracao.cdsItens.Eof do
    begin
//      prc_Grava_mCFOP;
//      prc_Grava_mProd;
        prc_Itens_Nota_Fiscal;
      fDMIntegracao.cdsItens.Next;
    end;
    prc_Montar_DadosComplementares;
    fDMIntegracao.mCFOP.First;
    while not fDMIntegracao.mCFOP.Eof do
    begin
//      prc_NotasFiscais;

      fDMIntegracao.mCFOP.Next;
    end;
    fDMIntegracao.cdsNota.Next;
    Label22.Font.Color := clBlue;
    Label22.Caption    := 'Arquivo gerado com sucesso';
    Label22.Visible    := True;
  end;

end;

procedure TfrmIntegracao.prc_Header;
var
  Texto1  : String;
  ano,mes,dia: Word;
begin
  Texto1 := '0';                                                                //Tipo Registro   Tamanho 1 - 1 a 1
  DecodeDate(Date,ano,mes,dia);
  Texto1 := Texto1 + Monta_Numero(IntToStr(Dia),2);
  Texto1 := Texto1 + Monta_Numero(IntToStr(Mes),2);
  Texto1 := Texto1 + Monta_Numero(IntToStr(Ano),4);                             //Data de Geração   Tamanho 8 - 2 a 9
  Texto1 := Texto1 + fDMIntegracao.cdsFilialCNPJ_CPF.AsString;                  //CNPJ da empresa   Tamanho 18 - 10 a 27
  Texto1 := Texto1 + IntToStr(ComboBox2.ItemIndex);                             //Opção Bases    Tamanho 1 - 28 a 28
  Texto1 := Texto1 + Formatar_Campo('',3);                                      //Origem     Tamanho 3 - 29 a 31
  Texto1 := Texto1 + '1';                                                       //Opção Retenção Tamanho 1 - 28 a 28
  Texto1 := Texto1 + Formatar_Campo('',443);                                    //Brancos Tamanho 443 - 33 a 474
  Texto1 := Texto1 + Formatar_Campo('',20);                                     //Uso  Tamanho 20 - 475 a 494
  vContador := vContador + 1;
  Texto1    := Texto1 + Monta_Numero(IntToStr(vContador),6);                    //Sequência   Tamanho 6 - 495 a 500
  Writeln(txt,texto1);
end;

procedure TfrmIntegracao.prc_Emitente_Destinatario;
var
  texto1, texto2 : String;
  vExiste : Boolean;
begin
  fDMIntegracao.prc_Localiza_Fornecedor(fDMIntegracao.cdsNotaID_CLIENTE.AsInteger);
  if fDMIntegracao.qFornecedor.IsEmpty then
  begin
    ShowMessage('Fornecedor inexistente na nf nº: ' + fDMIntegracao.cdsNotaNUMNOTA.AsString);
    Exit;
  end;
  Texto1 := '4';                                                                            //Tipo Registro   Tamanho 1 - 1 a 1
  texto2 := fDMIntegracao.qFornecedorCNPJ_CPF.AsString;                                     //CNPJ do Cliente   Tamanho 18 - 2 a 19
  texto1 := texto1 + Formatar_Campo(texto2,18);
  texto1 := texto1 + Formatar_Campo(copy(fDMIntegracao.qFornecedorNOME.AsString,1,40),40); //Razão Social   Tamanho 40 - 20 a 59
  texto1 := texto1 + Formatar_Campo(copy(fDMIntegracao.qFornecedorFANTASIA.AsString,1,20),20);      //Fantasia   Tamanho 20 - 60 a 79
  texto1 := texto1 + Formatar_Campo(fDMIntegracao.qFornecedorUF.AsString,2);                        //Estado   Tamanho 2 - 80 a 81
  texto1 := texto1 + Formatar_Campo(fDMIntegracao.qFornecedorINSCR_EST.AsString,20);                //Inscrição   Tamanho 20 - 82 a 101
  texto1 := texto1 + Formatar_Campo(copy(fDMIntegracao.qFornecedorENDERECO.AsString,1,40),40);      //Endereço   Tamanho 40 - 102 a 141
  texto1 := texto1 + Formatar_Campo(copy(fDMIntegracao.qFornecedorBAIRRO.AsString,1,20),20);        //Bairro   Tamanho 20 - 142 a 161
  texto1 := texto1 + Formatar_Campo(copy(fDMIntegracao.qFornecedorCIDADE.AsString,1,20),20);        //Cidade   Tamanho 20 - 162 a 181
  texto1 := texto1 + Monta_Numero(fDMIntegracao.qFornecedorCEP.AsString,8);                         //CEP   Tamanho 8 - 182 a 189
  texto1 := texto1 + Monta_Numero('0',4);                                                           //Código Municipio SIAFI   Tamanho 4 - 190 a 193
  texto1 := texto1 + Monta_Numero(fDMIntegracao.qFornecedorDDDFONE1.AsString,3);                         //DDD    Tamanho 3 - 194 a 196
  texto1 := texto1 + Monta_Numero(copy(trim(fDMIntegracao.qFornecedorTELEFONE1.AsString),1,10),10);      //Fone   Tamanho 10 - 197 a 206
  texto1 := texto1 + Monta_Numero('0',6);                                                    //Conta Cliente   Tamanho 6 - 207 a 212
  texto1 := texto1 + Monta_Numero('0',3);                                                    //Histórico Cliente   Tamanho 3 - 213 a 215
  texto1 := texto1 + Monta_Numero('',6);                                                    //Conta Fornecedor   Tamanho 6 - 216 a 221
  texto1 := texto1 + Monta_Numero('',3);                                                    //Histórico Cliente   Tamanho 3 - 222 a 224
  texto1 := texto1 + Formatar_Campo('N',1);                                                 //Produto rural    Tamanho 1 - 225 a 225
  texto1 := texto1 + Formatar_Campo(SQLLocate('PAIS','ID','NOME',fDMIntegracao.qFornecedorID_PAIS.AsString) ,18);   //Identificação Exterior    Tamanho 18 - 226 a 243
  texto1 := texto1 + Monta_Numero(copy(fDMIntegracao.qFornecedorNUM_END.AsString,1,5),5);        //Número do endereço    Tamanho 5 - 244 a 248
  texto1 := texto1 + Formatar_Campo(copy(fDMIntegracao.qFornecedorCOMPLEMENTO_END.AsString,1,20),20);   //Complemento    Tamanho 20 - 249 a 268
  texto1 := texto1 + Formatar_Campo(copy(fDMIntegracao.qFornecedorINSC_SUFRAMA.AsString,1,9),9);         //Suframa  Tamanho 9 - 269 a 277
  texto1 := texto1 + Monta_Numero(SQLLocate('PAIS','ID','CODPAIS',fDMIntegracao.qFornecedorID_PAIS.AsString),5);                                                //Código do Pais  Tamanho 5 - 278 a 282
  texto1 := texto1 + Monta_Numero('',1);                                                    //Natureza juridica   Tamanho 1 - 283 a 283
  texto1 := texto1 + Monta_Numero(SQLLocate('CIDADE','ID','CODMUNICIPIO',fDMIntegracao.qFornecedorID_CIDADE.AsString),7);            //Municipio IBGE   Tamanho 7 - 284 a 290
  texto1 := texto1 + Formatar_Campo('',199);                                                 //Brancos   Tamanho 199 - 291 a 489
  texto1 := texto1 + Formatar_Campo('',5);                                                   //Uso da EBS   Tamanho 5 - 490 a 494
  vContador := vContador + 1;                                                                //Número do Registro   Tamanho 6 - 495 a 500
  Texto1    := Texto1 + Monta_Numero(IntToStr(vContador),6);
  Writeln(txt,texto1);
end;

procedure TfrmIntegracao.prc_Exclui_mCFOP;
begin
  fDMIntegracao.mCFOP.First;
  while not fDMIntegracao.mCFOP.Eof do
  begin
    fDMIntegracao.mProd.First;
    while not fDMIntegracao.mProd.Eof do
      fDMIntegracao.mProd.Delete;
    fDMIntegracao.mCFOP.Delete;
  end;
end;

procedure TfrmIntegracao.prc_Montar_CliFor;
var
  texto1, texto2 : String;
  i : Integer;
begin
//  texto1 := Formatar_Campo(fDMFolha.mClienteCNPJ_CPF.AsString,0);                     //CNPJ/CPF   Tamanho 18 - 1 a 18
//  for i := 1 to 18 - Length(texto1) do
//    texto1 := ' ' + texto1;
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteRazao.AsString,40);               //Razão   Tamanho 40 - 19 a 58
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteFantasia.AsString,20);            //Fantasia   Tamanho 20 - 59 a 78
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteUF.AsString,2);                   //Estado   Tamanho 2 - 79 a 80
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteInscEstadual.AsString,20);        //Inscrição Estadual   Tamanho 20 - 81 a 100
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteEndereco.AsString,40);            //Endereço   Tamanho 40 - 101 a 140
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteBairro.AsString,20);              //Bairro   Tamanho 20 - 141 a 160
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteCidade.AsString,20);              //Cidade   Tamanho 20 - 161 a 180
//  texto1 := Texto1 + Monta_Numero(fDMFolha.mClienteCep.AsString,8);                    //Cep   Tamanho 8 - 181 a 188
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteCodMunicipio.AsString),4);     //Municipio   Tamanho 4 - 189 a 192
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteDDD.AsString),3);              //DDD   Tamanho 3 - 193 a 195
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteFone.AsString),10);            //Fone   Tamanho 10 - 196 a 205
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteContaCliente.AsString),6);     //Conta Cliente   Tamanho 6 - 206 a 211
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteHistoricoCliente.AsString),3); //Historico Cliente   Tamanho 3 - 212 a 214
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteContaFornecedor.AsString),6);  //Conta Fornecedor   Tamanho 6 - 215 a 220
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteHistoricoFornecedor.AsString),3); //Historico Fornecedor   Tamanho 3 - 221 a 223
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteProdutor.AsString,1);             //Produtor   Tamanho 1 - 224 a 224
//  if fDMFolha.mClienteUF.AsString = 'EX' then
//    texto1 := Texto1 + Formatar_Campo(fDMFolha.mClientePais.AsString,18)
//  else
//    texto1 := Texto1 + Formatar_Campo('',18);                                          //Identificação Exterior   Tamanho 1 - 225 a 242
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteNumero_End.AsString),5);       //Número do endereço   Tamanho 5 - 243 a 247
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteComplemento.AsString,20);         //Complemento   Tamanho 20 - 248 a 267
//  texto1 := Texto1 + Formatar_Campo(fDMFolha.mClienteSuframa.AsString,9);              //Suframa   Tamanho 9 - 268 a 276
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteCodPais.AsString),5);          //Código do Pais   Tamanho 5 - 277 a 281
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteNaturezaJuridica.AsString),1); //natureza Juridica   Tamanho 1 - 282 a 282
//  texto1 := Texto1 + Monta_Numero(trim(fDMFolha.mClienteCodMunicipioIBGE.AsString),7); //Código do Município IBGE   Tamanho 7 - 283 a 289
//  texto1 := Texto1 + Formatar_Campo('',5);                                             //Uso EBS   Tamanho 5 - 290 a 294
//  vContador := vContador + 1;
//  Texto1    := Texto1 + Monta_Numero(IntToStr(vContador),6);                           //Contador do registro - 295
//  Writeln(txt,texto1);
end;

procedure TfrmIntegracao.prc_Montar_Trailler;
var
  Texto1 : String;
begin
  Texto1 := '3';                                                                 //Tipo Registro   Tamanho 1 - 1 a 1
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',vVlrContabil),12);          //Valor contábil   Tamanho 12 - 2 a 13
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //Base Pis   Tamanho 12 - 14 a 25
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //Base Cofins  Tamanho 12 - 26 a 37
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //Base CSLL  Tamanho 12 - 38 a 49
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //Base IRPJ  Tamanho 12 - 50 a 61
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Base ICMS A  Tamanho 12 - 62 a 73
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Valor ICMS A  Tamanho 12 - 74 a 85
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Base ICMS B  Tamanho 12 - 86 a 97
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Valor ICMS B  Tamanho 12 - 98 a 109
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Base ICMS C  Tamanho 12 - 110 a 121
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Valor ICMS C  Tamanho 12 - 122 a 133
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Base ICMS D  Tamanho 12 - 134 a 145
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Valor ICMS D  Tamanho 12 - 146 a 157
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Isentas ICMS Tamanho 12 - 158 a 169
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Outras ICMS  Tamanho 12 - 170 a 181
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Base IPI  Tamanho 12 - 182 a 193
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Valor IPI  Tamanho 12 - 194 a 205
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Isentas IPI  Tamanho 12 - 206 a 217
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Outras IPI  Tamanho 12 - 218 a 229
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Mercadorias ST  Tamanho 12 - 230 a 241
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Base ST  Tamanho 12 - 242 a 253
  Texto1 := texto1 + Monta_Numero('0',12);                                       //ICMS ST  Tamanho 12 - 254 a 265
  Texto1 := texto1 + Monta_Numero('0',12);                                       //Diferidas  Tamanho 12 - 266 a 277
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //Base ISS  Tamanho 12 - 278 a 289
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //Valor ISS  Tamanho 12 - 290 a 301
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //Isentas ISS  Tamanho 12 - 302 a 313
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                     //IRRF ISS  Tamanho 12 - 314 a 325
  Texto1 := texto1 + Formatar_Campo('',169);                                     //Brancos  Tamanho 169 - 326 a 494
  vContador := vContador + 1;
  Texto1    := Texto1 + Monta_Numero(IntToStr(vContador),6);                     //Sequência   Tamanho 6 - 495 a 500
  Writeln(txt,texto1);
end;

procedure TfrmIntegracao.prc_Nota_Fiscal;
var
  texto1, texto2 : String;
begin
  Texto1 := '1';                                                                         //Tipo Registro   Tamanho 1 - 1 a 1
  Texto1 := Texto1 + Monta_Numero(DateToStr(fDMIntegracao.cdsNotaDTSAIDAENTRADA.AsDateTime),8);  //Data Lançamento   Tamanho 8 - 2 a 9
  Texto1 := Texto1 + Monta_Numero(fDMIntegracao.cdsNotaNUMNOTA.AsString,6);              //Número Inicial   Tamanho 6 - 10 a 15
  Texto1 := Texto1 + Monta_Numero(fDMIntegracao.cdsNotaDTSAIDAENTRADA.AsString,8);       //Data de Emissão   Tamanho 8 - 16 a 23
//  Texto1 := Texto1 + Formatar_Campo('',3);                                             //Brancos   Tamanho 3 - 30 a 32
  Texto1 := Texto1 + Monta_Numero('55',2);                                               //Modelo   Tamanho 2 - 24 a 25
  Texto1 := Texto1 + Formatar_Campo(fDMIntegracao.cdsNotaSERIE.AsString,3);              //Série   Tamanho 3 - 26 a 28
  Texto1 := Texto1 + Formatar_Campo('',3);                                               //Sub-Série   Tamanho 3 - 29 a 31
  //Alterado 17/10/2019
  //Texto1 := Texto1 + Monta_Numero(Edit3.Text,4);                                       //Natureza Operação (CFOP)   Tamanho 4 - 32 a 35
  Texto1 := Texto1 + Monta_Numero(fDMIntegracao.cdsNotaCODCFOP.AsString,4);              //Natureza Operação (CFOP)   Tamanho 4 - 32 a 35
  Texto1 := Texto1 + Monta_Numero('',2);                                                 //Variação Natureza Operação (CFOP)   Tamanho 2 - 36 a 37
  Texto1 := Texto1 + Monta_Numero('',2);                                                 //Classificação 1 para integração contabil   Tamanho 2 - 38 a 39
  Texto1 := Texto1 + Monta_Numero('',2);                                                 //Classificação 1 para integração contabil   Tamanho 2 - 40 a 41
  texto2 := fDMIntegracao.qFornecedorCNPJ_CPF.AsString;                                  //CNPJ/CPF do destinatário   Tamanho 18 - 42 a 59
  texto1 := texto1 + Formatar_Campo(texto2,18);
  if fDMIntegracao.cdsNotaVLR_NOTA.AsFloat > 0 then                                    //Valor Contábil   Tamanho 12 - 69 a 80
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsNotaVLR_NOTA.AsFloat),12)
  else
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base PIS   Tamanho 12 - 81 a 92
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base Cofins   Tamanho 12 - 93 a 104
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base CSLL   Tamanho 12 - 105 a 116
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base IRPJ   Tamanho 12 - 117 a 128
//  Texto1 := Texto1 + Formatar_Campo('',8);                                               //Brancos  Tamanho 8 - 129 a 136
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base ICMS A  Tamanho 12 - 137 a 148
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Aliquota ICMS A  Tamanho 4 - 149 a 152
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor ICMS A  Tamanho 12 - 153 a 164
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base ICMS B  Tamanho 12 - 165 a 176
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Aliquota ICMS B  Tamanho 4 - 177 a 180
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor ICMS B  Tamanho 12 - 181 a 192
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base ICMS C  Tamanho 12 - 193 a 204
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Aliquota ICMS C  Tamanho 4 - 205 a 208
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor ICMS C  Tamanho 12 - 209 a 220
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base ICMS D  Tamanho 12 - 221 a 232
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Aliquota ICMS D  Tamanho 4 - 233 a 236
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor ICMS D  Tamanho 12 - 237 a 248
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor de isentas de ICMS   Tamanho 12 - 249 a 260
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor de outras de ICMS   Tamanho 12 - 261 a 272
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base IPI   Tamanho 12 - 273 a 284
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor IPI   Tamanho 12 - 285 a 296
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor de isentas de IPI   Tamanho 12 - 297 a 308
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor de outras de IPI   Tamanho 12 - 309 a 320
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor de mercadorias com substituição tributária    Tamanho 12 - 321 a 332
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base da substituição tributária    Tamanho 12 - 333 a 344
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //ICMS da substituição tributária    Tamanho 12 - 345 a 356
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor de mercadorias Diferidas    Tamanho 12 - 357 a 368
  Texto1 := Texto1 + Formatar_Campo('',50);                                              //Observações   Tamanho 50 - 421 a 470
  Texto1 := Texto1 + Formatar_Campo('NFSE',5);                                           //Espécie  Tamanho 5 - 471 a 475
  Texto1 := Texto1 + Formatar_Campo('N',1);                                              //Venda a Vista  Tamanho 1 - 476 a 476
  Texto1 := Texto1 + Monta_Numero('',4);                                                 //Natureza Operação ST (CFOP) Tamanho 4 - 477 a 480
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),8);                              //Base Pis/Cofins ST   Tamanho 8 - 481 a 488
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base ISS   Tamanho 12 - 369 a 380
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Aliquota ISS   Tamanho 4 - 381 a 384
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor ISS   Tamanho 12 - 385 a 396
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor Isentas ISS   Tamanho 12 - 397 a 408
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor IRRF Retido  Tamanho 12 - 409 a 420
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Pis Retido  Tamanho 12 - 490 a 501
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Cofins Retido  Tamanho 12 - 502 a 513
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //CSLL Retido  Tamanho 12 - 514 a 525
  Texto1 := Texto1 + Monta_Numero('',4);                                                 //Operação contábil  Tamanho 4 - 534 a 537
  Texto1 := Texto1 + Monta_Numero('',8);                                                 //Data de recebimento  Tamanho 8 - 526 a 533
  Texto1 := Texto1 + Monta_Numero('0',6);                                                //CliFor  Tamanho 6 - 566 a 571
  Texto1 := Texto1 + Formatar_Campo('',18);                                              //Identificação Exterior   Tamanho 18 - 572 a 589
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor INSS retido  Tamanho 12 - 538 a 549
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor FUNRURAL retido  Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Formatar_Campo('',4);                                               //Código do serviço  Tamanho 4 - 562 a 565
  Texto1 := Texto1 + Formatar_Campo('N',4);                                              //ISS Retido  Tamanho 4 - 534 a 537
  Texto1 := Texto1 + Formatar_Campo('N',4);                                              //ISS Devido  Tamanho 4 - 534 a 537
  Texto1 := Texto1 + Formatar_Campo('',2);                                               //UF Prestacao Tamanho 2 - 534 a 537
  Texto1 := Texto1 + Monta_Numero('0',7);                                                //Municipio Prestação Tamanho 7 - 534 a 537
  Texto1 := Texto1 + Formatar_Campo('0',1);                                              //Tipo emissão Tamanho 1 - 534 a 537
  Texto1 := Texto1 + Monta_Numero('0',1);                                                //Modalidade do frete  Tamanho 1 - 489 a 489
  Texto1 := Texto1 + Formatar_Campo('',5);                                               //Branco   Tamanho 5 - 590 a 594
  Texto1 := Texto1 + Formatar_Campo('',5);                                               //Uso da EBS   Tamanho 5 - 590 a 594
  vContador := vContador + 1;
  Texto1 := Texto1 + Monta_Numero(IntToStr(vContador),6);                                //Sequencia   Tamanho 6 - 595 a 600
  Texto1 := Texto1 + Monta_Numero('0',9);                                                //Número da Nota2  Tamanho 9 - 595 a 600
  Texto1 := Texto1 + Formatar_Campo('',50);                                              //Observações 2  Tamanho 50 - 595 a 600
  Texto1 := Texto1 + Formatar_Campo('',50);                                              //Observações 2  Tamanho 50 - 595 a 600
  Texto1 := Texto1 + Monta_Numero('0',6);                                                //Centro de Custo  Tamanho 6 - 595 a 600
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base de Pis/Cofins/ICMS ST  Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Valor FUNRURAL retido  Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Monta_Numero('0',8);                                                //Data Emissao RPS  Tamanho 8 - 595 a 600
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //ICMS relativo ao FCP  Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //ICMS UF Destino  Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //ICMS UF Origem  Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base ICMS E Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Aliquota ICMS E  Tamanho 4 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Valor ICMS E Tamanho 4 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                             //Base ICMS F Tamanho 12 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Aliquota ICMS F  Tamanho 4 - 550 a 561
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),4);                              //Valor ICMS F Tamanho 4 - 550 a 561
  Writeln(txt,texto1);
end;

procedure TfrmIntegracao.prc_Itens_Nota_Fiscal;
var
  texto1, texto2 : String;
  vCSTICMS : String;
begin
  Texto1 := '2';                                                                                       //Tipo Registro   Tamanho 1 - 1 a 1
  Texto1 := Texto1 + Monta_Numero(fDMIntegracao.cdsItensID_PRODUTO.AsString,10);                       //Código Inicial   Tamanho 10 - 2 a 11
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.000',fDMIntegracao.cdsItensQTD.AsFloat),9);            //Quantidade   Tamanho 9 - 12 a 20
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_UNITARIO.AsFloat),12);  //Valor Unitário   Tamanho 12 - 21 a 32
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.000',0),13);                                           //Quantidade2   Tamanho 13 - 33 a 45
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_DESCONTO.AsFloat),12);  //Valor Desconto   Tamanho 12 - 46 a 57
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensBASE_ICMS.AsFloat),12);     //Base ICMS    Tamanho 12 - 58 a 69
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensPERC_ICMS.AsFloat),5);      //Alíquota ICMS    Tamanho 5 - 70 a 74
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_IPI.AsFloat),12);       //Valor IPI    Tamanho 12 - 75 a 86
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensBASE_ICMSSUBST.AsFloat),12);//Base ICMS ST    Tamanho 12 - 87 a 98
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensPERC_IPI.AsFloat),5);       //Aliquota IPI    Tamanho 5 - 99 a 103
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensPERC_BASE_ICMS_RED.AsFloat),5); //Aliquota Redução ICMS    Tamanho 5 - 104 a 108
  vCSTICMS := SQLLocate('TAB_CSTICMS','ID','COD_CST',fDMIntegracao.cdsItensID_CSTICMS.asString);
  if Length(vCSTICMS) <= 2 then
    texto2 := fDMIntegracao.cdsItensORIGEM_PROD.AsString + vCSTICMS;
  Texto1 := Texto1 + Monta_Numero(texto2,3);       //CST ICMS    Tamanho 3 - 109 a 111
  Texto1 := Texto1 + Formatar_Campo('',15);                                                            //Identificação   Tamanho 15 - 112 a 126
  Texto1 := Texto1 + Monta_Numero(SQLLocate('TAB_CSTIPI','ID','COD_IPI',fDMIntegracao.cdsItensID_CSTICMS.asString),3); //Situação tributária do IPI    Tamanho 3 - 127 a 129
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensBASE_IPI.AsFloat),12);      //Base IPI ST    Tamanho 12 - 130 a 141
  Texto1 := Texto1 + Monta_Numero(SQLLocate('TAB_CSTIPI','ID','CODIGO',fDMIntegracao.cdsItensID_PIS.asString),2);
   //Situação tributária do PIS    Tamanho 2 - 142 a 143
  if StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_PIS.AsFloat)) > 0 then
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_TOTAL.AsFloat),12) //Base PIS     Tamanho 12 - 144 a 155
  else
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                       //Base PIS     Tamanho 12 - 144 a 155
  if StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_PIS.AsFloat)) > 0 then
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',fDMIntegracao.cdsItensPERC_PIS.AsFloat),7)     //Aliquota PIS    Tamanho 7 - 156 a 162
  else
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),7);                                   //Aliquota PIS    Tamanho 7 - 156 a 162
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.000',0),13);                                           //Quantidade Base PIS    Tamanho 13 - 163 a 175
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),14);                                           //Aliquota PIS (R$)    Tamanho 14 - 176 a 189
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_PIS.AsFloat),12);                                           //Valor PIS    Tamanho 12 - 190 a 201
  Texto1 := Texto1 + Monta_Numero(SQLLocate('TAB_CSTCOFINS','ID','CODIGO',fDMIntegracao.cdsItensID_COFINS.asString),2); //Situação tributária do Cofins    Tamanho 2 - 202 a 203
  if StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_COFINS.AsFloat)) > 0 then
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_TOTAL.AsFloat),12) //Base Cofins     Tamanho 12 - 204 a 215
  else
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                      //Base Cofins     Tamanho 12 - 204 a 215
  if StrToFloat(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_COFINS.AsFloat)) > 0 then
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',fDMIntegracao.cdsItensPERC_COFINS.AsFloat),7) //Aliquota Cofins    Tamanho 7 - 216 a 222
  else
    Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),7);                                        //Aliquota Cofins    Tamanho 7 - 216 a 222
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.000',0),13);                                          //Quantidade Base Cofins    Tamanho 13 - 223 a 235
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),14);                                         //Aliquota Cofins (R$)    Tamanho 14 - 236 a 249
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_COFINS.AsFloat),12);    //Valor Cofins    Tamanho 12 - 250 a 261
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_ICMSSUBST.AsFloat),12); //Valor ICMS ST    Tamanho 12 - 262 a 273
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensPERC_ICMSSUBST_PROPRIO.AsFloat),5);                                            //Aliquota ICMS ST    Tamanho 5 - 274 a 278
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_ICMS.AsFloat),12);      //Valor ICMS    Tamanho 12 - 279 a 290
  Texto1 := Texto1 + Formatar_Campo(SQLLocate('TAB_CFOP','ID','CODCFOP',fDMIntegracao.cdsItensID_CFOP.AsString),4);//CFOP   Tamanho 15 - 291 a 294
  Texto1 := Texto1 + Formatar_Campo(fDMIntegracao.cdsItensUNIDADE.AsString,6);                         //Unidade   Tamanho 6 - 295 a 300
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Base ICMS Dif Aliqutoa    Tamanho 12 - 301 a 312
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Origem Dif Aliqutoa    Tamanho 12 - 313 a 324
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Interno Dif Aliqutoa   Tamanho 12 - 325 a 336
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Recolher Dif Aliquota   Tamanho 12 - 337 a 348
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Base ICMS Antecipação Parcial   Tamanho 12 - 349 a 360
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Origem Antecipação Parcial   Tamanho 12 - 361 a 372
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Interno Antecipação Parcial   Tamanho 12 - 373 a 384
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS a Recolher Antecipação Parcial   Tamanho 12 - 385 a 396
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Base Subs.Trib. Antecipação   Tamanho 12 - 397 a 408
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //MVA Subs.Trib. Antecipação   Tamanho 12 - 409 a 420
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Base Ajustada Subs.Trib. Antecipação   Tamanho 12 - 421 a 432
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Origem Subs.Trib. Antecipação   Tamanho 12 - 433 a 444
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Interno Subs.Trib. Antecipação   Tamanho 12 - 445 a 456
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //ICMS Recolher Subs.Trib. Antecipação   Tamanho 12 - 457 a 468
  if Length(vCSTICMS) = 3 then
    Texto1 := Texto1 + Formatar_Campo('S',1)                                                            //CST Simples Nacional   Tamanho 1 - 469 a 469
  else
    Texto1 := Texto1 + Formatar_Campo('N',1);                                                            //CST Simples Nacional   Tamanho 1 - 469 a 469
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Valor ICMS Antecipação Parcial  Tamanho 12 - 470 a 481
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),2);                                               //Alíquota Desconto condicional    Tamanho 2 - 482 a 483
  Texto1 := Texto1 + Formatar_Campo('N',1);                                                            //Produto Industrializado   Tamanho 1 - 484 a 484
  Texto1 := Texto1 + Formatar_Campo('',5);                                                             //Branco   Tamanho 5 - 485 a 489
  Texto1 := Texto1 + Formatar_Campo('',5);                                                             //Uso da EBS  Tamanho 5 - 490 a 494
  vContador := vContador + 1;
  Texto1 := Texto1 + Monta_Numero(IntToStr(vContador),6);                                              //Sequencia   Tamanho 6 - 495 a 500
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Regime cumulativo - Crédito Pis  Tamanho 12 - 501 a 512
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Regime cumulativo - Crédito Cofins  Tamanho 12 - 513 a 524
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',fDMIntegracao.cdsItensVLR_FRETE.AsFloat),12);     //Valor Frete  Tamanho 12 - 525 a 536
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Seguro   Tamanho 12 - 537 a 548
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Despesas  Tamanho 12 - 549 a 560
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),4);                                               //CFOP Saída  Tamanho 4 - 561 a 564
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),1);                                               //Origem  Tamanho 1 - 565 a 565
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),2);                                               //Saída CST  Tamanho 2 - 566 a 567
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Base ICMS  Tamanho 12 - 568 a 579
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),5);                                            //Saída Alíquota ICMS  Tamanho 5 - 580 a 584
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Valor ICMS  Tamanho 12 - 585 a 596
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Base ICMS ST  Tamanho 12 - 597 a 608
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),5);                                            //Saída Alíquota ICMS ST  Tamanho 5 - 609 a 613
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Valor ICMS ST Tamanho 12 - 614 a 625
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),2);                                               //Saída CST IPI  Tamanho 2 - 626 a 627
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Base IPI  Tamanho 12 - 628 a 639
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),5);                                            //Saída Alíquota IPI  Tamanho 5 - 640 a 644
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Valor IPI Tamanho 12 - 645 a 656
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),2);                                               //Saída CST Pis  Tamanho 2 - 657 a 658
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Base Pis  Tamanho 12 - 659 a 670
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),7);                                          //Saída Alíquota Pis  Tamanho 7 - 671 a 677
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Valor Pis Tamanho 12 - 678 a 689
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.000',0),13);                                          //Saída Qtde Base Pis Tamanho 13 - 690 a 702
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),14);                                         //Saída Aliquota Valor Pis Tamanho 14 - 703 a 716
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),2);                                               //Saída CST Cofins  Tamanho 2 - 717 a 718
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Base Cofins  Tamanho 12 - 719 a 730
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),7);                                          //Saída Alíquota Cofins  Tamanho 7 - 731 a 737
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Saída Valor Cofins Tamanho 12 - 738 a 749
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.000',0),13);                                          //Saída Qtde Base Cofins Tamanho 13 - 750 a 762
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),14);                                         //Saída Aliquota Valor Cofins Tamanho 14 - 763 a 776
  Texto1 := Texto1 + Formatar_Campo('',30);                                                            //Identificação2   Tamanho 30 - 777 a 806
  Texto1 := Texto1 + Formatar_Campo('',20);                                                            //Código de Barras(Gtin)   Tamanho 20 - 807 a 826
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.0000',0),12);                                         //MVA Original - Subst Trib. Antec. Tamanho 12 - 827 a 838
  Texto1 := Texto1 + Formatar_Campo('',20);                                                            //Número do Lote   Tamanho 20 - 839 a 858
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.000',0),11);                                          //Qtde Item por Lote  Tamanho 11 - 859 a 869
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),8);                                               //Data de Fabricação  Tamanho 8 - 870 a 877
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0',0),8);                                               //Data de Validade  Tamanho 8 - 878 a 885
  Texto1 := Texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Valor do Preço  Tamanho 12 - 886 a 897
  Writeln(txt,texto1);
end;

procedure TfrmIntegracao.prc_Montar_DadosComplementares;
var
  Texto1 : String;
begin
  Texto1 := '5';                                                                                       //Tipo Registro   Tamanho 1 - 1 a 1
  Texto1 := Texto1 + Monta_Numero('0',12);                                                             //Valor Mercadorias   Tamanho 12 - 2 a 13
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //Desconto   Tamanho 12 - 14 a 25
  Texto1 := Texto1 + Monta_Numero('0',12);                                                             //Frete   Tamanho 12 - 26 a 37
  Texto1 := Texto1 + Monta_Numero('0',12);                                                             //Despesas   Tamanho 12 - 38 a 49
  Texto1 := Texto1 + Monta_Numero('0',12);                                                             //Seguro   Tamanho 12 - 50 a 61
  Texto1 := Texto1 + Monta_Numero('0',8);                                                              //Peso Bruto   Tamanho 8 - 62 a 69
  Texto1 := Texto1 + Monta_Numero('0',8);                                                              //Peso Líquido   Tamanho 8 - 70 a 77
  Texto1 := Texto1 + Monta_Numero('0',18);                                                             //CNPJ/CPF Transportador   Tamanho 18 - 78 a 95
  Texto1 := Texto1 + Monta_Numero('0',1);                                                              //Meio de Transporte   Tamanho 1 - 96 a 96
  Texto1 := Texto1 + Formatar_Campo('',15);                                                            //Placa   Tamanho 15 - 97 a 111
  Texto1 := Texto1 + Monta_Numero('0',6);                                                              //Volumes   Tamanho 6 - 112 a 117
  Texto1 := Texto1 + Formatar_Campo('',10);                                                            //Espécie   Tamanho 10 - 118 a 127
  Texto1 := Texto1 + Monta_Numero('0',12);                                                             //Número RE   Tamanho 12 - 128 a 139
  Texto1 := Texto1 + Monta_Numero('0',11);                                                             //Número de Despacho Tamanho 11 - 140 a 150
  Texto1 := Texto1 + Monta_Numero('0',6);                                                              //País Destino   Tamanho 6 - 151 a 156
  Texto1 := Texto1 + Monta_Numero('0',6);                                                              //Moeda    Tamanho 6 - 157 a 162
  Texto1 := Texto1 + Monta_Numero('0',8);                                                              //Data Despacho    Tamanho 8 - 163 a 170
  Texto1 := Texto1 + Monta_Numero('0',12);                                                             //Valor Despacho    Tamanho 12 - 171 a 182
  Texto1 := Texto1 + Formatar_Campo('',18);                                                            //CNPJ/CPF Remetente    Tamanho 18 - 183 a 200
  Texto1 := Texto1 + Formatar_Campo('',2);                                                             //UF Destino     Tamanho 2 - 201 a 202
  Texto1 := Texto1 + Formatar_Campo('',18);                                                            //Identificação Exterior Remetente   Tamanho 18 - 203 a 220
  Texto1 := Texto1 + Formatar_Campo('N',1);                                                            //Redespacho     Tamanho 1 - 221 a 221
  Texto1 := texto1 + Monta_Numero(FormatFloat('0.00',0),12);                                           //INSS Retido    Tamanho 12 - 222 a 233
  Texto1 := texto1 + Monta_Numero('0',12);                                                             //FUNRURAL    Tamanho 12 - 234 a 245
  Texto1 := texto1 + Formatar_Campo('',44);                                                            //Chave NFe    Tamanho 44 - 246 a 289
  Texto1 := texto1 + Formatar_Campo('N',1);                                                            //ISS Retido    Tamanho 1 - 290 a 290
  Texto1 := texto1 + Formatar_Campo('N',1);                                                            //ISS Devido Prestação  Tamanho 1 - 291 a 291
  Texto1 := texto1 + Formatar_Campo('',2);                                                             //UF Prestação  Tamanho 2 - 292 a 293
  Texto1 := texto1 + Monta_Numero('',7);                                                               //Municipio Prestação  Tamanho 7 - 294 a 300
  Texto1 := texto1 + Formatar_Campo('',2);                                                             //UF Origem  Tamanho 2 - 301 a 302
  Texto1 := texto1 + Monta_Numero('',7);                                                               //Municipio Origem  Tamanho 7 - 303 a 309
  Texto1 := texto1 + Formatar_Campo('N',1);                                                            //ICMS-ST Retido Antecipadamente  Tamanho 1 - 310 a 310
  Texto1 := texto1 + Formatar_Campo('',20);                                                            //Inscrição Estadual Destinatário  Tamanho 20 - 311 a 330
  Texto1 := texto1 + Monta_Numero('0',1);                                                              //Tipo de Assinante Telecom Tamanho 1 - 331 a 331
  Texto1 := texto1 + Monta_Numero('0',1);                                                              //Tipo de Utilização Telecom Tamanho 1 - 332 a 332
  Texto1 := texto1 + Formatar_Campo('',10);                                                            //Número Terminal Telecom  Tamanho 10 - 333 a 342
  Texto1 := texto1 + Monta_Numero('0',9);                                                              //Número Fatura Telecom   Tamanho 9 - 343 a 351
  Texto1 := texto1 + Formatar_Campo('',18);                                                            //Consignatário  Tamanho 18 - 352 a 369
  Texto1 := texto1 + Formatar_Campo('',119);                                                           //Brancos  Tamanho 119 - 370 a 489
  Texto1 := texto1 + Formatar_Campo('',5);                                                             //Uso EBS  Tamanho 5 - 490 a 494
  vContador := vContador + 1;
  Texto1    := Texto1 + Monta_Numero(IntToStr(vContador),6);                                           //Sequência   Tamanho 6 - 495 a 500
  Writeln(txt,texto1);
end;

procedure TfrmIntegracao.prc_Consultar_Transferencia;
begin
  fDMIntegracao.cdsTransferencia.Close;
  fDMIntegracao.sdsTransferencia.ParamByName('DTINICIAL').AsDate := NxDatePicker1.Date;
  fDMIntegracao.sdsTransferencia.ParamByName('DTFINAL').AsDate   := NxDatePicker2.Date;
  fDMIntegracao.sdsTransferencia.ParamByName('FILIAL').AsInteger := RxDBLookupCombo1.KeyValue;
  fDMIntegracao.cdsTransferencia.Open;
end;

procedure TfrmIntegracao.prc_Le_Contabil_Ope_Lacto_Transf(Tipo_ES: String);
const
  vContasAux : array[1..12] of String = ('Contas','Cliente','Fornecedor','Juros_Pagos','Juros_Rec','Contas de Orçamento','Desconto C.Receber',
                                         'Desconto C.Pagar','Multa C.Receber','Multa C.Pagar','Transferência (Origem)','Transferência (Destino)');
var
  vVlr_Conferencia_Deb : Real;
  vVlr_Conferencia_Cre : Real;
begin
  vVlr_Conferencia_Deb := 0;
  vVlr_Conferencia_Cre := 0;
  fDMIntegracao.cdsContabil_Ope_Lacto.Close;
  fDMIntegracao.sdsContabil_Ope_Lacto.ParamByName('ID').AsInteger := fDMIntegracao.cdsTransferenciaID_CONTABIL_OPE.AsInteger;
  fDMIntegracao.cdsContabil_Ope_Lacto.Open;
  if fDMIntegracao.cdsContabil_Ope_Lacto.IsEmpty then
    prc_gravar_mErro('Transferência ' + fDMIntegracao.cdsTransferenciaID_TRANSFERENCIA.AsString + ' não gravado a operação contábil!');

  fDMIntegracao.cdsContabil_Ope_Lacto.First;
  while not fDMIntegracao.cdsContabil_Ope_Lacto.Eof do
  begin
    vCod_Debito  := 0;
    vCod_Credito := 0;
    case fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger of
      13 : vCod_Debito := fDMIntegracao.cdsTransferenciaCOD_CONTABIL_CONTAS.AsInteger;
      14 : vCod_Debito := fDMIntegracao.cdsTransferenciaCOD_CONTABIL_CONTAS.AsInteger;
    end;
    if (fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger > 0) and (vCod_Debito <= 0) then
      prc_gravar_mErro('Transferência ' + fDMIntegracao.cdsTransferenciaID_TRANSFERENCIA.AsString + ' sem conta contabil (' + vContasAux[fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger] + ') no lançamento debito' );
    case fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger of
      13 : vCod_Credito := fDMIntegracao.cdsTransferenciaCOD_CONTABIL_CONTAS.AsInteger;
      14 : vCod_Credito := fDMIntegracao.cdsTransferenciaCOD_CONTABIL_CONTAS.AsInteger;
    end;
    if (fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger > 0) and (vCod_Credito <= 0) then
      prc_gravar_mErro('Transferência ' + fDMIntegracao.cdsTransferenciaID_TRANSFERENCIA.AsString + ' sem conta contabil (' + vContasAux[fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger] + ') no lançamento crédito' );

    vHistorico := fnc_Monta_Hist(True);
    vVlr_Lacto := fnc_Monta_Vlr(True);
    if (StrToFloat(FormatFloat('0.00',vVlr_Lacto)) > 0) then
    begin
      if vCod_Debito > 0 then
        vVlr_Conferencia_Deb := vVlr_Conferencia_Deb + vVlr_Lacto;
      if vCod_Credito > 0 then
        vVlr_Conferencia_Cre := vVlr_Conferencia_Cre + vVlr_Lacto;
      prc_Gravar_mAuxiliar_Novo(Tipo_ES);
    end;

    fDMIntegracao.cdsContabil_Ope_Lacto.Next;
  end;
  if StrToFloat(FormatFloat('0.00',vVlr_Conferencia_Cre)) <> StrToFloat(FormatFloat('0.00',vVlr_Conferencia_Deb)) then
    prc_gravar_mErro('Título ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' com diferença de valores para débito e crédito');
end;

end.
