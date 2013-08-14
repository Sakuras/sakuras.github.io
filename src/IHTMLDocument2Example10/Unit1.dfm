object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 408
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 144
    Height = 19
    Caption = #25105#21916#27426#30340#21160#28459#35282#33394#65306
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 40
    Width = 623
    Height = 368
    Anchors = [akLeft, akTop, akRight, akBottom]
    Align = alBottom
    TabOrder = 0
    OnDocumentComplete = WebBrowser1DocumentComplete
    ControlData = {
      4C00000064400000092600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object ComboBox1: TComboBox
    Left = 158
    Top = 5
    Width = 145
    Height = 27
    ItemIndex = 3
    TabOrder = 1
    Text = #20840#21729#22823#22909#12365
    Items.Strings = (
      #24481#22338#32654#29748
      #32080#22478#12450#12473#12490
      #20013#37326#26771
      #20840#21729#22823#22909#12365)
  end
end
