unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OleCtrls, SHDocVw, MsHTML, ActiveX;

type
  TObjectFromLResult = function(LRESULT: lResult; const IID: TIID;
    WPARAM: wParam; out pObject): HRESULT; stdcall;

  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    Button1: TButton;
    Button2: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function GetDocInterface(hwnd: THandle): IHtmlDocument2;
var
  hInst: THandle;
  hr: HResult;
  lRes: Cardinal;
  MSG: Integer;
  vDoc: IHTMLDocument2;
  ObjectFromLresult: TObjectFromLresult;
begin
  hInst := LoadLibrary('Oleacc.dll');
  if hInst = 0 then Exit;
  @ObjectFromLresult := GetProcAddress(hInst, 'ObjectFromLresult');
  if @ObjectFromLresult <> nil then
  begin
    try
      MSG := RegisterWindowMessage('WM_HTML_GETOBJECT');
      SendMessageTimeOut(Hwnd, MSG, 0, 0, SMTO_ABORTIFHUNG, 10000, lRes);
      hr := ObjectFromLresult(lRes, IID_IHTMLDocument2, 0, vDoc);
      if SUCCEEDED(hr) then
      begin
        Result := vDoc;
      end;
    finally
      FreeLibrary(hInst);
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  h: HWND;
  vDoc: IHTMLDocument2;
begin
  //һ��IE��showModalDialog����ϡ���ҳ�Ի��������ı�ʶ
  h := FindWindow(nil, 'rika -- ��ҳ�Ի���');
  if h = 0 then
  begin
    ShowMessage('δ��⵽����������ҳ���ϵİ�ť���´��ں����ԡ�');
    Exit;
  end;
  //��ȡ�����Ӵ��ڣ��������������ҳ�DOM�ľ��
  h := GetWindow(h, GW_CHILD);
  vDoc := GetDocInterface(h);
  ShowMessage(vDoc.body.outerHTML);
end;

procedure TForm1.FormShow(Sender: TObject);
var
  URL: String;
begin
  URL := Copy(application.Exename, 0, Pos('MiscellaneaSourceCode3\', application.Exename) + 22) + 'testPage.html';
  WebBrowser1.Navigate(URL);
end;

end.