unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, OleCtrls, SHDocVw_EWB, EwbCore;

type
  TMyPanel = class(TPanel)
  private
    procedure WmNCHitTest(var Msg : TWMNCHitTest); message WM_NCHITTEST;
  end;

  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    MyPanel1: TMypanel;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ MyPanel }

procedure TMyPanel.WmNCHitTest(var Msg: TWMNCHitTest);
var
  p: TPoint;
begin
  inherited;
  p := Point(Msg.XPos,Msg.YPos);
  p := ScreenToClient(p);
  if PtInRect(rect(0,0,Width, 50), p) then
  begin
    msg.Result := HTCaption;
  end;
end;

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  MyPanel1 := TMypanel.Create(Self);
  MyPanel1.Parent := Self;
  MyPanel1.SetBounds(0,0,300,200);
  MyPanel1.Anchors := [akTop, akRight];
  MyPanel1.Caption := 'À´ÍÏ¶¯ÎÒ°¡¡£';
  MyPanel1.BorderStyle := bsSingle;
  MyPanel1.BorderWidth := 10;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  MyPanel1.Free;
end;

end.
