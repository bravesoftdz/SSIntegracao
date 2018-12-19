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
    NxDatePicker4: TNxDatePicker;
    NxDatePicker5: TNxDatePicker;
    NxButton1: TNxButton;
    DirectoryEdit2: TDirectoryEdit;
    NxButton2: TNxButton;
    NxDatePicker6: TNxDatePicker;
    RzGroupBox2: TRzGroupBox;
    Label17: TLabel;
    CurrencyEdit2: TCurrencyEdit;
    Label20: TLabel;
    ComboBox2: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure NxDatePicker2Exit(Sender: TObject);
    procedure btnOperacoesClick(Sender: TObject);
    procedure RxDBLookupCombo1Exit(Sender: TObject);
    procedure btnPlanoContasClick(Sender: TObject);
  private
    { Private declarations }
    fDMIntegracao: TDMIntegracao;
    vContador : Integer;
    vVlrTotal : Real;
    vArqTxt : TextFile;
    vHistorico : String;
    vCod_Debito, vCod_Credito : Integer;
    vVlr_Lacto : Real;
    
    procedure prc_Consultar_Titulos_Pagos;
    procedure prc_Gravar_mAuxiliar(Tipo_Lanc : String); //L=Lancamento  J=Juros
    procedure prc_Gravar_mAuxiliar_Novo(Tipo_Lanc : String); //L=Lancamento  J=Juros
    procedure prc_gravar_mErro(Erro : String);
    procedure prc_Le_Contabil_Ope_Lacto(Tipo_ES : String);

    procedure prc_Grava_Lote;
    procedure prc_Grava_Lancamentos;
    procedure prc_Gravar_Historico_H;

    function Monta_Numero(Campo: String; Tamanho: Integer): String;

    function fnc_Monta_Hist : String;
    function fnc_Monta_Vlr : Real;

  public
    { Public declarations }
  end;

var
  frmIntegracao: TfrmIntegracao;

implementation

uses rsDBUtils, DB, UCadContabil_Ope, uUtilPadrao, StrUtils,
  UConvPlanoContas;

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

  NxDatePicker1.Clear;
  NxDatePicker2.Clear;
  NxDatePicker3.Clear;

  DirectoryEdit1.Text := fDMIntegracao.qParametros_GeralEND_ARQ_INT_CONTABIL.AsString;
  DirectoryEdit2.Text := fDMIntegracao.qParametros_GeralEND_ARQ_INT_CONTABIL.AsString;
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
    vMSGErro := vMSGErro + #13 + '*** Data inicial n�o informada!';
  if NxDatePicker2.Date < 10 then
    vMSGErro := vMSGErro + #13 + '*** Data final n�o informada!';
  if NxDatePicker1.Date > NxDatePicker2.Date then
    vMSGErro := vMSGErro + #13 + '*** Data inicial n�o pode ser maior que a final!';
  if trim(RxDBLookupCombo1.Text) = '' then
    vMSGErro := vMSGErro + #13 + '*** Filial n�o informada!';
  if CurrencyEdit1.AsInteger <= 0 then
    vMSGErro := vMSGErro + #13 + '*** N� Sequencial do lote n�o informado!';
  if trim(Edit1.Text) = '' then
    vMSGErro := vMSGErro + #13 + '*** Descri��o do lote n�o informadada!';
  //if trim(Edit2.Text) = '' then
  //  vMSGErro := vMSGErro + #13 + '*** Identificador do lote n�o informadado!';
  if trim(vMSGErro) <> '' then
  begin
    MessageDlg(vMSGErro, mtError, [mbOk], 0);
    exit;
  end;

  if MessageDlg('Deseja gerar o arquivo auxiliar da integra��o?',mtConfirmation,[mbYes,mbNo],0) = mrNo then
    exit;

  vContador := 0;
  vVlrTotal := 0;
  fDMIntegracao.mAuxiliar.EmptyDataSet;
  fDMIntegracao.mErros.EmptyDataSet;
  prc_Consultar_Titulos_Pagos;
  if fDMIntegracao.cdsTitulos_Pagos.IsEmpty then
  begin
    MessageDlg('*** N�o existe registro para ser gerado!', mtError, [mbOk], 0);
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

  //Tipo do Lote - Di�rio ou Mensal
  texto1 := texto1 + 'M';

  //Data do Lote
  DecodeDate(NxDatePicker3.Date,ano,mes,dia);
  texto1 := texto1 + FormatFloat('00',dia) + FormatFloat('00',mes) + FormatFloat('0000',ano);

  //Valor Total do Lote
  texto2 := FormatFloat('0000000000000.00',vVlrTotal);
  Delete(texto2,14,1);
  texto1 := texto1 + texto2;

  //Descri��o do Lote
  texto2 := copy(Edit1.Text,1,20);
  for i := 1 to 20 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Origem Lan�amento
  texto1 := texto1 + 'OUT';

  //Identificador do Lote
  texto2 := copy(Edit2.Text,1,10);
  for i := 1 to 10 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Situa��o do lote
  texto1 := texto1 + 'L';

  //Situa��o do lote
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

  //Data do lan�amento - 2 a 9
  DecodeDate(fDMIntegracao.mAuxiliarDtLancamento.AsDateTime,ano,mes,dia);
  texto1 := texto1 + FormatFloat('00',dia) + FormatFloat('00',mes) + FormatFloat('0000',ano);

  //Conta Reduzida a D�bito - 10 a 15
  texto2 := fDMIntegracao.mAuxiliarCod_Debito.AsString;
  for i := 1 to 6 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Conta Reduzida a Cr�dito - 16 a 21
  texto2 := fDMIntegracao.mAuxiliarCod_Credito.AsString;
  for i := 1 to 6 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Hist�rico Padr�o - 22 a 24
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

  //Valor do lan�amento - 50 a 64
  texto2 := FormatFloat('0000000000000.00',fDMIntegracao.mAuxiliarVlr_Lancamento.AsFloat);
  Delete(texto2,14,1);
  texto1 := texto1 + texto2;

  //C�digo do Centro de Custo - 65 a 67
  texto2 := Copy(fDMIntegracao.mAuxiliarCod_CentroCusto.AsString,1,3);
  for i := 1 to 3 - Length(texto2) do
    texto2 := '0' + texto2;
  texto1 := texto1 + texto2;

  //Classifica��o Cont�bil a D�bito - 68 a 81
  texto2 := Copy(fDMIntegracao.mAuxiliarClas_Contabil_Deb.AsString,1,14);
  for i := 1 to 14 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Classifica��o Cont�bil a Cr�dito - 82 a 95
  texto2 := Copy(fDMIntegracao.mAuxiliarClas_Contabil_Cre.AsString,1,14);
  for i := 1 to 14 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Sequencia - 96 a 100
  vContador := vContador + 1;
  texto1 := texto1 + FormatFloat('00000',vContador);

  //Delimitador - 101 a 101
  texto1 := texto1 + '|';

  //Observa��es - 102 a 191
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

  if trim(vHistorico) <> '' then
    prc_Gravar_Historico_H;
end;

procedure TfrmIntegracao.prc_Gravar_Historico_H;
var
  texto1, texto2 : String;
  i : Integer;
begin
  //Tipo Registro
  texto1 := 'H';

  //Hist�rico - 02 ao 51
  //texto2 := copy(fDMIntegracao.mAuxiliarDesc_Historico.AsString,1,50);
  texto2 := copy(vHistorico,1,50);
  for i := 1 to 50 - Length(texto2) do
    texto2 := texto2 + ' ';
  texto1 := texto1 + texto2;

  //Reservado - 51 ao 95
  for i := 1 to 44 do
    texto1 := texto1 + ' ';

  //Sequencia - 96 ao 100
  vContador := vContador + 1;
  texto1 := texto1 + FormatFloat('00000',vContador);
  Writeln(vArqTxt,Texto1);
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
        prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o possui c�d. cont�bil de juros recebidos "Cadastro de Filial"');
    end
    else
    begin
      fDMIntegracao.mAuxiliarCod_Debito.AsInteger  := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS.AsInteger;
      fDMIntegracao.mAuxiliarCod_Credito.AsInteger := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_JUROS_PAGOS.AsInteger <= 0 then
        prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o possui c�d. cont�bil de juros pagos "Cadastro de Filial"');
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
        prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o possui c�d. d�bito "Cadastro de Contas"');
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CLIENTE.AsInteger <= 0 then
        prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o possui c�d. cr�dito "Cadastro de Clientes"');
    end
    else
    begin
      fDMIntegracao.mAuxiliarCod_Debito.AsInteger  :=  fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR.AsInteger;
      fDMIntegracao.mAuxiliarCod_Credito.AsInteger := fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger;
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_FORNECEDOR.AsInteger <= 0 then
        prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o possui c�d. cr�dito "Cadastro de Fornecedores"');
      if fDMIntegracao.cdsTitulos_PagosCOD_CONTABIL_CONTAS.AsInteger <= 0 then
        prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o possui c�d. d�bito "Cadastro de Contas"');
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
   // prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o possui c�d. cont�bil d�bito e cr�dito');
end;

procedure TfrmIntegracao.prc_Le_Contabil_Ope_Lacto(Tipo_ES : String);
const
  vContasAux : array[1..10] of String = ('Contas','Cliente','Fornecedor','Juros_Pagos','Juros_Rec','Contas de Or�amento','Desconto C.Receber',
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
    prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' n�o gravado a opera��o de baixa de t�tulos no cadastro de Filial!');

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
    end;
    if (fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger > 0) and (vCod_Debito <= 0) then
      prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' sem conta contabil (' + vContasAux[fDMIntegracao.cdsContabil_Ope_LactoCONTA_DEBITO.AsInteger] + ') no lan�amento debito' );
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
    end;
    if (fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger > 0) and (vCod_Credito <= 0) then
      prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' sem conta contabil (' + vContasAux[fDMIntegracao.cdsContabil_Ope_LactoCONTA_CREDITO.AsInteger] + ') no lan�amento cr�dito' );

    vHistorico := fnc_Monta_Hist;
    vVlr_Lacto := fnc_Monta_Vlr;
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
    prc_gravar_mErro('T�tulo ' + fDMIntegracao.cdsTitulos_PagosNUMDUPLICATA.AsString + '/' + fDMIntegracao.cdsTitulos_PagosPARCELA.AsString + ' com diferen�a de valores para d�bito e cr�dito');
end;

function TfrmIntegracao.fnc_Monta_Hist: String;
var
  vTexto : String;
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

  Result := vTexto;
end;

function TfrmIntegracao.fnc_Monta_Vlr: Real;
var
  vTexto : String;
  vVlr_Aux : Real;
  vFlag : Boolean;
  i, i2 : Integer;
  vSD : String;
  vVlr_Aux2 : Real;
begin
  vTexto     := trim(fDMIntegracao.cdsContabil_Ope_LactoELEMENTO_VALOR.AsString);
  vFlag      := False;
  vVlr_Aux   := 0;
  vVlr_Aux2 := 0;
  vSD        := '+';
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
  Result := vVlr_Aux2;
end;

procedure TfrmIntegracao.btnPlanoContasClick(Sender: TObject);
begin
  frmConvPlanoContas := TfrmConvPlanoContas.Create(self);
  frmConvPlanoContas.ShowModal;
  FreeAndNil(frmConvPlanoContas);
end;

end.
