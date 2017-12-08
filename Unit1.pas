unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  IdWebsocketServer, IdHTTPWebsocketClient, superobject, IdSocketIOHandling,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    LabelPepyt: TLabel;
    LabelLogBook: TLabel;
    LabelInput: TLabel;
    procedure Button1Click(Sender: TObject);

  private
    procedure ClientBinDataReceived(const aData: TStream);
    function ConnectServer(client : TIdHTTPWebsocketClient;Host : String;Port : Integer; WSResourceName: String):String;

  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;
  clientPepyt: TIdHTTPWebsocketClient;
  clientDoc: TIdHTTPWebsocketClient;
  clientInput: TIdHTTPWebsocketClient;
const
  C_CLIENT_EVENT = 'CLIENT_TO_SERVER_EVENT_TEST';
  C_SERVER_EVENT = 'SERVER_TO_CLIENT_EVENT_TEST';

implementation

{$R *.dfm}

procedure ShowMessageInMainthread(const aMsg: string);
begin
  TThread.Synchronize(nil,
    procedure
    begin
      ShowMessage(aMsg);
    end);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  clientPepyt := TIdHTTPWebsocketClient.Create(nil);
  clientDoc := TIdHTTPWebsocketClient.Create(nil);
  clientInput := TIdHTTPWebsocketClient.Create(nil);


  LabelPepyt.Caption := 'Client Pepyt ' +ConnectServer(clientPepyt,'localhost',5010,'pepyt');
  LabelLogBook.Caption := 'Client LogBook ' +ConnectServer(clientDoc,'localhost',5010,'logbook');
  LabelInput.Caption := 'Client Input ' +ConnectServer(clientinput,'localhost',5010,'input');

  clientPepyt.OnBinData := ClientBinDataReceived;
  clientPepyt.IOHandler.Write('test');

end;


procedure TForm1.ClientBinDataReceived(const aData: TStream);
begin

end;

function TForm1.ConnectServer(client : TIdHTTPWebsocketClient;Host : String;Port : Integer; WSResourceName: String):String;

begin
  client := TIdHTTPWebsocketClient.Create(nil);
  client.Port := Port;
  client.Host := Host;
  client.WSResourceName := WSResourceName;
   if (client.CheckConnection) then
    try
      client.Disconnect();
      client.Connect;
      Result := 'Client connect�';
    Except
      Result := 'Connection echou�';
    end
  else
    try
      client.WSResourceName := 'logbook';
      client.UpgradeToWebsocket;
      Result := 'Client connect�';
    Except
      Result := 'Connection echou�';
    end;
end;

function GetValue(const aData: String; Key: String): String;
var
  JSON: ISuperObject;
  rowItem: ISuperObject;
  ADataStringStream: TStringStream;
begin
  ADataStringStream := TStringStream.Create(aData);
  JSON := TSuperObject.ParseStream(ADataStringStream, False);

  Result := JSON.AsString;

end;

end.
