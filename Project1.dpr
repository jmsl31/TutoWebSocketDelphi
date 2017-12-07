program Project1;

uses
  System.StartUpCopy,
  FMX.Forms,
  TutoWebSocket in 'TutoWebSocket.pas' {Form1},
  IdIOHandlerWebsocket in 'IdIOHandlerWebsocket.pas',
  IdServerBaseHandling in 'IdServerBaseHandling.pas',
  IdServerIOHandlerWebsocket in 'IdServerIOHandlerWebsocket.pas',
  IdServerSocketIOHandling in 'IdServerSocketIOHandling.pas',
  IdServerWebsocketContext in 'IdServerWebsocketContext.pas',
  IdServerWebsocketHandling in 'IdServerWebsocketHandling.pas',
  IdSocketIOHandling in 'IdSocketIOHandling.pas',
  IdWebsocketServer in 'IdWebsocketServer.pas',
  IdHTTPWebsocketClient in 'IdHTTPWebsocketClient.pas',
  supertimezone in '..\TutoRestClient\supertimezone.pas',
  supertypes in '..\TutoRestClient\supertypes.pas',
  superxmlparser in '..\TutoRestClient\superxmlparser.pas',
  superdate in '..\TutoRestClient\superdate.pas',
  superobject in '..\TutoRestClient\superobject.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
