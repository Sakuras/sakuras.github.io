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
  URL := Copy(application.Exename, 0, Pos('IHTMLDocument2Example5\', application.Exename) + 22) + 'testPage.html';
  WebBrowser1.Navigate(URL);
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  vDoc: IHTMLDocument2;
  vCol: IHTMLElementCollection;
  vEle: IHTMLElement;
  i: integer;
begin
  vDoc := WebBrowser1.Document as IHTMLDocument2;
  vCol := vDoc.all.tags('td') as IHTMLElementCollection;
  for i := 0 to vCol.length - 1 do
  begin
    vEle := vCol.item(i, 0) as IHTMLElement;
    if vEle.getAttribute('innerText', 0) = 'kisaragi Sakuras' then
    begin
      Break;
    end;
  end;
  vEle := vEle.parentElement;  //tr
  vCol := vEle.children as IHTMLElementCollection;
  vEle := vCol.item(3, 0) as IHTMLElement;  //���td
  vEle.setAttribute('innerText', '255', 0);
end;

end.
