unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, MsHTML;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

procedure TForm1.Button1Click(Sender: TObject);
var
  vDoc: IHTMLDocument2;
begin
  vDoc := WebBrowser1.Document as IHTMLDocument2;
  vDoc.title := 'Sakuras一下，你就知道';
  ShowMessage(vDoc.title);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  WebBrowser1.Navigate('www.baidu.com');
end;

procedure TForm1.WebBrowser1DocumentComplete(ASender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  vDoc: IHTMLDocument2;
  vEle: IHTMLElement;
begin
  vDoc := WebBrowser1.Document as IHTMLDocument2;
  vEle := vDoc.all.item('su', 0) as IHTMLElement;
  vEle.setAttribute('value', 'Sakuras一下', 0);
end;

end.
