unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,

  IdWebsocketServer, IdHTTPWebsocketClient, superobject, IdSocketIOHandling,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    LabelPepyt: TLabel;
    LabelLogBook: TLabel;
    LabelInput: TLabel;
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure Button1Click(Sender: TObject);

  private
    procedure ClientBinDataReceived(const aData: String);
    function ConnectServer(var client: TIdHTTPWebsocketClient; Host: String;
      Port: Integer; WSResourceName: String): String;

  public
    { Déclarations publiques }
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

  LabelPepyt.Caption := 'Client Pepyt ' + ConnectServer(clientPepyt,
    'localhost', 5010, 'pepyt');
  LabelLogBook.Caption := 'Client LogBook ' + ConnectServer(clientDoc,
    'localhost', 5010, 'logbook');
  LabelInput.Caption := 'Client Input ' + ConnectServer(clientInput,
    'localhost', 5010, 'input');

  clientDoc.OnTextData := ClientBinDataReceived;

end;

procedure TForm1.ClientBinDataReceived(const aData: string);
var
  JSON: ISuperObject;
  rowItem: ISuperObject;
  ADataStringStream: TStringStream;
  item: TSuperObjectIter;
begin
  ADataStringStream := TStringStream.Create(aData);
  JSON := TSuperObject.ParseStream(ADataStringStream, True);

  Label1.Caption := JSON.AsObject.S['event_type'];

  JSON.SaveTo('d:\server.txt', True);

end;

function TForm1.ConnectServer(var client: TIdHTTPWebsocketClient; Host: String;
Port: Integer; WSResourceName: String): String;

begin
  // client := TIdHTTPWebsocketClient.Create(nil);
  client.Port := Port;
  client.Host := Host;
  client.WSResourceName := WSResourceName;
  if (client.CheckConnection) then
    try
      client.Disconnect();
      client.Connect;
      Result := 'Client connecté';
    Except
      Result := 'Connection echoué';
    end
  else
    try
      client.WSResourceName := 'logbook';
      client.UpgradeToWebsocket;
      Result := 'Client connecté';
    Except
      Result := 'Connection echoué';
    end;
end;

// function GetValue(const aData: String; Key: String): String;
// var
// JSON: ISuperObject;
// rowItem: ISuperObject;
// ADataStringStream: TStringStream;
// begin
// ADataStringStream := TStringStream.Create(aData);
// JSON := TSuperObject.ParseStream(ADataStringStream, False);
//
// Result := JSON.AsString;
//
// end;

end.
