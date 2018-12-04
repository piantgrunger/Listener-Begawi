object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Listener'
  ClientHeight = 408
  ClientWidth = 698
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 8
    Width = 29
    Height = 13
    Caption = 'Token'
  end
  object Button1: TButton
    Left = 74
    Top = 32
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 74
    Top = 5
    Width = 407
    Height = 21
    TabOrder = 1
  end
  object CZKEM1: TCZKEM
    Left = 352
    Top = 71
    Width = 33
    Height = 33
    TabOrder = 2
    ControlData = {000900006903000069030000}
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 63
    Width = 225
    Height = 289
    Caption = 'Daftar IP Mesin'
    TabOrder = 3
    object MM_IP_masuk: TMemo
      Left = 8
      Top = 16
      Width = 209
      Height = 265
      TabOrder = 0
    end
  end
  object Status: TGroupBox
    Left = 256
    Top = 63
    Width = 313
    Height = 289
    Caption = 'Status'
    TabOrder = 4
    object lb_stat: TListBox
      Left = 8
      Top = 21
      Width = 300
      Height = 265
      Color = clBackground
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      TabOrder = 0
    end
  end
  object Button2: TButton
    Left = 24
    Top = 359
    Width = 75
    Height = 25
    Caption = 'Connect'
    Enabled = False
    TabOrder = 5
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 112
    Top = 359
    Width = 75
    Height = 25
    Caption = '&Disconnect'
    Enabled = False
    TabOrder = 6
    OnClick = Button3Click
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 248
    Top = 144
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    OnClick = TrayIcon1Click
    Left = 616
    Top = 144
  end
  object PopupMenu1: TPopupMenu
    Left = 344
    Top = 208
    object Close1: TMenuItem
      Caption = 'Close'
      OnClick = Close1Click
    end
    object Maximize1: TMenuItem
      Caption = 'Maximize'
      OnClick = Maximize1Click
    end
  end
end
