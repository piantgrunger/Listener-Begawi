unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,uLkJSON, Vcl.OleCtrls,
  zkemkeeper_TLB, Vcl.ExtCtrls,inifiles, Vcl.Menus;

const API_ADDRESS = 'http://localhost:8080/Bagawai/web/api/';
type
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    IdHTTP1: TIdHTTP;
    Edit1: TEdit;
    CZKEM1: TCZKEM;
    GroupBox1: TGroupBox;
    MM_IP_masuk: TMemo;
    Status: TGroupBox;
    lb_stat: TListBox;
    Button2: TButton;
    Button3: TButton;
    TrayIcon1: TTrayIcon;
    PopupMenu1: TPopupMenu;
    Close1: TMenuItem;
    Maximize1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
         procedure CZKEM1AttTransactionEx(Sender: TObject;
      const EnrollNumber: WideString; IsInValid, AttState, VerifyMethod,
      Year, Month, Day, Hour, Minute, Second, WorkCode: Integer);
    procedure Button3Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure Maximize1Click(Sender: TObject);
  private
    procedure OnMinimize(Sender:TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  id :string;
   CZKem : array of TCZKEM;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var s:TStringList;
  ss: string;
  json : TlkJSONbase;
  Ini : TIniFile;
begin
   s:=TStringList.Create;
   s.Add('token='+Edit1.Text);
  ss:= IdHTTP1.Post(API_ADDRESS+ 'connect',s);
  json := TlkJSON.ParseText(ss);
  if json.Field['status'].Value = 200 then
     MessageDlg(' Koneksi Berhasil SKPD: '+#13+ VarToStr(json.Field['message'].Value),mtInformation,[mbok],1)
  else MessageDlg( VarToStr(json.Field['message'].Value),mtError,[mbok],1);
  id := json.Field['id'].Value;
  if strtoint(id) >0 then
  begin
    Ini:=TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
    Ini.WriteString('credential','token',edit1.text);
    Ini.Free;
  end;
  Button2.Enabled:= strtoint(id)>0;

end;

procedure TForm1.Button2Click(Sender: TObject);
var
    i:integer;
    bIsConnected :boolean;
begin
     SetLength(CZkem,MM_IP_masuk.Lines.Count);

     for i:= 0 to MM_IP_masuk.Lines.Count-1 do
     begin
         if not assigned(CZKem[i]) then
            CZKem[i]  := TCZKEM.Create(self);
         bIsConnected :=  CZKem[i].Connect_Net(MM_IP_masuk.Lines[i],4370);
         if  bIsConnected then
         begin
           lb_stat.Items.Add(MM_IP_masuk.Lines[i]+' - Connection Success  ');
           CZKem[i].MachineNumber :=i;
           if CZKem[i].RegEvent(i,1) then
           begin
             lb_stat.Items.Add(MM_IP_masuk.Lines[i]+' - Listening  port 4370 ');
             CZKem[i].OnAttTransactionEx := CZKEM1AttTransactionEx;
           end
           else    lb_stat.Items.Add(MM_IP_masuk.Lines[i]+' - Listening Fail ');
           Button1.Enabled := False;
           Button2.Enabled := True;

          end
          else
            lb_stat.Items.Add(MM_IP_masuk.Lines[i]+' - Connection Failed!!!  ');
          Application.ProcessMessages;
     end;

end;

procedure TForm1.Button3Click(Sender: TObject);
var
    i:integer;
begin

     for i:= 0 to MM_IP_masuk.Lines.Count-1 do
     begin
           CZKem[i].Disconnect;
           lb_stat.Items.Add(MM_IP_masuk.Lines[i]+' - Disconnected   ');
           Button1.Enabled := True;
           Button2.Enabled := False;

           Application.ProcessMessages;
     end;
end;

procedure TForm1.Close1Click(Sender: TObject);
begin
   Application.Terminate;

end;

procedure TForm1.CZKEM1AttTransactionEx(Sender: TObject;
  const EnrollNumber: WideString; IsInValid, AttState, VerifyMethod, Year,
  Month, Day, Hour, Minute, Second, WorkCode: Integer);
var IP,flag,pesan : string;
begin
    ip:= MM_IP_masuk.Lines[TCZKEM(sender).MachineNumber] + '-  '+inttostr(AttState);
      pesan := IP+'  '+EnrollNumber+ifthen(workcode=1,' Masuk ',' Pulang ')+' ~ '+FormatDateTime('dd/mm/yyy HH:nn:ss ',EncodeDate(Year,Month,Day)+EncodeTime(Hour,Minute,Second,0)) ;
      ip := copy(ip,0,pos('-',ip)-1);
        lb_stat.Items.Add(pesan);


end;

procedure TForm1.FormCreate(Sender: TObject);
var ini : TIniFile;
begin
    Application.OnMinimize:=OnMinimize; // Set the event handler for application minimize
        Ini:=TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
   Edit1.Text:=   Ini.ReadString('credential','token','');
   Button1.Click;
    Ini.Free;

end;

procedure TForm1.Maximize1Click(Sender: TObject);
begin
               TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();

end;

procedure TForm1.OnMinimize(Sender: TObject);
begin
    Hide; // This is to hide it from taskbar

  { Show the animated tray icon and also a hint balloon. }
  TrayIcon1.Visible := True;
  TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.TrayIcon1Click(Sender: TObject);
begin
//   PopupMenu1.PopupComponent:=TrayIcon1;
end;

end.
