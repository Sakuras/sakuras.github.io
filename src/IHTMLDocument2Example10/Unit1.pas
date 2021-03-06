unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, MsHTML, HtmlEvent;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    Label1: TLabel;
    ComboBox1: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    HTMLButtonClickHook: TDHtmlEvent;
    procedure HTMLButtonClickHookEvt(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  HTMLButtonClickHook := TDHtmlEvent.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if HTMLButtonClickHook <> nil then HTMLButtonClickHook.Free;
end;

procedure TForm1.FormShow(Sender: TObject);
var
  URL, path: String;
begin
  path := application.Exename;
  URL := Copy(path, 0, Pos('IHTMLDocument2Example10\', path) + 23) + 'testPage.html';
  WebBrowser1.Navigate(URL);
end;

procedure TForm1.HTMLButtonClickHookEvt(Sender: TObject);
var
  vDoc: IHTMLDocument2;
  vEle: IHTMLElement;
  i: Integer;
begin
  vDoc := WebBrowser1.Document as IHTMLDocument2;
  if ComBoBox1.itemIndex = 3 then
  begin
    vDoc.parentWindow.execscript('Sakuras();', 'javascript');
    Exit;
  end;
  for i := 0 to 2 do
  begin
    vEle := vDoc.all.item('character', i) as IHTMLElement;
    if pos('checked', LowerCase(vEle.outerHTML)) > 0 then
    begin
      if i = ComboBox1.itemIndex then
      begin
        vDoc.parentWindow.execscript('Sakuras();', 'javascript');
        Exit;
      end;
      Break;
    end;
  end;
  ShowMessage('不许你投她的票！');
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  vDoc: IHTMLDocument2;
  vEle: IHTMLElement;
begin
  vDoc := WebBrowser1.Document as IHTMLDocument2;
  vEle := vDoc.all.item('Sakuras', 0) as IHTMLElement;
  vEle.onclick := HTMLButtonClickHook.HookEventHandler(HTMLButtonClickHookEvt);
end;

end.
