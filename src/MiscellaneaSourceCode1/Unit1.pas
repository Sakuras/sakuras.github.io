unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, OleCtrls, SHDocVw, MsHTML, StdCtrls;

type
  TForm1 = class(TForm)
    WebBrowser1: TWebBrowser;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    iThreadID: Integer;
    bShowHTMLCode: Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  hHook: Integer;

implementation

{$R *.dfm}

function HookProc(nCode: Integer; wParam: WPARAM; lParam: LPARAM): LRESULT; stdcall;
var
  vDoc: IHtmlDocument2;
  vEle: IHtmlElement;
  pX: Integer;
  pY: Integer;
begin
  if Form1.Handle <> Getforegroundwindow then
  begin
    Result := CallNextHookEx(hHook, nCode, wParam, lParam);
    Exit;
  end;
  if nCode = HC_Action then
  begin
    if wParam = WM_LBUTTONDOWN then
    begin
      pX := PMouseHookStruct(lParam)^.pt.X;
      pY := PMouseHookStruct(lParam)^.pt.Y;
      pX := pX - Form1.Left - 8;//��߿��8px
      pY := pY - Form1.Top - Form1.WebBrowser1.Top - 30;//�ϱ߿��30px;
      Form1.Label1.Caption := '����������������������ؼ���λ��Ϊ��X = '
                            + IntToStr(pX) + '; Y = ' + IntToStr(pY);
      //�ж���WebBrowser��Χ�ھ�����ʧЧ��
      if ((pX > 0) and (pX < Form1.WebBrowser1.Width)) and
         ((pY > 0) and (pY < Form1.WebBrowser1.Height)) then
      begin
        Result := 1;
        if Form1.bShowHTMLCode then
        begin
          vDoc := Form1.WebBrowser1.Document as IHTMLDocument2;
          vEle := vDoc.ElementFromPoint(pX, pY) as IHTMLElement;
          ShowMessage(vEle.outerHTML);
        end;
        Exit;
      end;
    end;
  end;
  Result := CallNextHookEx(hHook, nCode, wParam, lParam)
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if hHook <> 0 then
  begin
    //�˳�ʱ�ͷŹ���
    unhookWindowsHookEx(hHook);
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  iThreadID := GetCurrentThreadId;
  WebBrowser1.Navigate('www.baidu.com');
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if SpeedButton1.Down then
  begin
    ShowMessage('�������Hook');
    SpeedButton1.Caption := '������������';
    hHook := SetWindowsHookEx(WH_MOUSE, HookProc, 0, iThreadID);
  end
  else begin
    ShowMessage('�ͷ����Hook');
    SpeedButton1.Caption := '������������';
    SpeedButton2.Down := False;
    unhookWindowsHookEx(hHook);
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if not SpeedButton1.Down then
  begin
    ShowMessage('��Ҫ���������Hook������ɴ˹��ܡ�');
    SpeedButton2.Down := False;
    Exit;
  end;
  if SpeedButton2.Down then
  begin
    ShowMessage('չʾ�������ҳ��Ԫ��Դ��');
    SpeedButton2.Caption := 'Ԫ��Դ��չʾ��';
    bShowHTMLCode := True;
  end
  else begin
    ShowMessage('��չʾ�������ҳ��Ԫ��Դ��');
    SpeedButton2.Caption := 'Ԫ��Դ�벻չʾ';
    bShowHTMLCode := False;
  end;
end;

end.