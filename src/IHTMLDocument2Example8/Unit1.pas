unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, MsHTML, ExtCtrls;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    procedure FormShow(Sender: TObject);
    procedure WebBrowser1DocumentComplete(ASender: TObject;
      const pDisp: IDispatch; var URL: OleVariant);
    procedure WebBrowser1TitleChange(ASender: TObject; const Text: WideString);
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
  URL := Copy(application.Exename, 0, Pos('IHTMLDocument2Example8\', application.Exename) + 22) + 'testPage.html';
  WebBrowser1.Navigate(URL);
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  vDoc: IHTMLDocument2;
  //vEle: IHTMLElement;
  sJs: String;
begin
  vDoc := WebBrowser1.Document as IHTMLDocument2;
  //vEle := vDoc.body;
  //setAttribute的方法对于事件是无效的。
  //vEle.setAttribute('onload','Sakuras();alert("Sakuras")', 0);
  //但是getAttribute方法仍然可以把这个值取出来。
  //ShowMessage(vEle.getAttribute('onload', 0));
  sJs := 'document.body.onload = function(){Sakuras();document.title="Sakuras";};';
  //此外，下面这种方法也OK。
  //sJs := 'document.body.onload = new Function("Sakuras();document.title=\"Sakuras\";");';
  vDoc.parentWindow.execscript(sJs, 'javascript');
end;

procedure TForm1.WebBrowser1TitleChange(ASender: TObject;
  const Text: WideString);
var
  vDoc: IHTMLDocument2;
  vCol: IHTMLElementCollection;
  vEle: IHTMLElement;
begin
  if Text = 'Sakuras' then
  begin
    vDoc := WebBrowser1.Document as IHTMLDocument2;
    vCol := vDoc.all.tags('td') as IHTMLElementCollection;
    vEle := vCol.item(19, 0) as IHTMLElement;
    vEle.setAttribute('innerText', '225', 0);
  end;
end;

end.
