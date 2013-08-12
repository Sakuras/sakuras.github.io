unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, MsHTML;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var
  URL: String;
begin
  URL := Copy(application.Exename, 0, Pos('IHTMLDocument2Example6\', application.Exename) + 22) + 'testPage.html';
  WebBrowser1.Navigate(URL);
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  vWeb: IWebBrowser;
  vDoc: IHTMLDocument2;
  vCol: IHTMLElementCollection;
  vEle: IHTMLElement;
  i: integer;
begin
  vDoc := WebBrowser1.Document as IHTMLDocument2;
  vWeb := vDoc.all.item('testFrame', 0) as IWebBrowser;  //iframe
  vDoc := vWeb.Document as IHTMLDocument2;
  vCol := vDoc.all.tags('tr') as IHTMLElementCollection;
  for i := 0 to vCol.length - 1 do
  begin
    vEle := vCol.item(i, 0) as IHTMLElement;
    if pos('kisaragi Sakuras', vEle.getAttribute('innerText', 0)) > 0 then
    begin
      Break;
    end;
  end;
  vCol := vEle.children as IHTMLElementCollection;
  vEle := vCol.item(2, 0) as IHTMLElement;  //×îÏ²»¶µÄÈËtd
  vEle.setAttribute('innerText', 'Railgun', 0);
end;

end.
