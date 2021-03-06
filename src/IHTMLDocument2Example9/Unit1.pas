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
  URL := Copy(application.Exename, 0, Pos('IHTMLDocument2Example9\', application.Exename) + 22) + 'testPage.html';
  WebBrowser1.Navigate(URL);
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  vDoc: IHTMLDocument2;
begin
  WebBrowser1.OleObject.document.Script.iIncrement := 10;
  //当然，直接用js修改全局变量也是ok的。
  //vDoc := WebBrowser1.Document as IHTMLDocument2;
  //vDoc.parentWindow.execscript('document.Script.iIncrement = 10;', 'javascript');
end;

end.
