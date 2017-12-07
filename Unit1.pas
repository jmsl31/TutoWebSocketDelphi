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
    LabelConnect: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
  end;

var
  Form1: TForm1;
  client: TIdHTTPWebsocketClient;

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
  client := TIdHTTPWebsocketClient.Create(nil);
  client.Port := 55985;
  client.Host := 'localhost';
  if (client.Connected) then
  begin

    try
      client.Disconnect();
      client.Connect;
      LabelConnect.Caption := 'Client connect�';
    finally
      LabelConnect.Caption := 'Connection echou�';
    end;

  end
  else
     try
      client.Connect;
      LabelConnect.Caption := 'Client connect�';
    finally
      LabelConnect.Caption := 'Connection echou�';
    end;

end;

function GetValue(const AData: String; Key: String): String;
var
  JSON: ISuperObject;
  rowItem: ISuperObject;
  ADataStringStream: TStringStream;
begin
  ADataStringStream := TStringStream.Create(AData);
  JSON := TSuperObject.ParseStream(ADataStringStream, False);

  Result := JSON.AsString;

end;

end.
