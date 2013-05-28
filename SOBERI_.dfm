object Form1: TForm1
  Left = 239
  Top = 185
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1055#1072#1079#1083
  ClientHeight = 234
  ClientWidth = 255
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 48
    Top = 48
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object N2: TMenuItem
        Caption = #1053#1086#1074#1072' '#1075#1088#1072
        OnClick = N2Click
      end
      object N4: TMenuItem
        Caption = #1042#1080#1093#1110#1076
        OnClick = N4Click
      end
    end
    object N3: TMenuItem
      Caption = #1047#1072#1074#1076#1072#1085#1085#1103
      OnClick = N3Click
    end
    object N5: TMenuItem
      Caption = #1055#1110#1076#1089#1082#1072#1079#1082#1072
      OnClick = N5Click
    end
  end
end
