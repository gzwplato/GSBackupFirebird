unit ufrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.CategoryButtons, Vcl.WinXCtrls,
  Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxPC, JvExControls,
  JvGradientHeaderPanel, cxContainer, cxEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Phys.FBDef, FireDAC.Stan.Def,
  FireDAC.VCLUI.Wait, FireDAC.Phys.IBWrapper, Vcl.ExtDlgs, JvBaseDlg,
  JvSelectDirectory, FireDAC.Phys, FireDAC.Phys.IBBase,
  FireDAC.Stan.StorageJSON, FireDAC.Stan.StorageBin, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, cxTextEdit, cxMaskEdit,
  cxButtonEdit, cxDBEdit, cxCheckBox, cxSpinEdit, cxTimeEdit, AdvGlowButton,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGrid, cxImageList, FireDAC.UI.Intf,
  FireDAC.Comp.UI, Vcl.Menus, ZipMstr, dxBarBuiltInMenu, Vcl.FileCtrl;

type
  TfrmMain = class(TForm)
    pnlToolbar: TPanel;
    imgMenu: TImage;
    lblTitle: TLabel;
    SvMenuLateral: TSplitView;
    catMenuItems: TCategoryButtons;
    imagens32x32: TImageList;
    Acoes: TActionList;
    actHome: TAction;
    actBackupAgora: TAction;
    actRestaurarBackup: TAction;
    cxPcMenu: TcxPageControl;
    tbHome: TcxTabSheet;
    grpFundoHome: TGroupBox;
    pnlTopHome: TJvGradientHeaderPanel;
    grpPastaBackup: TGroupBox;
    btnPastaBackup: TcxDBButtonEdit;
    dsConfiguracao: TDataSource;
    mtConfiguracao: TFDMemTable;
    mtConfiguracaohora_backup: TTimeField;
    mtConfiguracaobackup_segunda: TBooleanField;
    mtConfiguracaobackup_terca: TBooleanField;
    mtConfiguracaobackup_quarta: TBooleanField;
    mtConfiguracaobackup_quinta: TBooleanField;
    mtConfiguracaobackup_sexta: TBooleanField;
    mtConfiguracaobackup_sabado: TBooleanField;
    mtConfiguracaobackup_domingo: TBooleanField;
    mtConfiguracaolocal_backup: TStringField;
    dsBanco: TDataSource;
    mtBanco: TFDMemTable;
    mtBancocaminho_banco: TStringField;
    mtBanconome_backup: TStringField;
    FBDrive: TFDPhysFBDriverLink;
    SSBL: TFDStanStorageBinLink;
    SSJSON: TFDStanStorageJSONLink;
    localBackup: TJvSelectDirectory;
    CaminhoBanco: TOpenTextFileDialog;
    grpHorarioBackup: TGroupBox;
    edtHorarioInicio: TcxDBTimeEdit;
    lblHorarioInicio: TLabel;
    lblHorarioFim: TLabel;
    edtHorarioLimite: TcxDBTimeEdit;
    grpDiasBackup: TGroupBox;
    cxDBCheckBox1: TcxDBCheckBox;
    cxDBCheckBox5: TcxDBCheckBox;
    cxDBCheckBox2: TcxDBCheckBox;
    cxDBCheckBox6: TcxDBCheckBox;
    cxDBCheckBox3: TcxDBCheckBox;
    cxDBCheckBox7: TcxDBCheckBox;
    cxDBCheckBox4: TcxDBCheckBox;
    pnlListaDosBancos: TJvGradientHeaderPanel;
    pnlMenuListaBancos: TPanel;
    btnIncluir: TAdvGlowButton;
    btnEditar: TAdvGlowButton;
    btnDeletar: TAdvGlowButton;
    GridBanco: TcxGrid;
    GridBancoDB: TcxGridDBTableView;
    GridBancoDBnome_backup: TcxGridDBColumn;
    GridBancoDBcaminho_banco: TcxGridDBColumn;
    GridBancoL: TcxGridLevel;
    cxImage: TcxImageList;
    ibSecurity: TFDIBSecurity;
    ibBackup: TFDIBBackup;
    TrayIcon: TTrayIcon;
    pmOpcoes: TPopupMenu;
    Abrir1: TMenuItem;
    N1: TMenuItem;
    FinalizarServidor1: TMenuItem;
    Style: TcxStyleRepository;
    cxStyleZebrado: TcxStyle;
    cxStyleTituloGrid: TcxStyle;
    tmrBackup: TTimer;
    tbAndamentoBackups: TcxTabSheet;
    grpProgressoBackup: TGroupBox;
    pnlTopProgresso: TJvGradientHeaderPanel;
    mmoProgresso: TMemo;
    procedure imgMenuClick(Sender: TObject);
    procedure SvMenuLateralClosed(Sender: TObject);
    procedure SvMenuLateralOpened(Sender: TObject);
    procedure btnPastaBackupPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure actBackupAgoraExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Abrir1Click(Sender: TObject);
    procedure FinalizarServidor1Click(Sender: TObject);
    procedure tmrBackupTimer(Sender: TObject);
    procedure ibBackupProgress(ASender: TFDPhysDriverService;
      const AMessage: string);
    procedure actRestaurarBackupExecute(Sender: TObject);
  private
    vFinalizarServidor: Boolean;

    procedure AbreDtsConfiguracao;
    procedure SalvaDtsConfiguracao;
    procedure AbreDtsBanco;
    procedure SalvaDtsBanco;
    procedure RealizaBackup(pCaminhoBanco: string);
    function CompactarArquivo(pSenha, pOrigem, pDestino: string): Boolean;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.AbreDtsBanco;
begin
  mtBanco.Close;
  mtBanco.Open;
  if FileExists(ExtractFileDir(Application.ExeName)+'\mtBanco.JSON') then
    mtBanco.LoadFromFile(ExtractFileDir(Application.ExeName)+'\mtBanco.JSON',sfJSON);
end;

procedure TfrmMain.AbreDtsConfiguracao;
begin
  mtConfiguracao.Close;
  mtConfiguracao.Open;
  if FileExists(ExtractFileDir(Application.ExeName)+'\mtConfiguracao.JSON') then
  begin
    mtConfiguracao.LoadFromFile(ExtractFileDir(Application.ExeName)+'\mtConfiguracao.JSON',sfJSON);
    mtConfiguracao.Edit;
  end
  else
    mtConfiguracao.Insert;
end;

procedure TfrmMain.Abrir1Click(Sender: TObject);
begin
  if not Application.ShowMainForm then
  begin
    Application.ShowMainForm := True;
    Show;
  end;
end;

procedure TfrmMain.actBackupAgoraExecute(Sender: TObject);
begin
  tmrBackup.Enabled :=False;
  mmoProgresso.Lines.Clear;
  cxPcMenu.ActivePage :=tbAndamentoBackups;

  mtBanco.DisableControls;
  mtBanco.First;
  try
    mmoProgresso.Lines.Add('Realizando backups...');
    while not mtBanco.Eof do
    begin
      mmoProgresso.Lines.Add('');
      mmoProgresso.Lines.Add('Banco: '+mtBanconome_backup.AsString);
      RealizaBackup(mtBancocaminho_banco.AsString);
      mtBanco.Next;
      mmoProgresso.Lines.Add('');
    end;
  finally
    mtBanco.EnableControls;
    Screen.Cursor :=crDefault;
    mmoProgresso.Lines.Add('Todos os backups foram realizados com sucesso! T�rmino em: '+FormatDateTime('DD-MM-YYYY HH-MM-SS',Now));
    tmrBackup.Enabled :=True;
  end;
end;

procedure TfrmMain.actRestaurarBackupExecute(Sender: TObject);
begin
  ShowMessage('Na pr�xima vers�o!');
end;

procedure TfrmMain.btnEditarClick(Sender: TObject);
var
  vNomeBackup:String;
begin
  if mtBanco.RecordCount > 0 then
  begin
    vNomeBackup :=EmptyStr;
    if CaminhoBanco.Execute() then
    begin
      if not mtBanco.Locate('caminho_banco',CaminhoBanco.FileName,[]) then
      begin
        mtBanco.Edit;
        mtBancocaminho_banco.AsString :=CaminhoBanco.FileName;
        while vNomeBackup = EmptyStr do
        begin
          vNomeBackup :=mtBanconome_backup.AsString;
          if not InputQuery('Informe um nome para o backup','Nome do Backup',vNomeBackup) then
            vNomeBackup :=EmptyStr;
        end;
        mtBanconome_backup.AsString :=vNomeBackup;
        mtBanco.Post;
        SalvaDtsBanco;
      end;
    end;
  end;
end;

procedure TfrmMain.btnDeletarClick(Sender: TObject);
begin
  if mtBanco.RecordCount > 0 then
  begin
    if MessageDlg('Deseja realmente excluir o registro?',mtConfirmation,mbYesNo,0) = mrYes then
      mtBanco.Delete;
  end;
end;

procedure TfrmMain.btnIncluirClick(Sender: TObject);
var
  vNomeBackup:String;
begin
  vNomeBackup :=EmptyStr;
  if CaminhoBanco.Execute() then
  begin
    if not mtBanco.Locate('caminho_banco',CaminhoBanco.FileName,[]) then
    begin
      mtBanco.Append;
      mtBancocaminho_banco.AsString :=CaminhoBanco.FileName;
      while vNomeBackup = EmptyStr do
      begin
        if not InputQuery('Informe um nome para o backup','Nome do Backup',vNomeBackup) then
          vNomeBackup :=EmptyStr;
      end;
      mtBanconome_backup.AsString :=vNomeBackup;
      mtBanco.Post;

      SalvaDtsBanco;
    end;
  end;
end;

procedure TfrmMain.btnPastaBackupPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  if localBackup.Execute() then
  begin
    if not(mtConfiguracao.State in [dsEdit,dsInsert]) then
      mtConfiguracao.Edit;

    mtConfiguracaolocal_backup.AsString :=localBackup.Directory;
    mtConfiguracao.Post;
  end;
end;

function TfrmMain.CompactarArquivo(pSenha, pOrigem, pDestino: string): Boolean;
var
  vZip: TZipMaster;
  vI: Integer;
  vArquivo: string;
begin
  //Validar entradas

  vZip := TZipMaster.Create(nil);
  try
    vZip.DLLDirectory := ExtractFileDir(Application.ExeName);
    vZip.Dll_Load := True;
    vZip.ZipFileName :=pDestino;
    vZip.FSpecArgs.Clear;
    vZip.FSpecArgs.Add(pOrigem);

    vZip.Add;
    Result :=vZip.SuccessCnt > 0;
  finally
    vZip.Free;
  end;
end;

procedure TfrmMain.FinalizarServidor1Click(Sender: TObject);
begin
  vFinalizarServidor :=True;
  Close;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.Terminate;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if vFinalizarServidor then
  begin
    SalvaDtsConfiguracao;
    SalvaDtsBanco;
    CanClose :=True;
    Application.Terminate;
  end
  else
  begin
    CanClose :=False;
    if Application.ShowMainForm then
    begin
      Application.ShowMainForm :=False;
      Hide;
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  vFinalizarServidor :=False;
  AbreDtsConfiguracao;
  AbreDtsBanco;
end;

procedure TfrmMain.ibBackupProgress(ASender: TFDPhysDriverService;
  const AMessage: string);
begin
//  mmoProgresso.Lines.Add(AMessage);
end;

procedure TfrmMain.imgMenuClick(Sender: TObject);
begin
  if SvMenuLateral.Opened then
    SvMenuLateral.Close
  else
    SvMenuLateral.Open;
end;

procedure TfrmMain.RealizaBackup(pCaminhoBanco: string);
var
  vArquivoBackup, vArquivoBackupCompactado,
  vLocalTempArqBackup, vNomeArqCompactado: string;
begin
  vLocalTempArqBackup := ExtractFileDir(Application.ExeName)+'\'+
                              mtBanconome_backup.AsString+'-'+
                              FormatDateTime('DD-MM-YYYY HH-MM-SS',Now)+'.fbk';

  vArquivoBackup := vLocalTempArqBackup;

  with ibBackup do begin

    Host := '127.0.0.1';
    Database := pCaminhoBanco;
    UserName := 'SYSDBA';
    Port :=3050;
    Password := 'masterkey';
    BackupFiles.Clear;
    BackupFiles.Add(vArquivoBackup);
    Backup;
  end;
  mmoProgresso.Lines.Add('Backup realizado com sucesso: '+mtBanconome_backup.AsString);
  mmoProgresso.Lines.Add('Zipando Backup de: '+mtBanconome_backup.AsString);

  vNomeArqCompactado := mtBanconome_backup.AsString+'-'+
                             FormatDateTime('DD-MM-YYYY HH-MM-SS',Now);

  vArquivoBackupCompactado :=ExtractFileDir(Application.ExeName)+'\'+ vNomeArqCompactado;

  if CompactarArquivo('masterrg', vArquivoBackup, vArquivoBackupCompactado) then
  begin
    MoveFile(PWideChar(vArquivoBackupCompactado+'.zip'), PWideChar(mtConfiguracaolocal_backup.AsString+'\'+vNomeArqCompactado+'.zip'));
  end;

  mmoProgresso.Lines.Add('Arquivo zipado com sucesso: '+mtBanconome_backup.AsString);
  DeleteFile(vArquivoBackup);
end;

procedure TfrmMain.SalvaDtsBanco;
begin
  mtBanco.SaveToFile(ExtractFileDir(Application.ExeName)+'\mtbanco.JSON',sfJSON);;
end;

procedure TfrmMain.SalvaDtsConfiguracao;
begin
  mtConfiguracao.SaveToFile(ExtractFileDir(Application.ExeName)+'\mtConfiguracao.JSON',sfJSON);;
end;

procedure TfrmMain.SvMenuLateralClosed(Sender: TObject);
begin
  // When TSplitView is closed, adjust ButtonOptions and Width
  catMenuItems.ButtonOptions :=catMenuItems.ButtonOptions - [boShowCaptions];
  if SvMenuLateral.CloseStyle = svcCompact then
    catMenuItems.Width :=SvMenuLateral.CompactWidth;
end;

procedure TfrmMain.SvMenuLateralOpened(Sender: TObject);
begin
  // When not animating, change size of catMenuItems when TSplitView is opened
  catMenuItems.ButtonOptions :=catMenuItems.ButtonOptions + [boShowCaptions];
  catMenuItems.Width :=SvMenuLateral.OpenedWidth;
end;

procedure TfrmMain.tmrBackupTimer(Sender: TObject);
begin
  if (TimeToStr(Time) = edtHorarioInicio.Text) then
   actBackupAgora.Execute;
end;

end.
