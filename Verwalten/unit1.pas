unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ZConnection, ZDataset, ZAbstractRODataset, Eingabe, Printers, System.UITypes, DB;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit10: TEdit;
    Edit3: TEdit;
    Edit9: TEdit;
    Edit5: TEdit;
    Edit4: TEdit;
    Edit7: TEdit;
    Edit6: TEdit;
    Edit8: TEdit;
    Label1: TLabel;
    Label15: TLabel;
    Label11: TLabel;
    Label20: TLabel;
    Label13: TLabel;
    Label29: TLabel;
    Label10: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label12: TLabel;
    Label30: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label14: TLabel;
    Label21: TLabel;
    Label5: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label28: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZQuery3: TZQuery;
    ZTransaction1: TZTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit10KeyPress(Sender: TObject; var Key: char);
    procedure Edit10KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit11KeyPress(Sender: TObject; var Key: char);
    procedure Edit11KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit12KeyPress(Sender: TObject; var Key: char);
    procedure Edit12KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit13KeyPress(Sender: TObject; var Key: char);
    procedure Edit13KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit14KeyPress(Sender: TObject; var Key: char);
    procedure Edit14KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit15KeyPress(Sender: TObject; var Key: char);
    procedure Edit15KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit16KeyPress(Sender: TObject; var Key: char);
    procedure Edit16KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit2KeyPress(Sender: TObject; var Key: char);
    procedure Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit3KeyPress(Sender: TObject; var Key: char);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit4KeyPress(Sender: TObject; var Key: char);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit5KeyPress(Sender: TObject; var Key: char);
    procedure Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit6KeyPress(Sender: TObject; var Key: char);
    procedure Edit6KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit7KeyPress(Sender: TObject; var Key: char);
    procedure Edit7KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit8KeyPress(Sender: TObject; var Key: char);
    procedure Edit8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Edit9KeyPress(Sender: TObject; var Key: char);
    procedure Edit9KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure ZConnection1AfterConnect(Sender: TObject);
  private
    procedure Blankwegh;
    procedure Blankwegv;
    procedure Laden;
    procedure Nummer;
    procedure Hexum;
    procedure Privflug;
    procedure BLoe;
    procedure Kopf1;
    procedure Druck1;
    procedure Kopf2;
    procedure Druck2;
    procedure Kopf3;
    procedure Druck3;
    procedure Kopf4;
    procedure Druck4;
    procedure maxlen;
  public
  end;

var
  Form1: TForm1;
  JaNein: word;
  Closestat: integer;
  abbruch: Boolean;
  mtasts: integer;
  mlauf: integer;
  mver: integer;
  mart: integer;
  Tag: integer;
  Monat: integer;
  Jahr: integer;
  BUser: string;
  anzrec: Integer;
  sdate1: Char;
  sdate2: String;
  vwaehrs: string;
  vtaus: Char;
  vdezim: Char;
  vwaehrz: Byte;
  FSatz: string;
  sta: integer;
  sperr: integer;
  DateSeparator: Char deprecated 'Use FormatSettings.DateSeparator';
  ShortDateFormat: string deprecated 'Use FormatSettings.ShortDateFormat';
  CurrencyString: string deprecated 'Use FormatSettings.CurrencyString';
  ThousandSeparator: Char deprecated 'Use FormatSettings.ThousandSeparator';
  DecimalSeparator: Char deprecated 'Use FormatSettings.DecimalSeparator';
  CurrencyDecimals: Byte deprecated 'Use FormatSettings.CurrencyDecimals';
  vers: string;
  dcon: integer;
  SqlRet: Boolean;
  z: integer;
  egrid: integer;
  sort: string;
  dart: string;
  ehex: string;
  evzeit: TDateTime;
  ebzeit: TDateTime;
  eflight: string;
  evalt: integer;
  ebalt: integer;
  evspeed: integer;
  ebspeed: integer;
  evhead: integer;
  ebhead: integer;
  evlat: double;
  eblat: double;
  evlong: double;
  eblong: double;
  eanz: integer;
  eflugg: string;
  eland: string;
  erufz: string;
  eiata: string;
  eicao: string;
  evhex: string;
  ebhex: string;
  eabf: string;
  ezif: string;
  ahex: string;
  avzeit: TDateTime;
  abzeit: TDateTime;
  aflight: string;
  avalt: integer;
  abalt: integer;
  avspeed: integer;
  abspeed: integer;
  avhead: integer;
  abhead: integer;
  avlat: double;
  ablat: double;
  avlong: double;
  ablong: double;
  aanz: integer;
  aflugg: string;
  aland: string;
  arufz: string;
  aiata: string;
  aicao: string;
  avhex: string;
  abhex: string;
  aabf: string;
  azif: string;
  drucker: string;
  druckn: integer;
  px: integer;
  py: integer;
  vpx: integer;
  vpy: integer;
  format: TPrinterOrientation;
  eseite: integer;
  ezeile: integer;
  averf: string;
  everf: string;
  herrmsg: string;
  feldalt: string;
  feldneu: string;

implementation

{$R *.lfm}

procedure TForm1.Druck1;
  var h1: string;
  var h2: string;
  var h3: string;
  var h4: string;
  var h5: string;
  var h6: string;
  var h7: string;
  var h8: string;
  var h9: string;
  var ha: string;
  var hb: string;
  var hc: string;
  var hd: string;
  var he: string;
  var hf: string;
  var hg: string;
  var d1: string;
  var d2: TDateTime;
  var d3: TDateTime;
  var d4: string;
  var d5: integer;
  var d6: integer;
  var d7: integer;
  var d8: integer;
  var d9: integer;
  var da: integer;
  var db: double;
  var dc: double;
  var dd: double;
  var de: double;
  var df: integer;
  var dg: string;
  var dh: string;
  var di: string;
  var dj: string;
begin
  Screen.Cursor:=crHourGlass;
  Form1.Cursor:=crHourGlass;
  Form1.Refresh;
  Printers.Printer.PrinterIndex:=druckn;
  format:=poLandscape;
  Printers.Printer.Canvas.Font.Charset:=0;
  Printers.Printer.Canvas.Font.Name:='Courier';
  Printers.Printer.Canvas.Font.Style:=[];
  Printers.Printer.Canvas.Font.Size:=8;
  vpy:=68;
  Printers.Printer.Canvas.Font.Pitch:=fpFixed;
  Printers.Printer.Canvas.Font.Color:=clBlack;
  Printers.Printer.Copies:=1;
  Printers.Printer.Orientation:=format;
  vpx:=56;
  px:=vpx+vpx;
  py:=vpy;
  Printers.Printer.BeginDoc;
    Kopf1;
    Form1.ZQuery1.SQL.Text:='SELECT * FROM flight';
    if sort = 'Hex-ID' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY hexid';
    if sort = 'Datum und Zeit' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vonzeit';
    if sort = 'Flight' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY flight';
    if sort = 'Alt' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY valt';
    if sort = 'Speed' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vspeed';
    if sort = 'Heading' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vheading';
    if sort = 'Lat' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vlat';
    if sort = 'Long' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vlong';
    if sort = 'Anzahl Daten' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY anz';
    if sort = 'Flugverfolgung' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY verfolgung';
    if sort = 'Abflughafen' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY von';
    if sort = 'Zielflughafen' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY nach';
    Form1.ZQuery1.Open;
    while not Form1.ZQuery1.EOF do
    begin
      d1:=Form1.ZQuery1.Fields[0].AsString;
      d2:=Form1.ZQuery1.Fields[1].AsDateTime;
      d3:=Form1.ZQuery1.Fields[2].AsDateTime;
      d4:=Form1.ZQuery1.Fields[3].AsString;
      d5:=Form1.ZQuery1.Fields[4].AsInteger;
      d6:=Form1.ZQuery1.Fields[5].AsInteger;
      d7:=Form1.ZQuery1.Fields[6].AsInteger;
      d8:=Form1.ZQuery1.Fields[7].AsInteger;
      d9:=Form1.ZQuery1.Fields[8].AsInteger;
      da:=Form1.ZQuery1.Fields[9].AsInteger;
      db:=Form1.ZQuery1.Fields[10].AsFloat;
      dc:=Form1.ZQuery1.Fields[11].AsFloat;
      dd:=Form1.ZQuery1.Fields[12].AsFloat;
      de:=Form1.ZQuery1.Fields[13].AsFloat;
      df:=Form1.ZQuery1.Fields[14].AsInteger;
      dg:=Form1.ZQuery1.Fields[15].AsString;
      di:=Form1.ZQuery1.Fields[16].AsString;
      dj:=Form1.ZQuery1.Fields[17].AsString;
      ialpha:=d1;
      inummer:=6;
      iart:=1;
      Form1.maxlen;
      h1:=ialpha;
      h2:=DateTimeToStr(d2);
      h3:=DateTimeToStr(d3);
      ialpha:=d4;
      inummer:=8;
      iart:=1;
      Form1.maxlen;
      h4:=ialpha;
      ialpha:=IntToStr(Round(d5*0.3));
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      h5:=ialpha;
      ialpha:=IntToStr(Round(d6*0.3));
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      h6:=ialpha;
      ialpha:=IntToStr(Round(d7*1.852));
      inummer:=4;
      iart:=2;
      Form1.maxlen;
      h7:=ialpha;
      ialpha:=IntToStr(Round(d8*1.852));
      inummer:=4;
      iart:=2;
      Form1.maxlen;
      h8:=ialpha;
      ialpha:=IntToStr(d9);
      inummer:=4;
      iart:=2;
      Form1.maxlen;
      h9:=ialpha;
      ialpha:=IntToStr(da);
      inummer:=4;
      iart:=2;
      Form1.maxlen;
      ha:=ialpha;
      ialpha:=FloatToStrF(db,ffFixed,6,3);
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      hb:=ialpha;
      ialpha:=FloatToStrF(dc,ffFixed,6,3);
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      hc:=ialpha;
      ialpha:=FloatToStrF(dd,ffFixed,6,3);
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      hd:=ialpha;
      ialpha:=FloatToStrF(de,ffFixed,6,3);
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      he:=ialpha;
      ialpha:=IntToStr(df);
      inummer:=4;
      iart:=2;
      Form1.maxlen;
      hf:=ialpha;
      dh:='Nein';
      if dg = 'J' then dh:='Ja';
      if ezeile > 67 then Kopf1;
      ezeile:=ezeile+1;
      Printers.Printer.Canvas.TextOut(px, py, h1+' '+h2+' '+h3+' '+h4+' '+h5+' '+h6+'    '+h7+'      '+h8+'       '+h9+'        '+ha+'     '+hb+'   '+hc+'  '+hd+'   '+he+'    '+hf+'      '+dh);
      py:=py+vpy;
      ialpha:='';
      inummer:=56;
      iart:=1;
      Form1.maxlen;
      hd:=ialpha;
      ialpha:=di;
      inummer:=50;
      iart:=1;
      Form1.maxlen;
      he:=ialpha;
      ialpha:=dj;
      inummer:=50;
      iart:=1;
      Form1.maxlen;
      hf:=ialpha;
      if ezeile > 67 then Kopf1;
      ezeile:=ezeile+1;
      Printers.Printer.Canvas.TextOut(px, py, hd+he+' '+hf);
      py:=py+vpy;
      Form1.ZQuery1.Next;
    end;
    Form1.ZQuery1.Close;
// Hex-ID      von Datum/Zeit      bis Datum/Zeit Flight  von Alt bis Alt von Speed bis Speed von Heading bis Heading von Lat von long bis Lat bis Long Anz Daten Flugverf.
// 123456 12.12.1234 12:12:12 12.12.1234 12:12:12 12345678 123456 123456    1234      1234       1234        1234     12,123   12,123  12,123   12,123    1234      Nein
//                                                                      1234    123456    1234567    12345678    12345      123      12      123      1234    123456
// Hex-ID      von Datum/Zeit      bis Datum/Zeit Flight  von Alt bis Alt von Speed bis Speed von Heading bis Heading von Lat von long bis Lat bis Long Anz Daten Flugverf.
//                                                         Abflughafen                                        Zielflughafen
//                                                         123456789.123456789.123456789.123456789.123456789. 123456789.123456789.123456789.123456789.123456789.
// 123456789.123456789.123456789.123456789.123456789.123456
 Printers.Printer.EndDoc;
 Screen.Cursor:=crDefault;
 Form1.Cursor:=crDefault;
 Form1.Refresh;
end;
// Portrait = 99   Zeilen a 117 Zeichen
// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
//          1         2         3         4         5         6         7         8         9        10        11
// Landscape = 68   Zeilen a 168 Zeichen
// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
//          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16
procedure TForm1.Kopf1;
begin
  if eseite > 0 then
  begin
    Printers.Printer.NewPage;
  end;
  eseite:=eseite+1;
  ezeile:=0;
  py:=vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, 'Hex-ID      von Datum/Zeit      bis Datum/Zeit Flight  von Alt bis Alt von Speed bis Speed von Heading bis Heading von Lat von long bis Lat bis Long Anz Daten Flugverf.');
  py:=py+vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, '                                                        Abflughafen                                        Zielflughafen');
  py:=py+vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, '========================================================================================================================================================================');
  py:=py+vpy;
end;

procedure TForm1.Druck2;
  var h1: string;
  var h2: string;
  var h3: string;
  var h4: string;
  var h5: string;
  var d1: string;
  var d2: string;
  var d3: string;
  var d4: string;
  var d5: string;
begin
  Screen.Cursor:=crHourGlass;
  Form1.Cursor:=crHourGlass;
  Form1.Refresh;
  Printers.Printer.PrinterIndex:=druckn;
  format:=poLandscape;
  Printers.Printer.Canvas.Font.Charset:=0;
  Printers.Printer.Canvas.Font.Name:='Courier';
  Printers.Printer.Canvas.Font.Style:=[];
  Printers.Printer.Canvas.Font.Size:=8;
  vpy:=68;
  Printers.Printer.Canvas.Font.Pitch:=fpFixed;
  Printers.Printer.Canvas.Font.Color:=clBlack;
  Printers.Printer.Copies:=1;
  Printers.Printer.Orientation:=format;
  vpx:=56;
  px:=vpx+vpx;
  py:=vpy;
  Printers.Printer.BeginDoc;
    Kopf2;
    Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub';
    if sort = 'ICAO' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub ORDER BY icao';
    if sort = 'Fluggesellschaft' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub ORDER BY name';
    if sort = 'Land' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub ORDER BY land';
    Form1.ZQuery1.Open;
    while not Form1.ZQuery1.EOF do
    begin
      d1:=Form1.ZQuery1.Fields[0].AsString;
      d2:=Form1.ZQuery1.Fields[1].AsString;
      d3:=Form1.ZQuery1.Fields[2].AsString;
      d4:=Form1.ZQuery1.Fields[3].AsString;
      d5:=Form1.ZQuery1.Fields[4].AsString;
      ialpha:=d1;
      inummer:=60;
      iart:=1;
      Form1.maxlen;
      h1:=ialpha;
      ialpha:=d5;
      inummer:=40;
      iart:=1;
      Form1.maxlen;
      h2:=ialpha;
      ialpha:=d3;
      inummer:=3;
      iart:=1;
      Form1.maxlen;
      h3:=ialpha;
      ialpha:=d2;
      inummer:=3;
      iart:=1;
      Form1.maxlen;
      h4:=ialpha;
      ialpha:=d4;
      inummer:=56;
      iart:=1;
      Form1.maxlen;
      h5:=ialpha;
      if ezeile > 67 then Kopf2;
      ezeile:=ezeile+1;
      Printers.Printer.Canvas.TextOut(px, py, h1+' '+h2+' '+h3+'  '+h4+'  '+h5);
      py:=py+vpy;
      Form1.ZQuery1.Next;
    end;
    Form1.ZQuery1.Close;
// Fluggesellschaft                                             Land                                     ICAO IATA Rufzeichen
// 123456789012345678901234567890123456789012345678901234567890 1234567890123456789012345678901234567890 123  123  12345678901234567890123456789012345678901234567890123456
 Printers.Printer.EndDoc;
 Screen.Cursor:=crDefault;
 Form1.Cursor:=crDefault;
 Form1.Refresh;
end;

procedure TForm1.Kopf2;
begin
  if eseite > 0 then
  begin
    Printers.Printer.NewPage;
  end;
  eseite:=eseite+1;
  ezeile:=0;
  py:=vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, 'Fluggesellschaft                                             Land                                     ICAO IATA Rufzeichen');
  py:=py+vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, '========================================================================================================================================================================');
  py:=py+vpy;
end;

procedure TForm1.Druck3;
  var h1: string;
  var h2: string;
  var h3: string;
  var d1: string;
  var d2: string;
  var d3: string;
begin
  Screen.Cursor:=crHourGlass;
  Form1.Cursor:=crHourGlass;
  Form1.Refresh;
  Printers.Printer.PrinterIndex:=druckn;
  format:=poPortrait;
  Printers.Printer.Canvas.Font.Charset:=0;
  Printers.Printer.Canvas.Font.Name:='Courier';
  Printers.Printer.Canvas.Font.Style:=[];
  Printers.Printer.Canvas.Font.Size:=8;
  vpy:=68;
  Printers.Printer.Canvas.Font.Pitch:=fpFixed;
  Printers.Printer.Canvas.Font.Color:=clBlack;
  Printers.Printer.Copies:=1;
  Printers.Printer.Orientation:=format;
  vpx:=56;
  px:=vpx+vpx;
  py:=vpy;
  Printers.Printer.BeginDoc;
    Kopf3;
    Form1.ZQuery1.SQL.Text:='SELECT * FROM icao';
    if sort = 'von Hex-ID' then Form1.ZQuery1.SQL.Text:='SELECT * FROM icao ORDER BY von';
    if sort = 'Land' then Form1.ZQuery1.SQL.Text:='SELECT * FROM icao ORDER BY land';
    Form1.ZQuery1.Open;
    while not Form1.ZQuery1.EOF do
    begin
      d1:=Form1.ZQuery1.Fields[0].AsString;
      d2:=Form1.ZQuery1.Fields[1].AsString;
      d3:=Form1.ZQuery1.Fields[2].AsString;
      ialpha:=d1;
      inummer:=6;
      iart:=1;
      Form1.maxlen;
      h1:=ialpha;
      ialpha:=d2;
      inummer:=6;
      iart:=1;
      Form1.maxlen;
      h2:=ialpha;
      ialpha:=d3;
      inummer:=40;
      iart:=1;
      Form1.maxlen;
      h3:=ialpha;
      if ezeile > 98 then Kopf3;
      ezeile:=ezeile+1;
      Printers.Printer.Canvas.TextOut(px, py, h1+'     '+h2+'     '+h3);
      py:=py+vpy;
      Form1.ZQuery1.Next;
// von Hex-ID bis Hex-ID Land
// 123456     123456     1234567890123456789012345678901234567890
    end;
    Form1.ZQuery1.Close;
 Printers.Printer.EndDoc;
 Screen.Cursor:=crDefault;
 Form1.Cursor:=crDefault;
 Form1.Refresh;
end;

procedure TForm1.Kopf3;
begin
  if eseite > 0 then
  begin
    Printers.Printer.NewPage;
  end;
  eseite:=eseite+1;
  ezeile:=0;
  py:=vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, 'von Hex-ID bis Hex-ID Land');
  py:=py+vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, '==============================================================');
  py:=py+vpy;
end;

procedure TForm1.Druck4;
  var h1: string;
  var h2: string;
  var h3: string;
  var h4: string;
  var h5: string;
  var h6: string;
  var h7: string;
  var h8: string;
  var h9: string;
  var ha: string;
  var hb: string;
  var hc: string;
  var hd: string;
  var he: string;
  var hf: string;
  var hg: string;
  var d1: string;
  var d2: TDateTime;
  var d3: TDateTime;
  var d4: string;
  var d5: integer;
  var d6: integer;
  var d7: integer;
  var d8: integer;
  var d9: integer;
  var da: integer;
  var db: double;
  var dc: double;
  var dd: double;
  var de: double;
  var df: integer;
  var dg: string;
  var dh: string;
begin
  Screen.Cursor:=crHourGlass;
  Form1.Cursor:=crHourGlass;
  Form1.Refresh;
  Printers.Printer.PrinterIndex:=druckn;
  format:=poPortrait;
  Printers.Printer.Canvas.Font.Charset:=0;
  Printers.Printer.Canvas.Font.Name:='Courier';
  Printers.Printer.Canvas.Font.Style:=[];
  Printers.Printer.Canvas.Font.Size:=8;
  vpy:=68;
  Printers.Printer.Canvas.Font.Pitch:=fpFixed;
  Printers.Printer.Canvas.Font.Color:=clBlack;
  Printers.Printer.Copies:=1;
  Printers.Printer.Orientation:=format;
  vpx:=56;
  px:=vpx+vpx;
  py:=vpy;
  Printers.Printer.BeginDoc;
    Kopf4;
    Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung';
    if sort = 'Hex-ID' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY hexid';
    if sort = 'Datum und Zeit' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY zeit';
    if sort = 'Flight' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY flight';
    if sort = 'Alt' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY alt';
    if sort = 'Speed' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY speed';
    if sort = 'Heading' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY heading';
    if sort = 'Lat' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY lat';
    if sort = 'Long' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY long';
    Form1.ZQuery1.Open;
    while not Form1.ZQuery1.EOF do
    begin
      d1:=Form1.ZQuery1.Fields[0].AsString;
      d2:=Form1.ZQuery1.Fields[1].AsDateTime;
      d4:=Form1.ZQuery1.Fields[2].AsString;
      d5:=Form1.ZQuery1.Fields[3].AsInteger;
      d7:=Form1.ZQuery1.Fields[4].AsInteger;
      d9:=Form1.ZQuery1.Fields[5].AsInteger;
      db:=Form1.ZQuery1.Fields[6].AsFloat;
      dc:=Form1.ZQuery1.Fields[7].AsFloat;
      ialpha:=d1;
      inummer:=6;
      iart:=1;
      Form1.maxlen;
      h1:=ialpha;
      h2:=DateTimeToStr(d2);
      ialpha:=d4;
      inummer:=8;
      iart:=1;
      Form1.maxlen;
      h4:=ialpha;
      ialpha:=IntToStr(Round(d5*0.3));
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      h5:=ialpha;
      ialpha:=IntToStr(Round(d7*1.852));
      inummer:=4;
      iart:=2;
      Form1.maxlen;
      h7:=ialpha;
      ialpha:=IntToStr(d9);
      inummer:=4;
      iart:=2;
      Form1.maxlen;
      h9:=ialpha;
      ialpha:=FloatToStrF(db,ffFixed,6,3);
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      hb:=ialpha;
      ialpha:=FloatToStrF(dc,ffFixed,6,3);
      inummer:=6;
      iart:=2;
      Form1.maxlen;
      hc:=ialpha;
      if ezeile > 98 then Kopf4;
      ezeile:=ezeile+1;
      Printers.Printer.Canvas.TextOut(px, py, h1+' '+h2+' '+h4+'  '+h5+'  '+h7+'   '+h9+'  '+hb+'  '+hc);
      py:=py+vpy;
      Form1.ZQuery1.Next;
    end;
    Form1.ZQuery1.Close;
// Hex-ID      Datum/Zeit      Flight     Alt  Speed  Heading   Lat    long
// 123456 12.12.1234 12:12:12 12345678  123456  1234   1234   12,123  12,123
//                                    12      12    123    123      12
 Printers.Printer.EndDoc;
 Screen.Cursor:=crDefault;
 Form1.Cursor:=crDefault;
 Form1.Refresh;
end;
// Portrait = 99   Zeilen a 117 Zeichen
// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567
//          1         2         3         4         5         6         7         8         9        10        11
// Landscape = 68   Zeilen a 168 Zeichen
// 123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
//          1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16
procedure TForm1.Kopf4;
begin
  if eseite > 0 then
  begin
    Printers.Printer.NewPage;
  end;
  eseite:=eseite+1;
  ezeile:=0;
  py:=vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, 'Hex-ID      Datum/Zeit      Flight     Alt  Speed  Heading   Lat    long');
  py:=py+vpy;
  ezeile:=ezeile+1;
  Printers.Printer.Canvas.TextOut(px, py, '=========================================================================');
  py:=py+vpy;
end;

procedure TForm1.maxlen;
  var laenge: integer;
  var h1: integer;
  var h2: integer;
begin
  laenge:=Length(ialpha);
  h1:=inummer - laenge;
  if laenge < inummer then
  begin
    if iart = 1 then
    begin
      for h2:=1 to h1 do
      begin
        ialpha:=ialpha+' ';
      end;
    end else begin
      for h2:=1 to h1 do
      begin
        ialpha:=' '+ialpha;
      end;
    end;
  end else begin
    if laenge > inummer then
    begin
      ialpha:=Copy(ialpha,1,inummer);
    end;
  end;
end;

procedure TForm1.Laden;
  var h1: string;
  var h2: TDateTime;
  var h3: TDateTime;
  var h4: string;
  var h5: integer;
  var h6: integer;
  var h7: integer;
  var h8: integer;
  var h9: Double;
  var ha: Double;
  var hb: Double;
  var hc: Double;
  var hd: integer;
  var he: string;
  var hf: string;
  var hg: string;
  var hh: string;
  var hi: integer;
  var hj: Double;
  var hk: integer;
  var hl: integer;
  var hm: integer;
  var hn: integer;
  var ho: integer;
  var hp: string;
  var hq: integer;
  var ht: Double;
  var dh: Double;
  var hu: integer;
  var hv: integer;
  var hw: integer;
  var hx: string;
  var hy: string;
  var hz: string;
  var hfl: integer;
  var hpr: string;
  var sflug: string;
  var sfluggs: string;
  var sfa: integer;
  var vflug: string;
  var xflug: string;
  var mflug: integer;
  var ha1: string;
  var ha2: string;
  var abf: string;
  var zif: string;
begin
  Screen.Cursor:=crHourGlass;
  Form1.Cursor:=crHourGlass;
  Form1.Refresh;
  Z:=1;
  if dart = 'Flugdaten' then
  begin
    StringGrid1.RowCount:=2;
    StringGrid1.ColCount:=20;
    StringGrid1.ColWidths[0]:=120;
    StringGrid1.ColWidths[1]:=180;
    StringGrid1.ColWidths[2]:=260;
    StringGrid1.ColWidths[3]:=260;
    StringGrid1.ColWidths[4]:=140;
    StringGrid1.ColWidths[5]:=150;
    StringGrid1.ColWidths[6]:=150;
    StringGrid1.ColWidths[7]:=220;
    StringGrid1.ColWidths[8]:=220;
    StringGrid1.ColWidths[9]:=180;
    StringGrid1.ColWidths[10]:=180;
    StringGrid1.ColWidths[11]:=150;
    StringGrid1.ColWidths[12]:=150;
    StringGrid1.ColWidths[13]:=150;
    StringGrid1.ColWidths[14]:=150;
    StringGrid1.ColWidths[15]:=810;
    StringGrid1.ColWidths[16]:=550;
    StringGrid1.ColWidths[17]:=180;
    StringGrid1.ColWidths[18]:=680;
    StringGrid1.ColWidths[19]:=680;
    StringGrid1.Cells[0, 0]:='ICAO-ID';
    StringGrid1.Cells[1, 0]:='Anzahl Daten';
    StringGrid1.Cells[2, 0]:='von Zeit';
    StringGrid1.Cells[3, 0]:='bis Zeit';
    StringGrid1.Cells[4, 0]:='Flight';
    StringGrid1.Cells[5, 0]:='von Alt [m]';
    StringGrid1.Cells[6, 0]:='bis Alt [m]';
    StringGrid1.Cells[7, 0]:='von Speed [Km/h]';
    StringGrid1.Cells[8, 0]:='bis Speed [Km/h]';
    StringGrid1.Cells[9, 0]:='von Heading [°]';
    StringGrid1.Cells[10, 0]:='bis Heading [°]';
    StringGrid1.Cells[11, 0]:='von Lat [°]';
    StringGrid1.Cells[12, 0]:='von Long [°]';
    StringGrid1.Cells[13, 0]:='bis Lat [°]';
    StringGrid1.Cells[14, 0]:='bis Long [°]';
    StringGrid1.Cells[15, 0]:='Fluggesellschaft';
    StringGrid1.Cells[16, 0]:='Land';
    StringGrid1.Cells[17, 0]:='Flugverfolgung';
    StringGrid1.Cells[18, 0]:='Abflughafen';
    StringGrid1.Cells[19, 0]:='Zielflughafen';
    StringGrid1.Cells[0, 1]:='';
    StringGrid1.Cells[1, 1]:='';
    StringGrid1.Cells[2, 1]:='';
    StringGrid1.Cells[3, 1]:='';
    StringGrid1.Cells[4, 1]:='';
    StringGrid1.Cells[5, 1]:='';
    StringGrid1.Cells[6, 1]:='';
    StringGrid1.Cells[7, 1]:='';
    StringGrid1.Cells[8, 1]:='';
    StringGrid1.Cells[9, 1]:='';
    StringGrid1.Cells[10, 1]:='';
    StringGrid1.Cells[11, 1]:='';
    StringGrid1.Cells[12, 1]:='';
    StringGrid1.Cells[13, 1]:='';
    StringGrid1.Cells[14, 1]:='';
    StringGrid1.Cells[15, 1]:='';
    StringGrid1.Cells[16, 1]:='';
    StringGrid1.Cells[17, 1]:='';
    StringGrid1.Cells[18, 1]:='';
    StringGrid1.Cells[19, 1]:='';
    Form1.ZQuery1.SQL.Text:='SELECT * FROM flight';
    if sort = 'Hex-ID' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY hexid';
    if sort = 'Datum und Zeit' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vonzeit';
    if sort = 'Flight' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY flight';
    if sort = 'Alt' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY valt';
    if sort = 'Speed' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vspeed';
    if sort = 'Heading' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vheading';
    if sort = 'Lat' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vlat';
    if sort = 'Long' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vlong';
    if sort = 'Anzahl Daten' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY anz';
    if sort = 'Flugverfolgung' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY verfolgung';
    if sort = 'Abflughafen' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY von';
    if sort = 'Zielflughafen' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY nach';
  end;
  if dart = 'Fluggesellschaften' then
  begin
    StringGrid1.RowCount:=2;
    StringGrid1.ColCount:=5;
    StringGrid1.ColWidths[0]:=810;
    StringGrid1.ColWidths[1]:=550;
    StringGrid1.ColWidths[2]:=120;
    StringGrid1.ColWidths[3]:=120;
    StringGrid1.ColWidths[4]:=810;
    StringGrid1.Cells[0, 0]:='Fluggesellschaft';
    StringGrid1.Cells[1, 0]:='Land';
    StringGrid1.Cells[2, 0]:='IATA-ID';
    StringGrid1.Cells[3, 0]:='ICAO-ID';
    StringGrid1.Cells[4, 0]:='Rufzeichen';
    StringGrid1.Cells[0, 1]:='';
    StringGrid1.Cells[1, 1]:='';
    StringGrid1.Cells[2, 1]:='';
    StringGrid1.Cells[3, 1]:='';
    StringGrid1.Cells[4, 1]:='';
    Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub';
    if sort = 'ICAO' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub ORDER BY icao';
    if sort = 'Fluggesellschaft' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub ORDER BY name';
    if sort = 'Land' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub ORDER BY land';
  end;
  if dart = 'ICAO Länder' then
  begin
    StringGrid1.RowCount:=2;
    StringGrid1.ColCount:=3;
    StringGrid1.ColWidths[0]:=150;
    StringGrid1.ColWidths[1]:=150;
    StringGrid1.ColWidths[2]:=550;
    StringGrid1.Cells[0, 0]:='von Hex-ID';
    StringGrid1.Cells[1, 0]:='bis Hex-ID';
    StringGrid1.Cells[2, 0]:='Land';
    StringGrid1.Cells[0, 1]:='';
    StringGrid1.Cells[1, 1]:='';
    StringGrid1.Cells[2, 1]:='';
    Form1.ZQuery1.SQL.Text:='SELECT * FROM icao';
    if sort = 'von Hex-ID' then Form1.ZQuery1.SQL.Text:='SELECT * FROM icao ORDER BY von';
    if sort = 'Land' then Form1.ZQuery1.SQL.Text:='SELECT * FROM icao ORDER BY land';
  end;
  if dart = 'Flugverfolgung' then
  begin
    StringGrid1.RowCount:=2;
    StringGrid1.ColCount:=8;
    StringGrid1.ColWidths[0]:=120;
    StringGrid1.ColWidths[1]:=260;
    StringGrid1.ColWidths[2]:=140;
    StringGrid1.ColWidths[3]:=150;
    StringGrid1.ColWidths[4]:=220;
    StringGrid1.ColWidths[5]:=180;
    StringGrid1.ColWidths[6]:=150;
    StringGrid1.ColWidths[7]:=150;
    StringGrid1.Cells[0, 0]:='ICAO-ID';
    StringGrid1.Cells[1, 0]:='Datum/Zeit';
    StringGrid1.Cells[2, 0]:='Flight';
    StringGrid1.Cells[3, 0]:='Alt [m]';
    StringGrid1.Cells[4, 0]:='Speed [Km/h]';
    StringGrid1.Cells[5, 0]:='Heading [°]';
    StringGrid1.Cells[6, 0]:='Lat [°]';
    StringGrid1.Cells[7, 0]:='Long [°]';
    StringGrid1.Cells[0, 1]:='';
    StringGrid1.Cells[1, 1]:='';
    StringGrid1.Cells[2, 1]:='';
    StringGrid1.Cells[3, 1]:='';
    StringGrid1.Cells[4, 1]:='';
    StringGrid1.Cells[5, 1]:='';
    StringGrid1.Cells[6, 1]:='';
    StringGrid1.Cells[7, 1]:='';
    Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung';
    if sort = 'Hex-ID' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY hexid';
    if sort = 'Datum und Zeit' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY zeit';
    if sort = 'Flight' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY flight';
    if sort = 'Alt' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY alt';
    if sort = 'Speed' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY speed';
    if sort = 'Heading' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY heading';
    if sort = 'Lat' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY lat';
    if sort = 'Long' then Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung ORDER BY long';
  end;
  if dart = 'Flugdaten' then
  begin
    Form1.ZQuery1.Open;
    while not Form1.ZQuery1.EOF do
    begin
      h1:=Form1.ZQuery1.Fields[0].AsString;
      h2:=Form1.ZQuery1.Fields[1].AsDateTime;
      h3:=Form1.ZQuery1.Fields[2].AsDateTime;
      h4:=Form1.ZQuery1.Fields[3].AsString;
      h5:=Form1.ZQuery1.Fields[4].AsInteger;
      hk:=Form1.ZQuery1.Fields[5].AsInteger;
      h6:=Form1.ZQuery1.Fields[6].AsInteger;
      hl:=Form1.ZQuery1.Fields[7].AsInteger;
      h7:=Form1.ZQuery1.Fields[8].AsInteger;
      h8:=Form1.ZQuery1.Fields[9].AsInteger;
      h9:=Form1.ZQuery1.Fields[10].AsFloat;
      ha:=Form1.ZQuery1.Fields[11].AsFloat;
      hb:=Form1.ZQuery1.Fields[12].AsFloat;
      hc:=Form1.ZQuery1.Fields[13].AsFloat;
      hd:=Form1.ZQuery1.Fields[14].AsInteger;
      ha1:=Form1.ZQuery1.Fields[15].AsString;
      abf:=Form1.ZQuery1.Fields[16].AsString;
      zif:=Form1.ZQuery1.Fields[17].AsString;
      z:=z + 1;
      StringGrid1.RowCount:=z;
      z:=z - 1;
      he:='';
      hf:='';
      hg:=h4;
      hi:=Length(hg);
      ialpha:=h1;
      Hexum;
      hu:=inummer;
      hh:='';
      hn:=0;
      if hi > 2 then
      begin
        hh:=Copy(hg,1,3);
        ialpha:=hg;
        Privflug;
        if inummer = 1 then hh:='001';
        Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
        Form1.ZQuery2.ParamByName('ica').asString:=hh;
        Form1.ZQuery2.Open;
        while not Form1.ZQuery2.EOF do
        begin
          hn:=1;
          he:=Form1.ZQuery2.Fields[0].AsString;
          hf:=Form1.ZQuery2.Fields[4].AsString;
          Form1.ZQuery2.Next;
        end;
        Form1.ZQuery2.Close;
      end;
      if hn = 0 then
      begin
        if hi > 0 then
        begin
          ho:=0;
          ialpha:=Copy(hg,1,1);
          inummer:=1;
          Nummer;
          hi:=Length(ialpha);
          if hi > 0 then
          begin
            ho:=1;
          end else begin
            ialpha:=Copy(hg,2,1);
            inummer:=1;
            Nummer;
            hi:=Length(ialpha);
            if hi > 0 then
            begin
              ho:=1;
            end;
          end;
          if ho = 1 then
          begin
            hh:='002';
            Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
            Form1.ZQuery2.ParamByName('ica').asString:=hh;
            Form1.ZQuery2.Open;
            while not Form1.ZQuery2.EOF do
            begin
              he:=Form1.ZQuery2.Fields[0].AsString;
              hf:=Form1.ZQuery2.Fields[4].AsString;
              Form1.ZQuery2.Next;
            end;
            Form1.ZQuery2.Close;
          end;
        end;
      end;
      if hf = '' then
      begin
        Form1.ZQuery3.SQL.Text:='SELECT * FROM icao';
        Form1.ZQuery3.Open;
        while not Form1.ZQuery3.EOF do
        begin
          hx:=Form1.ZQuery3.Fields[0].AsString;
          hy:=Form1.ZQuery3.Fields[1].AsString;
          hz:=Form1.ZQuery3.Fields[2].AsString;
          ialpha:=hx;
          Hexum;
          hv:=inummer;
          ialpha:=hy;
          Hexum;
          hw:=inummer;
          if ((hu >= hv) and (hu <= hw)) then hf:=hz;
          Form1.ZQuery3.Next;
        end;
        Form1.ZQuery3.Close;
      end;
      StringGrid1.Cells[0, z]:=h1;
      StringGrid1.Cells[1, z]:=IntToStr(hd);
      StringGrid1.Cells[2, z]:=DateTimeToStr(h2);
      StringGrid1.Cells[3, z]:=DateTimeToStr(h3);
      StringGrid1.Cells[4, z]:=h4;
      hj:=h5*0.3;
      StringGrid1.Cells[5, z]:=IntToStr(Round(hj));
      hj:=hk*0.3;
      StringGrid1.Cells[6, z]:=IntToStr(Round(hj));
      hj:=h6*1.852;
      StringGrid1.Cells[7, z]:=FloatToStrF(hj,ffFixed,7,2);
      hj:=hl*1.852;
      StringGrid1.Cells[8, z]:=FloatToStrF(hj,ffFixed,7,2);
      StringGrid1.Cells[9, z]:=IntToStr(h7);
      StringGrid1.Cells[10, z]:=IntToStr(h8);
      StringGrid1.Cells[11, z]:=FloatToStrF(h9,ffFixed,6,3);
      StringGrid1.Cells[12, z]:=FloatToStrF(ha,ffFixed,6,3);
      StringGrid1.Cells[13, z]:=FloatToStrF(hb,ffFixed,6,3);
      StringGrid1.Cells[14, z]:=FloatToStrF(hc,ffFixed,6,3);
      StringGrid1.Cells[15, z]:=he;
      StringGrid1.Cells[16, z]:=hf;
      StringGrid1.Cells[18, z]:=abf;
      StringGrid1.Cells[19, z]:=zif;
      ha2:='Nein';
      if ha1 = 'J' then ha2:='Ja';
      StringGrid1.Cells[17, z]:=ha2;
      z:=z + 1;
      Form1.ZQuery1.Next;
    end;
    Form1.ZQuery1.Close;
  end else begin
    if dart = 'Fluggesellschaften' then
    begin
      Form1.ZQuery1.Open;
      while not Form1.ZQuery1.EOF do
      begin
        h1:=Form1.ZQuery1.Fields[0].AsString;
        he:=Form1.ZQuery1.Fields[1].AsString;
        hf:=Form1.ZQuery1.Fields[2].AsString;
        h4:=Form1.ZQuery1.Fields[3].AsString;
        hh:=Form1.ZQuery1.Fields[4].AsString;
        z:=z + 1;
        StringGrid1.RowCount:=z;
        z:=z - 1;
        StringGrid1.Cells[0, z]:=h1;
        StringGrid1.Cells[1, z]:=hh;
        StringGrid1.Cells[2, z]:=he;
        StringGrid1.Cells[3, z]:=hf;
        StringGrid1.Cells[4, z]:=h4;
        z:=z + 1;
        Form1.ZQuery1.Next;
      end;
      Form1.ZQuery1.Close;
    end else begin
      if dart = 'ICAO Länder' then
      begin
        Form1.ZQuery1.Open;
        while not Form1.ZQuery1.EOF do
        begin
          h1:=Form1.ZQuery1.Fields[0].AsString;
          he:=Form1.ZQuery1.Fields[1].AsString;
          hf:=Form1.ZQuery1.Fields[2].AsString;
          z:=z + 1;
          StringGrid1.RowCount:=z;
          z:=z - 1;
          StringGrid1.Cells[0, z]:=h1;
          StringGrid1.Cells[1, z]:=he;
          StringGrid1.Cells[2, z]:=hf;
          z:=z + 1;
          Form1.ZQuery1.Next;
        end;
        Form1.ZQuery1.Close;
      end else begin
        if dart = 'Flugverfolgung' then
        begin
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            h1:=Form1.ZQuery1.Fields[0].AsString;
            h2:=Form1.ZQuery1.Fields[1].AsDateTime;
            h4:=Form1.ZQuery1.Fields[2].AsString;
            h5:=Form1.ZQuery1.Fields[3].AsInteger;
            h6:=Form1.ZQuery1.Fields[4].AsInteger;
            h7:=Form1.ZQuery1.Fields[5].AsInteger;
            h9:=Form1.ZQuery1.Fields[6].AsFloat;
            ha:=Form1.ZQuery1.Fields[7].AsFloat;
            z:=z + 1;
            StringGrid1.RowCount:=z;
            z:=z - 1;
            StringGrid1.Cells[0, z]:=h1;
            StringGrid1.Cells[1, z]:=DateTimeToStr(h2);
            StringGrid1.Cells[2, z]:=h4;
            hj:=h5*0.3;
            StringGrid1.Cells[3, z]:=IntToStr(Round(hj));
            hj:=h6*1.852;
            StringGrid1.Cells[4, z]:=FloatToStrF(hj,ffFixed,7,2);
            StringGrid1.Cells[5, z]:=IntToStr(h7);
            StringGrid1.Cells[6, z]:=FloatToStrF(h9,ffFixed,6,3);
            StringGrid1.Cells[7, z]:=FloatToStrF(ha,ffFixed,6,3);
            z:=z + 1;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
        end;
      end;
    end;
  end;
  Screen.Cursor:=crDefault;
  Form1.Cursor:=crDefault;
  Form1.Refresh;
  if z = 1 then
  begin
    StringGrid1.RowCount:=2;
    if dart = 'Flugdaten' then
    begin
      StringGrid1.Cells[0, 1]:='';
      StringGrid1.Cells[1, 1]:='';
      StringGrid1.Cells[2, 1]:='';
      StringGrid1.Cells[3, 1]:='';
      StringGrid1.Cells[4, 1]:='';
      StringGrid1.Cells[5, 1]:='';
      StringGrid1.Cells[6, 1]:='';
      StringGrid1.Cells[7, 1]:='';
      StringGrid1.Cells[8, 1]:='';
      StringGrid1.Cells[9, 1]:='';
      StringGrid1.Cells[10, 1]:='';
      StringGrid1.Cells[11, 1]:='';
      StringGrid1.Cells[12, 1]:='';
      StringGrid1.Cells[13, 1]:='';
      StringGrid1.Cells[14, 1]:='';
      StringGrid1.Cells[15, 1]:='';
      StringGrid1.Cells[16, 1]:='';
      StringGrid1.Cells[17, 1]:='';
      StringGrid1.Cells[18, 1]:='';
      StringGrid1.Cells[19, 1]:='';
    end;
    if dart = 'Fluggesellschaften' then
    begin
      StringGrid1.Cells[0, 1]:='';
      StringGrid1.Cells[1, 1]:='';
      StringGrid1.Cells[2, 1]:='';
      StringGrid1.Cells[3, 1]:='';
      StringGrid1.Cells[4, 1]:='';
    end;
    if dart = 'ICAO Länder' then
    begin
      StringGrid1.Cells[0, 1]:='';
      StringGrid1.Cells[1, 1]:='';
      StringGrid1.Cells[2, 1]:='';
    end;
    if dart = 'Flugverfolgung' then
    begin
      StringGrid1.Cells[0, 1]:='';
      StringGrid1.Cells[1, 1]:='';
      StringGrid1.Cells[2, 1]:='';
      StringGrid1.Cells[3, 1]:='';
      StringGrid1.Cells[4, 1]:='';
      StringGrid1.Cells[5, 1]:='';
      StringGrid1.Cells[6, 1]:='';
      StringGrid1.Cells[7, 1]:='';
    end;
  end;
  egrid:=0;
end;

procedure TForm1.Nummer;
  var laenge: integer;
  var stelle: integer;
  var m: integer;
  var zeichen: string;
  var tt: string;
begin
  laenge:=Length(ialpha);
  tt:='';
  if laenge > 0 then
  begin
    tt:=ialpha;
    for stelle:=1 to laenge do
    begin
      zeichen:=Copy(ialpha,stelle,1);
      m:=0;
      if zeichen = '0' then
      begin
        m:=1;
      end;
      if zeichen = '1' then
      begin
        m:=1;
      end;
      if zeichen = '2' then
      begin
        m:=1;
      end;
      if zeichen = '3' then
      begin
        m:=1;
      end;
      if zeichen = '4' then
      begin
        m:=1;
      end;
      if zeichen = '5' then
      begin
        m:=1;
      end;
      if zeichen = '6' then
      begin
        m:=1;
      end;
      if zeichen = '7' then
      begin
        m:=1;
      end;
      if zeichen = '8' then
      begin
        m:=1;
      end;
      if zeichen = '9' then
      begin
        m:=1;
      end;
      if ((inummer = 2) and (zeichen = ',')) then
      begin
        m:=1;
      end;
      if m = 0 then
      begin
        tt:='';
      end;
    end;
  end;
  ialpha:=tt;
end;

procedure TForm1.ZConnection1AfterConnect(Sender: TObject);
begin
  if ZConnection1.Connected then
  begin
    dcon:=1;
    ZQuery2.SQL.Clear;
    ZQuery2.SQL.Add('SET GLOBAL max_connections=8001');
    try
      ZQuery2.ExecSQL;
    except
      on E: Exception do
      begin
        herrmsg:=E.Message;
      end;
    end;
    ZQuery2.Close;
    Laden;
  end else begin
    dcon:=2;
    JaNein:=messagedlg('keine Verbindung zur Datenbank flight', mtError, [mbOk], 0);
    close;
  end;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect:=True;
  egrid:=ARow;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if (Closestat = 0) then
  begin
    if (mtasts = 1) then
    begin
      mtasts:=1;
      egrid:=0;
      mlauf:=0;
      close;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (mtasts = 1) then
  begin
    Label2.Caption:='';
    if dart = 'Fluggesellschaften' then
    begin
      mtasts:=0;
      mlauf:=2;
      mart:=1;
      egrid:=0;
      BLoe;
      Edit2.Enabled:=True;
      Edit2.Color:=clYellow;
      Edit2.Font.Color:=clBlue;
      Edit2.ReadOnly:=False;
      Edit2.Text:='';
      ialpha:='';
      inummer:=0;
      iart:=2;
      inumkom:=0;
      ikomma:=0;
      izeich:=2;
      istell:=0;
      ifunc:=5;
      ilanmax:=3;
      ilanmin:=1;
      iautocr:=1;
      Form1.ActiveControl:=Edit2;
      Edit2.AutoSelect:=True;
    end;
    if dart = 'ICAO Länder' then
    begin
      mtasts:=0;
      mlauf:=2;
      mart:=1;
      Combobox1.Enabled:=False;
      ComboBox1.Color:=clSilver;
      ComboBox1.Font.Color:=clGray;
      Combobox2.Enabled:=False;
      ComboBox2.Color:=clSilver;
      ComboBox2.Font.Color:=clGray;
      BLoe;
      Edit2.Enabled:=True;
      Edit2.Color:=clYellow;
      Edit2.Font.Color:=clBlue;
      Edit2.ReadOnly:=False;
      Edit2.Text:='';
      ialpha:='';
      inummer:=0;
      iart:=2;
      inumkom:=0;
      ikomma:=0;
      izeich:=2;
      istell:=0;
      ifunc:=5;
      ilanmax:=6;
      ilanmin:=1;
      iautocr:=1;
      Form1.ActiveControl:=Edit2;
      Edit2.AutoSelect:=True;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
  var h1: integer;
  var he: string;
  var hf: string;
  var hg: string;
  var hh: string;
  var hi: integer;
  var hn: integer;
  var ho: integer;
  var hu: integer;
  var hv: integer;
  var hw: integer;
  var hx: string;
  var hy: string;
  var hz: string;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (mtasts = 1) then
  begin
    Label2.Caption:='';
    if dart = 'Flugdaten' then
    begin
      if egrid > 0 then
      begin
        ehex:=StringGrid1.Cells[0, egrid];
        evzeit:=StrToDateTime(StringGrid1.Cells[2, egrid]);
        egrid:=0;
        if ehex <> '' then
        begin
          eflight:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE hexid=:hex AND vonzeit=:von';
          Form1.ZQuery1.ParamByName('hex').asString:=ehex;
          Form1.ZQuery1.ParamByName('von').asDateTime:=evzeit;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            ebzeit:=Form1.ZQuery1.Fields[2].AsDateTime;
            eflight:=Form1.ZQuery1.Fields[3].AsString;
            evalt:=Form1.ZQuery1.Fields[4].AsInteger;
            ebalt:=Form1.ZQuery1.Fields[5].AsInteger;
            evspeed:=Form1.ZQuery1.Fields[6].AsInteger;
            ebspeed:=Form1.ZQuery1.Fields[7].AsInteger;
            evhead:=Form1.ZQuery1.Fields[8].AsInteger;
            ebhead:=Form1.ZQuery1.Fields[9].AsInteger;
            evlat:=Form1.ZQuery1.Fields[10].AsFloat;
            evlong:=Form1.ZQuery1.Fields[11].AsFloat;
            eblat:=Form1.ZQuery1.Fields[12].AsFloat;
            eblong:=Form1.ZQuery1.Fields[13].AsFloat;
            eanz:=Form1.ZQuery1.Fields[14].AsInteger;
            everf:=Form1.ZQuery1.Fields[15].AsString;
            eabf:=Form1.ZQuery1.Fields[16].AsString;
            ezif:=Form1.ZQuery1.Fields[17].AsString;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eflight <> '' then
          begin
            abzeit:=ebzeit;
            aflight:=eflight;
            avalt:=evalt;
            abalt:=ebalt;
            avspeed:=evspeed;
            abspeed:=ebspeed;
            avhead:=evhead;
            abhead:=ebhead;
            avlat:=evlat;
            avlong:=evlong;
            ablat:=eblat;
            ablong:=eblong;
            aanz:=eanz;
            averf:=everf;
            aabf:=eabf;
            azif:=ezif;
            Label10.Caption:=ehex;
            Label12.Caption:=DateTimeToStr(evzeit);
            Label14.Caption:=DateTimeToStr(ebzeit);
            Label21.Caption:=IntToStr(eanz);
            hh:='Nein';
            if everf = 'J' then hh:='Ja';
            Label5.Caption:=hh;
            Edit1.Text:=eflight;
            h1:=Round(evalt*0.3);
            Edit2.Text:=IntToStr(h1);
            evalt:=Round(h1);
            h1:=Round(ebalt*0.3);
            Edit3.Text:=IntToStr(h1);
            ebalt:=Round(h1);
            h1:=Round(evspeed*1.852);
            Edit4.Text:=IntToStr(h1);
            evspeed:=h1;
            h1:=Round(ebspeed*1.852);
            Edit5.Text:=IntToStr(h1);
            ebspeed:=h1;
            Edit6.Text:=IntToStr(evhead);
            Edit7.Text:=IntToStr(ebhead);
            Edit8.Text:=FloatToStrF(evlat,ffFixed,6,3);
            Edit9.Text:=FloatToStrF(eblat,ffFixed,6,3);
            Edit10.Text:=FloatToStrF(evlong,ffFixed,6,3);
            Edit11.Text:=FloatToStrF(eblong,ffFixed,6,3);
            Edit15.Text:=eabf;
            Edit16.Text:=ezif;
            he:='';
            hf:='';
            hg:=eflight;
            hi:=Length(hg);
            ialpha:=ehex;
            Hexum;
            hu:=inummer;
            hh:='';
            hn:=0;
            if hi > 2 then
            begin
              hh:=Copy(hg,1,3);
              ialpha:=hg;
              Privflug;
              if inummer = 1 then hh:='001';
              Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
              Form1.ZQuery2.ParamByName('ica').asString:=hh;
              Form1.ZQuery2.Open;
              while not Form1.ZQuery2.EOF do
              begin
                hn:=1;
                he:=Form1.ZQuery2.Fields[0].AsString;
                hf:=Form1.ZQuery2.Fields[4].AsString;
                Form1.ZQuery2.Next;
              end;
              Form1.ZQuery2.Close;
            end;
            if hn = 0 then
            begin
              if hi > 0 then
              begin
                ho:=0;
                ialpha:=Copy(hg,1,1);
                inummer:=1;
                Nummer;
                hi:=Length(ialpha);
                if hi > 0 then
                begin
                  ho:=1;
                end else begin
                  ialpha:=Copy(hg,2,1);
                  inummer:=1;
                  Nummer;
                  hi:=Length(ialpha);
                  if hi > 0 then
                  begin
                    ho:=1;
                  end;
                end;
                if ho = 1 then
                begin
                  hh:='002';
                  Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
                  Form1.ZQuery2.ParamByName('ica').asString:=hh;
                  Form1.ZQuery2.Open;
                  while not Form1.ZQuery2.EOF do
                  begin
                    he:=Form1.ZQuery2.Fields[0].AsString;
                    hf:=Form1.ZQuery2.Fields[4].AsString;
                    Form1.ZQuery2.Next;
                  end;
                  Form1.ZQuery2.Close;
                end;
              end;
            end;
            if hf = '' then
            begin
              Form1.ZQuery3.SQL.Text:='SELECT * FROM icao';
              Form1.ZQuery3.Open;
              while not Form1.ZQuery3.EOF do
              begin
                hx:=Form1.ZQuery3.Fields[0].AsString;
                hy:=Form1.ZQuery3.Fields[1].AsString;
                hz:=Form1.ZQuery3.Fields[2].AsString;
                ialpha:=hx;
                Hexum;
                hv:=inummer;
                ialpha:=hy;
                Hexum;
                hw:=inummer;
                if ((hu >= hv) and (hu <= hw)) then hf:=hz;
                Form1.ZQuery3.Next;
              end;
              Form1.ZQuery3.Close;
            end;
            eflugg:=he;
            eland:=hf;
            Edit12.Text:=eflugg;
            Edit13.Text:=eland;
            mtasts:=0;
            mart:=2;
            mlauf:=1;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            Edit1.Enabled:=True;
            Edit1.Color:=clYellow;
            Edit1.Font.Color:=clBlue;
            Edit1.ReadOnly:=False;
            Edit1.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=2;
            istell:=0;
            ifunc:=5;
            ilanmax:=8;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit1.Text:=eflight;
              ialpha:=eflight;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit1;
            Edit1.AutoSelect:=True;
          end else begin
            Label2.Caption:='Flugdaten nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst Flugdaten im Stringgrid markieren';
      end;
    end;
    if dart = 'Fluggesellschaften' then
    begin
      if egrid > 0 then
      begin
        eicao:=StringGrid1.Cells[3, egrid];
        if eicao <> '' then
        begin
          eflugg:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
          Form1.ZQuery1.ParamByName('ica').asString:=eicao;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            eflugg:=Form1.ZQuery1.Fields[0].AsString;
            eiata:=Form1.ZQuery1.Fields[1].AsString;
            erufz:=Form1.ZQuery1.Fields[3].AsString;
            eland:=Form1.ZQuery1.Fields[4].AsString;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eflugg <> '' then
          begin
            aflugg:=eflugg;
            aiata:=eiata;
            arufz:=erufz;
            aland:=eland;
            Edit12.Text:=eflugg;
            Edit2.Text:=eiata;
            Edit3.Text:=eicao;
            Edit13.Text:=eland;
            Edit14.Text:=erufz;
            mtasts:=0;
            mart:=2;
            mlauf:=2;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            Edit2.Enabled:=True;
            Edit2.Color:=clYellow;
            Edit2.Font.Color:=clBlue;
            Edit2.ReadOnly:=False;
            Edit2.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=2;
            istell:=0;
            ifunc:=5;
            ilanmax:=3;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit2.Text:=eiata;
              ialpha:=eiata;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit2;
            Edit2.AutoSelect:=True;
          end else begin
            Label2.Caption:='Fluggesellschaft nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst Fluggesellschaft im Stringgrid markieren';
      end;
    end;
    if dart = 'ICAO Länder' then
    begin
      if egrid > 0 then
      begin
        evhex:=StringGrid1.Cells[0, egrid];
        if evhex <> '' then
        begin
          eland:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM icao WHERE von=:von';
          Form1.ZQuery1.ParamByName('von').asString:=evhex;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            ebhex:=Form1.ZQuery1.Fields[1].AsString;
            eland:=Form1.ZQuery1.Fields[2].AsString;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eland <> '' then
          begin
            abhex:=ebhex;
            aland:=eland;
            Edit2.Text:=evhex;
            Edit3.Text:=ebhex;
            Edit13.Text:=eland;
            mtasts:=0;
            mart:=2;
            mlauf:=3;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            Edit3.Enabled:=True;
            Edit3.Color:=clYellow;
            Edit3.Font.Color:=clBlue;
            Edit3.ReadOnly:=False;
            Edit3.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=2;
            istell:=0;
            ifunc:=5;
            ilanmax:=6;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit3.Text:=ebhex;
              ialpha:=ebhex;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit3;
            Edit3.AutoSelect:=True;
          end else begin
            Label2.Caption:='ICAO-ID nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst ICAO-ID im Stringgrid markieren';
      end;
    end;
    if dart = 'Flugverfolgung' then
    begin
      if egrid > 0 then
      begin
        ehex:=StringGrid1.Cells[0, egrid];
        evzeit:=StrToDateTime(StringGrid1.Cells[1, egrid]);
        if ehex <> '' then
        begin
          eflight:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung WHERE hexid=:hex AND zeit=:von';
          Form1.ZQuery1.ParamByName('hex').asString:=ehex;
          Form1.ZQuery1.ParamByName('von').asDateTime:=evzeit;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            eflight:=Form1.ZQuery1.Fields[2].AsString;
            evalt:=Form1.ZQuery1.Fields[3].AsInteger;
            evspeed:=Form1.ZQuery1.Fields[4].AsInteger;
            evhead:=Form1.ZQuery1.Fields[5].AsInteger;
            evlat:=Form1.ZQuery1.Fields[6].AsFloat;
            evlong:=Form1.ZQuery1.Fields[7].AsFloat;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eflight <> '' then
          begin
            aflight:=eflight;
            avalt:=evalt;
            avspeed:=evspeed;
            avhead:=evhead;
            avlat:=evlat;
            avlong:=evlong;
            Label10.Caption:=ehex;
            Label12.Caption:=DateTimeToStr(evzeit);
            Edit1.Text:=eflight;
            h1:=Round(evalt*0.3);
            Edit2.Text:=IntToStr(h1);
            evalt:=Round(h1);
            h1:=Round(evspeed*1.852);
            Edit4.Text:=IntToStr(h1);
            evspeed:=h1;
            Edit6.Text:=IntToStr(evhead);
            Edit8.Text:=FloatToStrF(evlat,ffFixed,6,3);
            Edit10.Text:=FloatToStrF(evlong,ffFixed,6,3);
            mtasts:=0;
            mart:=2;
            mlauf:=1;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            Edit1.Enabled:=True;
            Edit1.Color:=clYellow;
            Edit1.Font.Color:=clBlue;
            Edit1.ReadOnly:=False;
            Edit1.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=2;
            istell:=0;
            ifunc:=5;
            ilanmax:=8;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit1.Text:=eflight;
              ialpha:=eflight;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit1;
            Edit1.AutoSelect:=True;
          end else begin
            Label2.Caption:='Flugverfolgung nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst Flugverfolgung im Stringgrid markieren';
      end;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
  var h1: integer;
  var he: string;
  var hf: string;
  var hg: string;
  var hh: string;
  var hi: integer;
  var hn: integer;
  var ho: integer;
  var hu: integer;
  var hv: integer;
  var hw: integer;
  var hx: string;
  var hy: string;
  var hz: string;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (mtasts = 1) then
  begin
    Label2.Caption:='';
    if dart = 'Flugdaten' then
    begin
      if egrid > 0 then
      begin
        ehex:=StringGrid1.Cells[0, egrid];
        evzeit:=StrToDateTime(StringGrid1.Cells[2, egrid]);
        egrid:=0;
        if ehex <> '' then
        begin
          eflight:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE hexid=:hex AND vonzeit=:von';
          Form1.ZQuery1.ParamByName('hex').asString:=ehex;
          Form1.ZQuery1.ParamByName('von').asDateTime:=evzeit;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            ebzeit:=Form1.ZQuery1.Fields[2].AsDateTime;
            eflight:=Form1.ZQuery1.Fields[3].AsString;
            evalt:=Form1.ZQuery1.Fields[4].AsInteger;
            ebalt:=Form1.ZQuery1.Fields[5].AsInteger;
            evspeed:=Form1.ZQuery1.Fields[6].AsInteger;
            ebspeed:=Form1.ZQuery1.Fields[7].AsInteger;
            evhead:=Form1.ZQuery1.Fields[8].AsInteger;
            ebhead:=Form1.ZQuery1.Fields[9].AsInteger;
            evlat:=Form1.ZQuery1.Fields[10].AsFloat;
            evlong:=Form1.ZQuery1.Fields[11].AsFloat;
            eblat:=Form1.ZQuery1.Fields[12].AsFloat;
            eblong:=Form1.ZQuery1.Fields[13].AsFloat;
            eanz:=Form1.ZQuery1.Fields[14].AsInteger;
            everf:=Form1.ZQuery1.Fields[15].AsString;
            eabf:=Form1.ZQuery1.Fields[16].AsString;
            ezif:=Form1.ZQuery1.Fields[17].AsString;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eflight <> '' then
          begin
            Label10.Caption:=ehex;
            Label12.Caption:=DateTimeToStr(evzeit);
            Label14.Caption:=DateTimeToStr(ebzeit);
            Label21.Caption:=IntToStr(eanz);
            hh:='Nein';
            if everf = 'J' then hh:='Ja';
            Label5.Caption:=hh;
            Edit1.Text:=eflight;
            h1:=Round(evalt*0.3);
            Edit2.Text:=IntToStr(h1);
            evalt:=Round(h1);
            h1:=Round(ebalt*0.3);
            Edit3.Text:=IntToStr(h1);
            ebalt:=Round(h1);
            h1:=Round(evspeed*1.852);
            Edit4.Text:=IntToStr(h1);
            evspeed:=h1;
            h1:=Round(ebspeed*1.852);
            Edit5.Text:=IntToStr(h1);
            ebspeed:=h1;
            Edit6.Text:=IntToStr(evhead);
            Edit7.Text:=IntToStr(ebhead);
            Edit8.Text:=FloatToStrF(evlat,ffFixed,6,3);
            Edit9.Text:=FloatToStrF(eblat,ffFixed,6,3);
            Edit10.Text:=FloatToStrF(evlong,ffFixed,6,3);
            Edit11.Text:=FloatToStrF(eblong,ffFixed,6,3);
            Edit15.Text:=eabf;
            Edit16.Text:=ezif;
            he:='';
            hf:='';
            hg:=eflight;
            hi:=Length(hg);
            ialpha:=ehex;
            Hexum;
            hu:=inummer;
            hh:='';
            hn:=0;
            if hi > 2 then
            begin
              hh:=Copy(hg,1,3);
              ialpha:=hg;
              Privflug;
              if inummer = 1 then hh:='001';
              Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
              Form1.ZQuery2.ParamByName('ica').asString:=hh;
              Form1.ZQuery2.Open;
              while not Form1.ZQuery2.EOF do
              begin
                hn:=1;
                he:=Form1.ZQuery2.Fields[0].AsString;
                hf:=Form1.ZQuery2.Fields[4].AsString;
                Form1.ZQuery2.Next;
              end;
              Form1.ZQuery2.Close;
            end;
            if hn = 0 then
            begin
              if hi > 0 then
              begin
                ho:=0;
                ialpha:=Copy(hg,1,1);
                inummer:=1;
                Nummer;
                hi:=Length(ialpha);
                if hi > 0 then
                begin
                  ho:=1;
                end else begin
                  ialpha:=Copy(hg,2,1);
                  inummer:=1;
                  Nummer;
                  hi:=Length(ialpha);
                  if hi > 0 then
                  begin
                    ho:=1;
                  end;
                end;
                if ho = 1 then
                begin
                  hh:='002';
                  Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
                  Form1.ZQuery2.ParamByName('ica').asString:=hh;
                  Form1.ZQuery2.Open;
                  while not Form1.ZQuery2.EOF do
                  begin
                    he:=Form1.ZQuery2.Fields[0].AsString;
                    hf:=Form1.ZQuery2.Fields[4].AsString;
                    Form1.ZQuery2.Next;
                  end;
                  Form1.ZQuery2.Close;
                end;
              end;
            end;
            if hf = '' then
            begin
              Form1.ZQuery3.SQL.Text:='SELECT * FROM icao';
              Form1.ZQuery3.Open;
              while not Form1.ZQuery3.EOF do
              begin
                hx:=Form1.ZQuery3.Fields[0].AsString;
                hy:=Form1.ZQuery3.Fields[1].AsString;
                hz:=Form1.ZQuery3.Fields[2].AsString;
                ialpha:=hx;
                Hexum;
                hv:=inummer;
                ialpha:=hy;
                Hexum;
                hw:=inummer;
                if ((hu >= hv) and (hu <= hw)) then hf:=hz;
                Form1.ZQuery3.Next;
              end;
              Form1.ZQuery3.Close;
            end;
            eflugg:=he;
            eland:=hf;
            Edit12.Text:=eflugg;
            Edit13.Text:=eland;
            mtasts:=0;
            mart:=3;
            mlauf:=0;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            JaNein:=messagedlg('Flugdaten löschen ?', mtConfirmation, [mbYes, mbNo], 0);
            if (JaNein = mrYes) then
            begin
              SqlRet:=True;
              herrmsg:='';
              Label2.Caption:=herrmsg;
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('DELETE FROM flight WHERE hexid=:hex AND vonzeit=:von');
              ZQuery2.ParamByName('hex').asString:=ehex;
              ZQuery2.ParamByName('von').asDateTime:=evzeit;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
              if not SqlRet then
              begin
                Label2.Caption:=herrmsg+'  Fehler beim Löschen Flugdaten';
              end;
            end;
            mtasts:=1;
            mlauf:=0;
            mart:=0;
            Combobox1.Enabled:=True;
            ComboBox1.Color:=clYellow;
            ComboBox1.Font.Color:=clBlue;
            Combobox2.Enabled:=True;
            ComboBox2.Color:=clYellow;
            ComboBox2.Font.Color:=clBlue;
            BLoe;
            Laden;
          end else begin
            Label2.Caption:='flugdaten nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst Flugdaten im Stringgrid markieren';
      end;
    end;
    if dart = 'Fluggesellschaften' then
    begin
      if egrid > 0 then
      begin
        eicao:=StringGrid1.Cells[3, egrid];
        if eicao <> '' then
        begin
          eflugg:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
          Form1.ZQuery1.ParamByName('ica').asString:=eicao;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            eflugg:=Form1.ZQuery1.Fields[0].AsString;
            eiata:=Form1.ZQuery1.Fields[1].AsString;
            erufz:=Form1.ZQuery1.Fields[3].AsString;
            eland:=Form1.ZQuery1.Fields[4].AsString;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eflugg <> '' then
          begin
            Edit12.Text:=eflugg;
            Edit2.Text:=eiata;
            Edit3.Text:=eicao;
            Edit13.Text:=eland;
            Edit14.Text:=erufz;
            mtasts:=0;
            mart:=3;
            mlauf:=0;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            JaNein:=messagedlg('Fluggesellschaft löschen ?', mtConfirmation, [mbYes, mbNo], 0);
            if (JaNein = mrYes) then
            begin
              SqlRet:=True;
              herrmsg:='';
              Label2.Caption:=herrmsg;
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('DELETE FROM flightclub WHERE icao=:ica');
              ZQuery2.ParamByName('ica').asString:=eicao;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
              if not SqlRet then
              begin
                Label2.Caption:=herrmsg+'  Fehler beim Löschen Fluggesellschaft';
              end;
            end;
            mtasts:=1;
            mlauf:=0;
            mart:=0;
            Combobox1.Enabled:=True;
            ComboBox1.Color:=clYellow;
            ComboBox1.Font.Color:=clBlue;
            Combobox2.Enabled:=True;
            ComboBox2.Color:=clYellow;
            ComboBox2.Font.Color:=clBlue;
            BLoe;
            Laden;
          end else begin
            Label2.Caption:='fluggesellschaft nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst fluggesellschaft im Stringgrid markieren';
      end;
    end;
    if dart = 'ICAO Länder' then
    begin
      if egrid > 0 then
      begin
        evhex:=StringGrid1.Cells[0, egrid];
        if evhex <> '' then
        begin
          eland:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM icao WHERE von=:von';
          Form1.ZQuery1.ParamByName('von').asString:=evhex;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            ebhex:=Form1.ZQuery1.Fields[1].AsString;
            eland:=Form1.ZQuery1.Fields[2].AsString;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eland <> '' then
          begin
            Edit2.Text:=evhex;
            Edit3.Text:=ebhex;
            Edit13.Text:=eland;
            mtasts:=0;
            mart:=3;
            mlauf:=0;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            JaNein:=messagedlg('ICAO-ID löschen ?', mtConfirmation, [mbYes, mbNo], 0);
            if (JaNein = mrYes) then
            begin
              SqlRet:=True;
              herrmsg:='';
              Label2.Caption:=herrmsg;
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('DELETE FROM icao WHERE von=:von');
              ZQuery2.ParamByName('von').asString:=evhex;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
              if not SqlRet then
              begin
                Label2.Caption:=herrmsg+'  Fehler beim Löschen ICAO-ID';
              end;
            end;
            mtasts:=1;
            mlauf:=0;
            mart:=0;
            Combobox1.Enabled:=True;
            ComboBox1.Color:=clYellow;
            ComboBox1.Font.Color:=clBlue;
            Combobox2.Enabled:=True;
            ComboBox2.Color:=clYellow;
            ComboBox2.Font.Color:=clBlue;
            BLoe;
            Laden;
          end else begin
            Label2.Caption:='ICAO-ID nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst ICAO-ID im Stringgrid markieren';
      end;
    end;
    if dart = 'Flugverfolgung' then
    begin
      if egrid > 0 then
      begin
        ehex:=StringGrid1.Cells[0, egrid];
        evzeit:=StrToDateTime(StringGrid1.Cells[1, egrid]);
        if ehex <> '' then
        begin
          eflight:='';
          Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung WHERE hexid=:hex AND zeit=:von';
          Form1.ZQuery1.ParamByName('hex').asString:=ehex;
          Form1.ZQuery1.ParamByName('von').asDateTime:=evzeit;
          Form1.ZQuery1.Open;
          while not Form1.ZQuery1.EOF do
          begin
            eflight:=Form1.ZQuery1.Fields[2].AsString;
            evalt:=Form1.ZQuery1.Fields[3].AsInteger;
            evspeed:=Form1.ZQuery1.Fields[4].AsInteger;
            evhead:=Form1.ZQuery1.Fields[5].AsInteger;
            evlat:=Form1.ZQuery1.Fields[6].AsFloat;
            evlong:=Form1.ZQuery1.Fields[7].AsFloat;
            Form1.ZQuery1.Next;
          end;
          Form1.ZQuery1.Close;
          if eflight <> '' then
          begin
            Label10.Caption:=ehex;
            Label12.Caption:=DateTimeToStr(evzeit);
            Edit1.Text:=eflight;
            h1:=Round(evalt*0.3);
            Edit2.Text:=IntToStr(h1);
            evalt:=Round(h1);
            h1:=Round(evspeed*1.852);
            Edit4.Text:=IntToStr(h1);
            evspeed:=h1;
            Edit6.Text:=IntToStr(evhead);
            Edit8.Text:=FloatToStrF(evlat,ffFixed,6,3);
            Edit10.Text:=FloatToStrF(evlong,ffFixed,6,3);
            Edit12.Text:=eflugg;
            Edit13.Text:=eland;
            mtasts:=0;
            mart:=3;
            mlauf:=0;
            Combobox1.Enabled:=False;
            ComboBox1.Color:=clSilver;
            ComboBox1.Font.Color:=clGray;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clSilver;
            ComboBox2.Font.Color:=clGray;
            JaNein:=messagedlg('Flugverfolgung löschen ?', mtConfirmation, [mbYes, mbNo], 0);
            if (JaNein = mrYes) then
            begin
              SqlRet:=True;
              herrmsg:='';
              Label2.Caption:=herrmsg;
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('DELETE FROM verfolgung WHERE hexid=:hex AND zeit=:von');
              ZQuery2.ParamByName('hex').asString:=ehex;
              ZQuery2.ParamByName('von').asDateTime:=evzeit;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
              if not SqlRet then
              begin
                Label2.Caption:=herrmsg+'  Fehler beim Löschen Flugverfolgung';
              end;
            end;
            mtasts:=1;
            mlauf:=0;
            mart:=0;
            Combobox1.Enabled:=True;
            ComboBox1.Color:=clYellow;
            ComboBox1.Font.Color:=clBlue;
            Combobox2.Enabled:=True;
            ComboBox2.Color:=clYellow;
            ComboBox2.Font.Color:=clBlue;
            BLoe;
            Laden;
          end else begin
            Label2.Caption:='flugverfolgung nicht vorhanden in Datenbank';
          end;
        end else begin
          Label2.Caption:='markierte Zeile im Stringgrid ist leer';
        end;
      end else begin
        Label2.Caption:='erst Flugverfolgung im Stringgrid markieren';
      end;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (mtasts = 1) then
  begin
    Label2.Caption:='';
    JaNein:=messagedlg('Liste drucken ?', mtConfirmation, [mbYes, mbNo], 0);
    if (JaNein = mrYes) then
    begin
      mtasts:=0;
      mart:=0;
      mlauf:=0;
      egrid:=0;
      Combobox1.Enabled:=False;
      ComboBox1.Color:=clSilver;
      ComboBox1.Font.Color:=clGray;
      Combobox2.Enabled:=False;
      ComboBox2.Color:=clSilver;
      ComboBox2.Font.Color:=clGray;
      if dart = 'Flugdaten' then
      begin
        Druck1;
      end;
      if dart = 'Fluggesellschaften' then
      begin
        Druck2;
      end;
      if dart = 'ICAO Länder' then
      begin
        Druck3;
      end;
      if dart = 'Flugverfolgung' then
      begin
        Druck4;
      end;
      mtasts:=1;
      mlauf:=0;
      mart:=0;
      Combobox1.Enabled:=True;
      ComboBox1.Color:=clYellow;
      ComboBox1.Font.Color:=clBlue;
      Combobox2.Enabled:=True;
      ComboBox2.Color:=clYellow;
      ComboBox2.Font.Color:=clBlue;
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
  var h1: integer;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if mtasts = 1 then
  begin
    Label2.Caption:='';
    ialpha:=ComboBox1.Text;
    Form1.Blankwegh;
    Form1.Blankwegv;
    if ialpha <> '' then
    begin
      dart:=ialpha;
      if dart = 'Flugdaten' then
      begin
        BLoe;
        Label26.Caption:='Flugverfolgung:';
        Label15.Caption:='ICAO-HexID:';
        Label16.Caption:='von Datum/Zeit:';
        Label23.Caption:='bis Datum/Zeit:';
        Label11.Caption:='Flugnummer:';
        Label17.Caption:='von Höhe (m):';
        Label24.Caption:='bis Höhe (m):';
        Label20.Caption:='von Geschwindigkeit (Km/h):';
        Label18.Caption:='bis Geschwindigkeit (Km/h):';
        Label25.Caption:='Anzahl Daten:';
        Label13.Caption:='von Richtung (°):';
        Label19.Caption:='bis Richtung (°):';
        Label29.Caption:='von Latitude (°):';
        Label30.Caption:='bis Latitude (°):';
        Label22.Caption:='von Longitude (°):';
        Label27.Caption:='bis Lingitude (°):';
        Label28.Caption:='Fluggesellschaft:';
        Label6.Caption:='Land:';
        Label7.Caption:='Rufzeichen:';
        Label8.Caption:='Abflughafen:';
        Label9.Caption:='Zielflughafen:';
        sort:='Flight';
        ComboBox2.Text:='';
        ComboBox2.ItemIndex:=-1;
        ComboBox2.ItemHeight:=22;
        ComboBox2.Items.Clear;
        ComboBox2.Items.Add('Hex_ID');
        ComboBox2.Items.Add('Datum und Zeit');
        ComboBox2.Items.Add('Flight');
        ComboBox2.Items.Add('Alt');
        ComboBox2.Items.Add('Speed');
        ComboBox2.Items.Add('Heading');
        ComboBox2.Items.Add('Lat');
        ComboBox2.Items.Add('Long');
        ComboBox2.Items.Add('Anzahl Daten');
        ComboBox2.Items.Add('Flugverfolgung');
        ComboBox2.Items.Add('Abflughafen');
        ComboBox2.Items.Add('Zielflughafen');
        ComboBox2.Text:=sort;
        h1:=ComboBox2.Items.IndexOf(sort);
        ComboBox2.ItemIndex:=h1;
        Button1.Visible:=False;
      end;
      if dart = 'Fluggesellschaften' then
      begin
        BLoe;
        Label26.Caption:='';
        Label15.Caption:='';
        Label16.Caption:='';
        Label23.Caption:='';
        Label11.Caption:='';
        Label17.Caption:='IATA:';
        Label24.Caption:='ICAO:';
        Label20.Caption:='';
        Label18.Caption:='';
        Label25.Caption:='';
        Label13.Caption:='';
        Label19.Caption:='';
        Label29.Caption:='';
        Label30.Caption:='';
        Label22.Caption:='';
        Label27.Caption:='';
        Label28.Caption:='Fluggesellschaft:';
        Label6.Caption:='Land:';
        Label7.Caption:='Rufzeichen:';
        Label8.Caption:='';
        Label9.Caption:='';
        sort:='Fluggesellschaft';
        ComboBox2.Text:='';
        ComboBox2.ItemIndex:=-1;
        ComboBox2.ItemHeight:=22;
        ComboBox2.Items.Clear;
        ComboBox2.Items.Add('Fluggesellschaft');
        ComboBox2.Items.Add('Land');
        ComboBox2.Items.Add('ICAO');
        ComboBox2.Text:=sort;
        h1:=ComboBox2.Items.IndexOf(sort);
        ComboBox2.ItemIndex:=h1;
        Button1.Visible:=True;
      end;
      if dart = 'ICAO Länder' then
      begin
        BLoe;
        Label26.Caption:='';
        Label15.Caption:='';
        Label16.Caption:='';
        Label23.Caption:='';
        Label11.Caption:='';
        Label17.Caption:='von HexID:';
        Label24.Caption:='bis HexID:';
        Label20.Caption:='';
        Label18.Caption:='';
        Label25.Caption:='';
        Label13.Caption:='';
        Label19.Caption:='';
        Label29.Caption:='';
        Label30.Caption:='';
        Label22.Caption:='';
        Label27.Caption:='';
        Label28.Caption:='';
        Label6.Caption:='Land:';
        Label7.Caption:='';
        Label8.Caption:='';
        Label9.Caption:='';
        sort:='von Hex-ID';
        ComboBox2.Text:='';
        ComboBox2.ItemIndex:=-1;
        ComboBox2.ItemHeight:=22;
        ComboBox2.Items.Clear;
        ComboBox2.Items.Add('von Hex-ID');
        ComboBox2.Items.Add('Land');
        ComboBox2.Text:=sort;
        h1:=ComboBox2.Items.IndexOf(sort);
        ComboBox2.ItemIndex:=h1;
        Button1.Visible:=True;
      end;
      if dart = 'Flugverfolgung' then
      begin
        BLoe;
        Label26.Caption:='';
        Label15.Caption:='ICAO-HexID:';
        Label16.Caption:='Datum/Zeit:';
        Label23.Caption:='';
        Label11.Caption:='Flugnummer:';
        Label17.Caption:='Höhe (m):';
        Label24.Caption:='';
        Label20.Caption:='Geschwindigkeit (Km/h):';
        Label18.Caption:='';
        Label25.Caption:='';
        Label13.Caption:='Richtung (°):';
        Label19.Caption:='';
        Label29.Caption:='Latitude (°):';
        Label30.Caption:='';
        Label22.Caption:='Longitude (°):';
        Label27.Caption:='';
        Label28.Caption:='';
        Label6.Caption:='';
        Label7.Caption:='';
        Label8.Caption:='';
        Label9.Caption:='';
        sort:='Flight';
        ComboBox2.Text:='';
        ComboBox2.ItemIndex:=-1;
        ComboBox2.ItemHeight:=22;
        ComboBox2.Items.Clear;
        ComboBox2.Items.Add('Hex_ID');
        ComboBox2.Items.Add('Datum und Zeit');
        ComboBox2.Items.Add('Flight');
        ComboBox2.Items.Add('Alt');
        ComboBox2.Items.Add('Speed');
        ComboBox2.Items.Add('Heading');
        ComboBox2.Items.Add('Lat');
        ComboBox2.Items.Add('Long');
        ComboBox2.Text:=sort;
        h1:=ComboBox2.Items.IndexOf(sort);
        ComboBox2.ItemIndex:=h1;
        Button1.Visible:=False;
      end;
      Laden;
    end else begin
      Label2.Caption:='Datenart muss ausgewählt werden';
      Form1.ActiveControl:=ComboBox1;
    end;
  end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if mtasts = 1 then
  begin
    Label2.Caption:='';
    ialpha:=ComboBox2.Text;
    Form1.Blankwegh;
    Form1.Blankwegv;
    if ialpha <> '' then
    begin
      sort:=ialpha;
      Laden;
    end else begin
      Label2.Caption:='Sortierung muss ausgewählt werden';
      Form1.ActiveControl:=ComboBox2;
    end;
  end;
end;

procedure TForm1.Edit10KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 10 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit10);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit10KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 10 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit10.ReadOnly:=True;
      Edit10.Color:=clSilver;
      Edit10.Font.Color:=clGray;
      Edit10.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        if inumkom > 0 then
        begin
          evlong:=inumkom;
          mlauf:=11;
          Edit11.Enabled:=True;
          Edit11.Color:=clYellow;
          Edit11.Font.Color:=clBlue;
          Edit11.ReadOnly:=False;
          Edit11.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit11.Text:=FloatToStr(eblong);
            inumkom:=eblong;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit11;
          Edit11.AutoSelect:=True;
        end else begin
          Label2.Caption:='von Longitude muß größer Null sein';
          Edit10.Enabled:=True;
          Edit10.Color:=clYellow;
          Edit10.Font.Color:=clBlue;
          Edit10.ReadOnly:=False;
          Edit10.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit10.Text:=FloatToStr(evlong);
            inumkom:=evlong;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit10;
          Edit10.AutoSelect:=True;
        end;
      end;
      if dart = 'Flugverfolgung' then
      begin
        if inumkom > 0 then
        begin
          evlong:=inumkom;
          JaNein:=messagedlg('Flugverfolgung ändern ?', mtConfirmation, [mbYes, mbNo], 0);
          if (JaNein = mrYes) then
          begin
            SqlRet:=True;
            herrmsg:='';
            feldalt:=aflight;
            feldneu:=eflight;
            Label2.Caption:=herrmsg;
            if feldalt <> feldneu then
            begin
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('UPDATE verfolgung SET flight=:fly WHERE hexid=:hex AND zeit=:von');
              Zquery2.ParamByName('fly').asString:=eflight;
              ZQuery2.ParamByName('hex').asString:=ehex;
              ZQuery2.ParamByName('von').asDateTime:=evzeit;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
            end;
            if SqlRet then
            begin
              SqlRet:=True;
              herrmsg:='';
              feldalt:=IntToStr(avalt);
              feldneu:=IntToStr(Round(evalt/0.3));
              Label2.Caption:=herrmsg;
              if feldalt <> feldneu then
              begin
                ZQuery2.SQL.Clear;
                ZQuery2.SQL.Add('UPDATE verfolgung SET alt=:alt WHERE hexid=:hex AND zeit=:von');
                ZQuery2.ParamByName('alt').asInteger:=Round(evalt/0.3);
                ZQuery2.ParamByName('hex').asString:=ehex;
                ZQuery2.ParamByName('von').asDateTime:=evzeit;
                try
                  ZQuery2.ExecSQL;
                except
                  on E: Exception do
                  begin
                    herrmsg:=E.Message;
                    SqlRet:=False;
                  end;
                end;
                if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                ZQuery2.Close;
              end;
              if SqlRet then
              begin
                SqlRet:=True;
                herrmsg:='';
                feldalt:=IntToStr(avspeed);
                feldneu:=IntToStr(Round(evspeed/1.852));
                Label2.Caption:=herrmsg;
                if feldalt <> feldneu then
                begin
                  ZQuery2.SQL.Clear;
                  ZQuery2.SQL.Add('UPDATE verfolgung SET speed=:spe WHERE hexid=:hex AND zeit=:von');
                  ZQuery2.ParamByName('spe').asInteger:=Round(evspeed/1.852);
                  ZQuery2.ParamByName('hex').asString:=ehex;
                  ZQuery2.ParamByName('von').asDateTime:=evzeit;
                  try
                    ZQuery2.ExecSQL;
                  except
                    on E: Exception do
                    begin
                      herrmsg:=E.Message;
                      SqlRet:=False;
                    end;
                  end;
                  if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                  ZQuery2.Close;
                end;
                if SqlRet then
                begin
                  SqlRet:=True;
                  herrmsg:='';
                  feldalt:=IntToStr(avhead);
                  feldneu:=IntToStr(evhead);
                  Label2.Caption:=herrmsg;
                  if feldalt <> feldneu then
                  begin
                    ZQuery2.SQL.Clear;
                    ZQuery2.SQL.Add('UPDATE verfolgung SET heading=:hea WHERE hexid=:hex AND zeit=:von');
                    ZQuery2.ParamByName('hea').asInteger:=evhead;
                    ZQuery2.ParamByName('hex').asString:=ehex;
                    ZQuery2.ParamByName('von').asDateTime:=evzeit;
                    try
                      ZQuery2.ExecSQL;
                    except
                      on E: Exception do
                      begin
                        herrmsg:=E.Message;
                        SqlRet:=False;
                      end;
                    end;
                    if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                    ZQuery2.Close;
                  end;
                  if SqlRet then
                  begin
                    SqlRet:=True;
                    herrmsg:='';
                    feldalt:=FloatToStr(avlat);
                    feldneu:=FloatToStr(evlat);
                    Label2.Caption:=herrmsg;
                    if feldalt <> feldneu then
                    begin
                      ZQuery2.SQL.Clear;
                      ZQuery2.SQL.Add('UPDATE verfolgung SET lat=:lat WHERE hexid=:hex AND zeit=:von');
                      Zquery2.ParamByName('lat').asFloat:=evlat;
                      ZQuery2.ParamByName('hex').asString:=ehex;
                      ZQuery2.ParamByName('von').asDateTime:=evzeit;
                      try
                        ZQuery2.ExecSQL;
                      except
                        on E: Exception do
                        begin
                          herrmsg:=E.Message;
                          SqlRet:=False;
                        end;
                      end;
                      if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                      ZQuery2.Close;
                    end;
                    if SqlRet then
                    begin
                      SqlRet:=True;
                      herrmsg:='';
                      feldalt:=FloatToStr(avlong);
                      feldneu:=FloatToStr(evlong);
                      Label2.Caption:=herrmsg;
                      if feldalt <> feldneu then
                      begin
                        ZQuery2.SQL.Clear;
                        ZQuery2.SQL.Add('UPDATE verfolgung SET longi=:lon WHERE hexid=:hex AND zeit=:von');
                        ZQuery2.ParamByName('lon').asFloat:=evlong;
                        ZQuery2.ParamByName('hex').asString:=ehex;
                        ZQuery2.ParamByName('von').asDateTime:=evzeit;
                        try
                          ZQuery2.ExecSQL;
                        except
                          on E: Exception do
                          begin
                            herrmsg:=E.Message;
                            SqlRet:=False;
                          end;
                        end;
                        if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                        ZQuery2.Close;
                      end;
                      if not SqlRet then
                      begin
                        Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugverfolgung';
                      end;
                    end else begin
                      Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugverfolgung';
                    end;
                  end else begin
                    Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugverfolgung';
                  end;
                end else begin
                  Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugverfolgung';
                end;
              end else begin
                Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugverfolgung';
              end;
            end;
          end;
          mtasts:=1;
          mlauf:=0;
          mart:=0;
          Combobox1.Enabled:=True;
          ComboBox1.Color:=clYellow;
          ComboBox1.Font.Color:=clBlue;
          Combobox2.Enabled:=True;
          ComboBox2.Color:=clYellow;
          ComboBox2.Font.Color:=clBlue;
          BLoe;
          Laden;
        end else begin
          Label2.Caption:='von Longitude muß größer Null sein';
          Edit10.Enabled:=True;
          Edit10.Color:=clYellow;
          Edit10.Font.Color:=clBlue;
          Edit10.ReadOnly:=False;
          Edit10.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit10.Text:=FloatToStr(evlong);
            inumkom:=evlong;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit10;
          Edit10.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit11KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 11 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit11);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit11KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 11 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit11.ReadOnly:=True;
      Edit11.Color:=clSilver;
      Edit11.Font.Color:=clGray;
      Edit11.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        if inumkom > 0 then
        begin
          eblong:=inumkom;
          mlauf:=15;
          Edit15.Enabled:=True;
          Edit15.Color:=clYellow;
          Edit15.Font.Color:=clBlue;
          Edit15.ReadOnly:=False;
          Edit15.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=5;
          ilanmax:=50;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit15.Text:=eabf;
            ialpha:=eabf;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit15;
          Edit15.AutoSelect:=True;
        end else begin
          Label2.Caption:='bis Longitude muß größer Null sein';
          Edit11.Enabled:=True;
          Edit11.Color:=clYellow;
          Edit11.Font.Color:=clBlue;
          Edit11.ReadOnly:=False;
          Edit11.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit11.Text:=FloatToStr(eblong);
            inumkom:=eblong;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit11;
          Edit11.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit12KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 12 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit12);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit12KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 12 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit12.ReadOnly:=True;
      Edit12.Color:=clSilver;
      Edit12.Font.Color:=clGray;
      Edit12.AutoSelect:=False;
      if dart = 'Fluggesellschaften' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        if ialpha <> '' then
        begin
          eflugg:=ialpha;
          mlauf:=13;
          Edit13.Enabled:=True;
          Edit13.Color:=clYellow;
          Edit13.Font.Color:=clBlue;
          Edit13.ReadOnly:=False;
          Edit13.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=5;
          ilanmax:=40;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit13.Text:=eland;
            ialpha:=eland;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit13;
          Edit13.AutoSelect:=True;
        end else begin
          Label2.Caption:='Fluggesellschaft muß eingegeben werden';
          Edit12.Enabled:=True;
          Edit12.Color:=clYellow;
          Edit12.Font.Color:=clBlue;
          Edit12.ReadOnly:=False;
          Edit12.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=5;
          ilanmax:=60;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit12.Text:=eflugg;
            ialpha:=eflugg;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit12;
          Edit12.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit13KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 13 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit13);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit13KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 13 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit13.ReadOnly:=True;
      Edit13.Color:=clSilver;
      Edit13.Font.Color:=clGray;
      Edit13.AutoSelect:=False;
      if dart = 'Fluggesellschaften' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        if ialpha <> '' then
        begin
          eland:=ialpha;
          mlauf:=14;
          Edit14.Enabled:=True;
          Edit14.Color:=clYellow;
          Edit14.Font.Color:=clBlue;
          Edit14.ReadOnly:=False;
          Edit14.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=5;
          ilanmax:=60;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit14.Text:=erufz;
            ialpha:=erufz;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit14;
          Edit14.AutoSelect:=True;
        end else begin
          Label2.Caption:='Land muß eingegeben werden';
          Edit13.Enabled:=True;
          Edit13.Color:=clYellow;
          Edit13.Font.Color:=clBlue;
          Edit13.ReadOnly:=False;
          Edit13.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=5;
          ilanmax:=40;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit13.Text:=eland;
            ialpha:=eland;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit13;
          Edit13.AutoSelect:=True;
        end;
      end;
      if dart = 'ICAO Länder' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        if ialpha <> '' then
        begin
          eland:=ialpha;
          if mart = 1 then
          begin
            JaNein:=messagedlg('ICAO Land anlegen ?', mtConfirmation, [mbYes, mbNo], 0);
            if (JaNein = mrYes) then
            begin
              SqlRet:=True;
              herrmsg:='';
              Label2.Caption:=herrmsg;
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('INSERT INTO icao (von, bis, Land) VALUES (:von, :bis, :lan)');
              ZQuery2.ParamByName('von').asString:=evhex;
              ZQuery2.ParamByName('bis').asString:=ebhex;
              ZQuery2.ParamByName('lan').asString:=eland;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
              if not SqlRet then
              begin
                Label2.Caption:=herrmsg+'  Fehler beim Anlegen ICAO Land';
              end;
            end;
          end else begin
            JaNein:=messagedlg('ICAO Land ändern ?', mtConfirmation, [mbYes, mbNo], 0);
            if (JaNein = mrYes) then
            begin
              SqlRet:=True;
              herrmsg:='';
              feldalt:=abhex;
              feldneu:=ebhex;
              Label2.Caption:=herrmsg;
              if feldalt <> feldneu then
              begin
                ZQuery2.SQL.Clear;
                ZQuery2.SQL.Add('UPDATE icao SET bis=:bis WHERE von=:von');
                ZQuery2.ParamByName('bis').asString:=ebhex;
                ZQuery2.ParamByName('von').asString:=evhex;
                try
                  ZQuery2.ExecSQL;
                except
                  on E: Exception do
                  begin
                    herrmsg:=E.Message;
                    SqlRet:=False;
                  end;
                end;
                if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                ZQuery2.Close;
              end;
              if SqlRet then
              begin
                SqlRet:=True;
                herrmsg:='';
                feldalt:=aland;
                feldneu:=eland;
                Label2.Caption:=herrmsg;
                if feldalt <> feldneu then
                begin
                  ZQuery2.SQL.Clear;
                  ZQuery2.SQL.Add('UPDATE icao SET land=:lan WHERE von=:von');
                  ZQuery2.ParamByName('lan').asString:=eland;
                  ZQuery2.ParamByName('von').asString:=evhex;
                  try
                    ZQuery2.ExecSQL;
                  except
                    on E: Exception do
                    begin
                      herrmsg:=E.Message;
                      SqlRet:=False;
                    end;
                  end;
                  if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                  ZQuery2.Close;
                end;
                if not SqlRet then
                begin
                  Label2.Caption:=herrmsg+'  Fehler beim Ändern ICAO Land';
                end;
              end else begin
                Label2.Caption:=herrmsg+'  Fehler beim Ändern ICAO Land';
              end;
            end;
          end;
          mtasts:=1;
          mlauf:=0;
          mart:=0;
          Combobox1.Enabled:=True;
          ComboBox1.Color:=clYellow;
          ComboBox1.Font.Color:=clBlue;
          Combobox2.Enabled:=True;
          ComboBox2.Color:=clYellow;
          ComboBox2.Font.Color:=clBlue;
          BLoe;
          Laden;
        end else begin
          Label2.Caption:='Land muß eingegeben werden';
          Edit13.Enabled:=True;
          Edit13.Color:=clYellow;
          Edit13.Font.Color:=clBlue;
          Edit13.ReadOnly:=False;
          Edit13.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=5;
          ilanmax:=40;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit13.Text:=eland;
            ialpha:=eland;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit13;
          Edit13.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit14KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 14 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit14);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit14KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 14 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit14.ReadOnly:=True;
      Edit14.Color:=clSilver;
      Edit14.Font.Color:=clGray;
      Edit14.AutoSelect:=False;
      if dart = 'Fluggesellschaften' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        erufz:=ialpha;
        if mart = 1 then
        begin
          JaNein:=messagedlg('Fluggesellschaft anlegen ?', mtConfirmation, [mbYes, mbNo], 0);
          if (JaNein = mrYes) then
          begin
            SqlRet:=True;
            herrmsg:='';
            Label2.Caption:=herrmsg;
            ZQuery2.SQL.Clear;
            ZQuery2.SQL.Add('INSERT INTO flightclub (name, iata, icao, rufzeichen, land) VALUES (:nam, :iat, :ica, :ruf, :lan)');
            ZQuery2.ParamByName('nam').asString:=eflugg;
            ZQuery2.ParamByName('iat').asString:=eiata;
            ZQuery2.ParamByName('ica').asString:=eicao;
            ZQuery2.ParamByName('ruf').asString:=erufz;
            ZQuery2.ParamByName('lan').asString:=eland;
            try
              ZQuery2.ExecSQL;
            except
              on E: Exception do
              begin
                herrmsg:=E.Message;
                SqlRet:=False;
              end;
            end;
            if ZQuery2.RowsAffected = 0 then SqlRet:=False;
            ZQuery2.Close;
            if not SqlRet then
            begin
              Label2.Caption:=herrmsg+'  Fehler beim Anlegen Fluggesellschaft';
            end;
          end;
        end else begin
          JaNein:=messagedlg('Fluggesellschaft ändern ?', mtConfirmation, [mbYes, mbNo], 0);
          if (JaNein = mrYes) then
          begin
            SqlRet:=True;
            herrmsg:='';
            feldalt:=aflugg;
            feldneu:=eflugg;
            Label2.Caption:=herrmsg;
            if feldalt <> feldneu then
            begin
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('UPDATE flightclub SET name=:nam WHERE icao=:ica');
              ZQuery2.ParamByName('nam').asString:=eflugg;
              ZQuery2.ParamByName('ica').asString:=eicao;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
            end;
            if SqlRet then
            begin
              SqlRet:=True;
              herrmsg:='';
              feldalt:=aiata;
              feldneu:=eiata;
              Label2.Caption:=herrmsg;
              if feldalt <> feldneu then
              begin
                ZQuery2.SQL.Clear;
                ZQuery2.SQL.Add('UPDATE flightclub SET iata=:nam WHERE icao=:ica');
                ZQuery2.ParamByName('nam').asString:=eiata;
                ZQuery2.ParamByName('ica').asString:=eicao;
                try
                  ZQuery2.ExecSQL;
                except
                  on E: Exception do
                  begin
                    herrmsg:=E.Message;
                    SqlRet:=False;
                  end;
                end;
                if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                ZQuery2.Close;
              end;
              if SqlRet then
              begin
                SqlRet:=True;
                herrmsg:='';
                feldalt:=arufz;
                feldneu:=erufz;
                Label2.Caption:=herrmsg;
                if feldalt <> feldneu then
                begin
                  ZQuery2.SQL.Clear;
                  ZQuery2.SQL.Add('UPDATE flightclub SET rufzeichen=:nam WHERE icao=:ica');
                  ZQuery2.ParamByName('nam').asString:=erufz;
                  ZQuery2.ParamByName('ica').asString:=eicao;
                  try
                    ZQuery2.ExecSQL;
                  except
                    on E: Exception do
                    begin
                      herrmsg:=E.Message;
                      SqlRet:=False;
                    end;
                  end;
                  if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                  ZQuery2.Close;
                end;
                if SqlRet then
                begin
                  SqlRet:=True;
                  herrmsg:='';
                  feldalt:=aland;
                  feldneu:=eland;
                  Label2.Caption:=herrmsg;
                  if feldalt <> feldneu then
                  begin
                    ZQuery2.SQL.Clear;
                    ZQuery2.SQL.Add('UPDATE flightclub SET land=:nam WHERE icao=:ica');
                    ZQuery2.ParamByName('nam').asString:=eland;
                    ZQuery2.ParamByName('ica').asString:=eicao;
                    try
                      ZQuery2.ExecSQL;
                    except
                      on E: Exception do
                      begin
                        herrmsg:=E.Message;
                        SqlRet:=False;
                      end;
                    end;
                    if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                    ZQuery2.Close;
                  end;
                  if not SqlRet then
                  begin
                    Label2.Caption:=herrmsg+'  Fehler beim Ändern Fluggesellschaft';
                  end;
                end else begin
                  Label2.Caption:=herrmsg+'  Fehler beim Ändern Fluggesellschaft';
                end;
              end else begin
                Label2.Caption:=herrmsg+'  Fehler beim Ändern Fluggesellschaft';
              end;
            end else begin
              Label2.Caption:=herrmsg+'  Fehler beim Ändern Fluggesellschaft';
            end;
          end;
        end;
        mtasts:=1;
        mlauf:=0;
        mart:=0;
        Combobox1.Enabled:=True;
        ComboBox1.Color:=clYellow;
        ComboBox1.Font.Color:=clBlue;
        Combobox2.Enabled:=True;
        ComboBox2.Color:=clYellow;
        ComboBox2.Font.Color:=clBlue;
        BLoe;
        Laden;
      end;
    end;
  end;
end;

procedure TForm1.Edit15KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 15 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit15);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit15KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 15 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit15.ReadOnly:=True;
      Edit15.Color:=clSilver;
      Edit15.Font.Color:=clGray;
      Edit15.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        eabf:=ialpha;
        mlauf:=16;
        Edit16.Enabled:=True;
        Edit16.Color:=clYellow;
        Edit16.Font.Color:=clBlue;
        Edit16.ReadOnly:=False;
        Edit16.Text:='';
        ialpha:='';
        inummer:=0;
        iart:=2;
        inumkom:=0;
        ikomma:=0;
        izeich:=3;
        istell:=0;
        ifunc:=5;
        ilanmax:=50;
        ilanmin:=1;
        iautocr:=1;
        if mart = 2 then
        begin
          Edit16.Text:=ezif;
          ialpha:=ezif;
          iart:=1;
        end;
        Form1.ActiveControl:=Edit16;
        Edit16.AutoSelect:=True;
      end;
    end;
  end;
end;

procedure TForm1.Edit16KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 16 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit16);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit16KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 16 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit16.ReadOnly:=True;
      Edit16.Color:=clSilver;
      Edit16.Font.Color:=clGray;
      Edit16.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        ezif:=ialpha;
        if mart = 2 then
        begin
          JaNein:=messagedlg('Flugdaten ändern ?', mtConfirmation, [mbYes, mbNo], 0);
          if (JaNein = mrYes) then
          begin
            SqlRet:=True;
            herrmsg:='';
            feldalt:=aflight;
            feldneu:=eflight;
            Label2.Caption:=herrmsg;
            if feldalt <> feldneu then
            begin
              ZQuery2.SQL.Clear;
              ZQuery2.SQL.Add('UPDATE flight SET flight=:fly WHERE hexid=:hex AND vonzeit=:von');
              ZQuery2.ParamByName('fly').asString:=eflight;
              ZQuery2.ParamByName('hex').asString:=ehex;
              ZQuery2.ParamByName('von').asDateTime:=evzeit;
              try
                ZQuery2.ExecSQL;
              except
                on E: Exception do
                begin
                  herrmsg:=E.Message;
                  SqlRet:=False;
                end;
              end;
              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
              ZQuery2.Close;
            end;
            if SqlRet then
            begin
              SqlRet:=True;
              herrmsg:='';
              feldalt:=IntToStr(avalt);
              feldneu:=IntToStr(Round(evalt/0.3));
              Label2.Caption:=herrmsg;
              if feldalt <> feldneu then
              begin
                ZQuery2.SQL.Clear;
                ZQuery2.SQL.Add('UPDATE flight SET valt=:alt WHERE hexid=:hex AND vonzeit=:von');
                ZQuery2.ParamByName('alt').asInteger:=Round(evalt/0.3);
                ZQuery2.ParamByName('hex').asString:=ehex;
                ZQuery2.ParamByName('von').asDateTime:=evzeit;
                try
                  ZQuery2.ExecSQL;
                except
                  on E: Exception do
                  begin
                    herrmsg:=E.Message;
                    SqlRet:=False;
                  end;
                end;
                if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                ZQuery2.Close;
              end;
              if SqlRet then
              begin
                SqlRet:=True;
                herrmsg:='';
                feldalt:=IntToStr(abalt);
                feldneu:=IntToStr(Round(ebalt/0.3));
                Label2.Caption:=herrmsg;
                if feldalt <> feldneu then
                begin
                  ZQuery2.SQL.Clear;
                  ZQuery2.SQL.Add('UPDATE flight SET balt=:alt WHERE hexid=:hex AND vonzeit=:von');
                  ZQuery2.ParamByName('alt').asInteger:=Round(ebalt/0.3);
                  ZQuery2.ParamByName('hex').asString:=ehex;
                  ZQuery2.ParamByName('von').asDateTime:=evzeit;
                  try
                    ZQuery2.ExecSQL;
                  except
                    on E: Exception do
                    begin
                      herrmsg:=E.Message;
                      SqlRet:=False;
                    end;
                  end;
                  if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                  ZQuery2.Close;
                end;
                if SqlRet then
                begin
                  SqlRet:=True;
                  herrmsg:='';
                  feldalt:=IntToStr(avspeed);
                  feldneu:=IntToStr(Round(evspeed/1.852));
                  Label2.Caption:=herrmsg;
                  if feldalt <> feldneu then
                  begin
                    ZQuery2.SQL.Clear;
                    ZQuery2.SQL.Add('UPDATE flight SET vspeed=:spe WHERE hexid=:hex AND vonzeit=:von');
                    ZQuery2.ParamByName('spe').asInteger:=Round(evspeed/1.852);
                    ZQuery2.ParamByName('hex').asString:=ehex;
                    ZQuery2.ParamByName('von').asDateTime:=evzeit;
                    try
                      ZQuery2.ExecSQL;
                    except
                      on E: Exception do
                      begin
                        herrmsg:=E.Message;
                        SqlRet:=False;
                      end;
                    end;
                    if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                    ZQuery2.Close;
                  end;
                  if SqlRet then
                  begin
                    SqlRet:=True;
                    herrmsg:='';
                    feldalt:=IntToStr(abspeed);
                    feldneu:=IntToStr(Round(ebspeed/1.852));
                    Label2.Caption:=herrmsg;
                    if feldalt <> feldneu then
                    begin
                      ZQuery2.SQL.Clear;
                      ZQuery2.SQL.Add('UPDATE flight SET bspeed=:spe WHERE hexid=:hex AND vonzeit=:von');
                      ZQuery2.ParamByName('spe').asInteger:=Round(ebspeed/1.852);
                      ZQuery2.ParamByName('hex').asString:=ehex;
                      ZQuery2.ParamByName('von').asDateTime:=evzeit;
                      try
                        ZQuery2.ExecSQL;
                      except
                        on E: Exception do
                        begin
                          herrmsg:=E.Message;
                          SqlRet:=False;
                        end;
                      end;
                      if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                      ZQuery2.Close;
                    end;
                    if SqlRet then
                    begin
                      SqlRet:=True;
                      herrmsg:='';
                      feldalt:=IntToStr(avhead);
                      feldneu:=IntToStr(evhead);
                      Label2.Caption:=herrmsg;
                      if feldalt <> feldneu then
                      begin
                        ZQuery2.SQL.Clear;
                        ZQuery2.SQL.Add('UPDATE flight SET vheading=:hea WHERE hexid=:hex AND vonzeit=:von');
                        ZQuery2.ParamByName('hea').asInteger:=evhead;
                        ZQuery2.ParamByName('hex').asString:=ehex;
                        ZQuery2.ParamByName('von').asDateTime:=evzeit;
                        try
                          ZQuery2.ExecSQL;
                        except
                          on E: Exception do
                          begin
                            herrmsg:=E.Message;
                            SqlRet:=False;
                          end;
                        end;
                        if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                        ZQuery2.Close;
                      end;
                      if SqlRet then
                      begin
                        SqlRet:=True;
                        herrmsg:='';
                        feldalt:=IntToStr(abhead);
                        feldneu:=IntToStr(ebhead);
                        Label2.Caption:=herrmsg;
                        if feldalt <> feldneu then
                        begin
                          ZQuery2.SQL.Clear;
                          ZQuery2.SQL.Add('UPDATE flight SET bheading=:hea WHERE hexid=:hex AND vonzeit=:von');
                          ZQuery2.ParamByName('hea').asInteger:=ebhead;
                          ZQuery2.ParamByName('hex').asString:=ehex;
                          ZQuery2.ParamByName('von').asDateTime:=evzeit;
                          try
                            ZQuery2.ExecSQL;
                          except
                            on E: Exception do
                            begin
                              herrmsg:=E.Message;
                              SqlRet:=False;
                            end;
                          end;
                          if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                          ZQuery2.Close;
                        end;
                        if SqlRet then
                        begin
                          SqlRet:=True;
                          herrmsg:='';
                          feldalt:=FloatToStr(avlat);
                          feldneu:=FloatToStr(evlat);
                          Label2.Caption:=herrmsg;
                          if feldalt <> feldneu then
                          begin
                            ZQuery2.SQL.Clear;
                            ZQuery2.SQL.Add('UPDATE flight SET vlat=:lat WHERE hexid=:hex AND vonzeit=:von');
                            ZQuery2.ParamByName('lat').asFloat:=evlat;
                            ZQuery2.ParamByName('hex').asString:=ehex;
                            ZQuery2.ParamByName('von').asDateTime:=evzeit;
                            try
                              ZQuery2.ExecSQL;
                            except
                              on E: Exception do
                              begin
                                herrmsg:=E.Message;
                                SqlRet:=False;
                              end;
                            end;
                            if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                            ZQuery2.Close;
                          end;
                          if SqlRet then
                          begin
                            SqlRet:=True;
                            herrmsg:='';
                            feldalt:=FloatToStr(ablat);
                            feldneu:=FloatToStr(eblat);
                            Label2.Caption:=herrmsg;
                            if feldalt <> feldneu then
                            begin
                              ZQuery2.SQL.Clear;
                              ZQuery2.SQL.Add('UPDATE flight SET blat=:lat WHERE hexid=:hex AND vonzeit=:von');
                              ZQuery2.ParamByName('lat').asFloat:=eblat;
                              ZQuery2.ParamByName('hex').asString:=ehex;
                              ZQuery2.ParamByName('von').asDateTime:=evzeit;
                              try
                                ZQuery2.ExecSQL;
                              except
                                on E: Exception do
                                begin
                                  herrmsg:=E.Message;
                                  SqlRet:=False;
                                end;
                              end;
                              if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                              ZQuery2.Close;
                            end;
                            if SqlRet then
                            begin
                              SqlRet:=True;
                              herrmsg:='';
                              feldalt:=FloatToStr(avlong);
                              feldneu:=FloatToStr(evlong);
                              Label2.Caption:=herrmsg;
                              if feldalt <> feldneu then
                              begin
                                ZQuery2.SQL.Clear;
                                ZQuery2.SQL.Add('UPDATE flight SET vlong=:lon WHERE hexid=:hex AND vonzeit=:von');
                                ZQuery2.ParamByName('lon').asFloat:=evlong;
                                ZQuery2.ParamByName('hex').asString:=ehex;
                                ZQuery2.ParamByName('von').asDateTime:=evzeit;
                                try
                                  ZQuery2.ExecSQL;
                                except
                                  on E: Exception do
                                  begin
                                    herrmsg:=E.Message;
                                    SqlRet:=False;
                                  end;
                                end;
                                if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                                ZQuery2.Close;
                              end;
                              if SqlRet then
                              begin
                                SqlRet:=True;
                                herrmsg:='';
                                feldalt:=FloatToStr(ablong);
                                feldneu:=FloatToStr(eblong);
                                Label2.Caption:=herrmsg;
                                if feldalt <> feldneu then
                                begin
                                  ZQuery2.SQL.Clear;
                                  ZQuery2.SQL.Add('UPDATE flight SET blong=:lon WHERE hexid=:hex AND vonzeit=:von');
                                  ZQuery2.ParamByName('lon').asFloat:=eblong;
                                  ZQuery2.ParamByName('hex').asString:=ehex;
                                  ZQuery2.ParamByName('von').asDateTime:=evzeit;
                                  try
                                    ZQuery2.ExecSQL;
                                  except
                                    on E: Exception do
                                    begin
                                      herrmsg:=E.Message;
                                      SqlRet:=False;
                                    end;
                                  end;
                                  if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                                  ZQuery2.Close;
                                end;
                                if SqlRet then
                                begin
                                  SqlRet:=True;
                                  herrmsg:='';
                                  feldalt:=aabf;
                                  feldneu:=eabf;
                                  Label2.Caption:=herrmsg;
                                  if feldalt <> feldneu then
                                  begin
                                    ZQuery2.SQL.Clear;
                                    ZQuery2.SQL.Add('UPDATE flight SET von=:abf WHERE hexid=:hex AND vonzeit=:von');
                                    ZQuery2.ParamByName('abf').asString:=eabf;
                                    ZQuery2.ParamByName('hex').asString:=ehex;
                                    ZQuery2.ParamByName('von').asDateTime:=evzeit;
                                    try
                                      ZQuery2.ExecSQL;
                                    except
                                      on E: Exception do
                                      begin
                                        herrmsg:=E.Message;
                                        SqlRet:=False;
                                      end;
                                    end;
                                    if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                                    ZQuery2.Close;
                                  end;
                                  if SqlRet then
                                  begin
                                    SqlRet:=True;
                                    herrmsg:='';
                                    feldalt:=azif;
                                    feldneu:=ezif;
                                    Label2.Caption:=herrmsg;
                                    if feldalt <> feldneu then
                                    begin
                                      ZQuery2.SQL.Clear;
                                      ZQuery2.SQL.Add('UPDATE flight SET nach=:zif WHERE hexid=:hex AND vonzeit=:von');
                                      ZQuery2.ParamByName('zif').asString:=ezif;
                                      ZQuery2.ParamByName('hex').asString:=ehex;
                                      ZQuery2.ParamByName('von').asDateTime:=evzeit;
                                      try
                                        ZQuery2.ExecSQL;
                                      except
                                        on E: Exception do
                                        begin
                                          herrmsg:=E.Message;
                                          SqlRet:=False;
                                        end;
                                      end;
                                      if ZQuery2.RowsAffected = 0 then SqlRet:=False;
                                      ZQuery2.Close;
                                    end;
                                    if not SqlRet then
                                    begin
                                      Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                                    end;
                                  end else begin
                                    Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                                  end;
                                end else begin
                                  Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                                end;
                              end else begin
                                Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                              end;
                            end else begin
                              Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                            end;
                          end else begin
                            Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                          end;
                        end else begin
                          Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                        end;
                      end else begin
                        Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                      end;
                    end else begin
                      Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                    end;
                  end else begin
                    Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                  end;
                end else begin
                  Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
                end;
              end else begin
                Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
              end;
            end else begin
              Label2.Caption:=herrmsg+'  Fehler beim Ändern Flugdaten';
            end;
          end;
        end;
        mtasts:=1;
        mlauf:=0;
        mart:=0;
        Combobox1.Enabled:=True;
        ComboBox1.Color:=clYellow;
        ComboBox1.Font.Color:=clBlue;
        Combobox2.Enabled:=True;
        ComboBox2.Color:=clYellow;
        ComboBox2.Font.Color:=clBlue;
        BLoe;
        Laden;
      end;
    end;
  end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 1 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit1);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  var h1: integer;
  var he: string;
  var hf: string;
  var hg: string;
  var hh: string;
  var hi: integer;
  var hn: integer;
  var ho: integer;
  var hu: integer;
  var hv: integer;
  var hw: integer;
  var hx: string;
  var hy: string;
  var hz: string;
begin
  if mlauf = 1 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit1.ReadOnly:=True;
      Edit1.Color:=clSilver;
      Edit1.Font.Color:=clGray;
      Edit1.AutoSelect:=False;
      if ((dart = 'Flugdaten') or (dart = 'Flugverfolgung')) then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        if ialpha <> '' then
        begin
          h1:=Length(ialpha);
          if h1 > 2 then
          begin
            he:='';
            hf:='';
            hg:=ialpha;
            hi:=Length(hg);
            ialpha:=ehex;
            Hexum;
            hu:=inummer;
            hh:=Copy(ialpha,1,3);
            hn:=0;
            hh:=Copy(hg,1,3);
            ialpha:=hg;
            Privflug;
            if inummer = 1 then
            begin
              hh:='001';
            end else begin
              ho:=0;
              ialpha:=Copy(hg,1,1);
              inummer:=1;
              Nummer;
              hi:=Length(ialpha);
              ialpha:=hg;
              if hi > 0 then
              begin
                ho:=1;
              end else begin
                ialpha:=Copy(hg,2,1);
                inummer:=1;
                Nummer;
                hi:=Length(ialpha);
                ialpha:=hg;
                if hi > 0 then
                begin
                  ho:=1;
                end;
              end;
              if ho = 1 then
              begin
                hh:='002';
              end;
            end;
            h1:=0;
            Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
            Form1.ZQuery1.ParamByName('ica').asString:=hh;
            Form1.ZQuery1.Open;
            while not Form1.ZQuery1.EOF do
            begin
              h1:=h1+1;
              eflugg:=Form1.ZQuery1.Fields[0].AsString;
              eland:=Form1.ZQuery1.Fields[4].AsString;
              Form1.ZQuery1.Next;
            end;
            Form1.ZQuery1.Close;
            if h1 > 0 then
            begin
              eflight:=ialpha;
              if dart = 'Flugdaten' then
              begin
                Edit12.Text:=eflugg;
                Edit13.Text:=eland;
              end;
              mlauf:=2;
              Edit2.Enabled:=True;
              Edit2.Color:=clYellow;
              Edit2.Font.Color:=clBlue;
              Edit2.ReadOnly:=False;
              Edit2.Text:='';
              ialpha:='';
              inummer:=0;
              iart:=2;
              inumkom:=0;
              ikomma:=0;
              izeich:=3;
              istell:=0;
              ifunc:=1;
              ilanmax:=6;
              ilanmin:=1;
              iautocr:=1;
              if mart = 2 then
              begin
                Edit2.Text:=IntToStr(evalt);
                inummer:=evalt;
                iart:=1;
              end;
              Form1.ActiveControl:=Edit2;
              Edit2.AutoSelect:=True;
            end else begin
              Label2.Caption:='Flight nicht in Fluggesellschaftentabelle (flightclub) vorhanden, Abbruch';
              mtasts:=1;
              mlauf:=0;
              mart:=0;
              Combobox1.Enabled:=True;
              ComboBox1.Color:=clYellow;
              ComboBox1.Font.Color:=clBlue;
              Combobox2.Enabled:=True;
              ComboBox2.Color:=clYellow;
              ComboBox2.Font.Color:=clBlue;
              BLoe;
            end;
          end else begin
            Label2.Caption:='Flight muss mindestens 3-stellig sein';
            Edit1.Enabled:=True;
            Edit1.Color:=clYellow;
            Edit1.Font.Color:=clBlue;
            Edit1.ReadOnly:=False;
            Edit1.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=2;
            istell:=0;
            ifunc:=5;
            ilanmax:=8;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit1.Text:=eflight;
              ialpha:=eflight;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit1;
            Edit1.AutoSelect:=True;
          end;
        end else begin
          Label2.Caption:='Flight muß eingegeben werden';
          Edit1.Enabled:=True;
          Edit1.Color:=clYellow;
          Edit1.Font.Color:=clBlue;
          Edit1.ReadOnly:=False;
          Edit1.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=2;
          istell:=0;
          ifunc:=5;
          ilanmax:=8;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit1.Text:=eflight;
            ialpha:=eflight;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit1;
          Edit1.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 2 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit2);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  var h1: integer;
  var h2: string;
begin
  if mlauf = 2 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit2.ReadOnly:=True;
      Edit2.Color:=clSilver;
      Edit2.Font.Color:=clGray;
      Edit2.AutoSelect:=False;
      if ((dart = 'Flugdaten') or (dart = 'Flugverfolgung')) then
      begin
        if inummer > 0 then
        begin
          evalt:=inummer;
          if dart = 'Flugdaten' then
          begin
            mlauf:=3;
            Edit3.Enabled:=True;
            Edit3.Color:=clYellow;
            Edit3.Font.Color:=clBlue;
            Edit3.ReadOnly:=False;
            Edit3.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=3;
            istell:=0;
            ifunc:=1;
            ilanmax:=6;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit3.Text:=IntToStr(ebalt);
              inummer:=ebalt;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit3;
            Edit3.AutoSelect:=True;
          end;
          if dart = 'Flugverfolgung' then
          begin
            mlauf:=4;
            Edit4.Enabled:=True;
            Edit4.Color:=clYellow;
            Edit4.Font.Color:=clBlue;
            Edit4.ReadOnly:=False;
            Edit4.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=3;
            istell:=0;
            ifunc:=1;
            ilanmax:=4;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit4.Text:=IntToStr(evspeed);
              inummer:=evspeed;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit4;
            Edit4.AutoSelect:=True;
          end;
        end else begin
          Label2.Caption:='von Höhe muß größer Null sein';
          Edit2.Enabled:=True;
          Edit2.Color:=clYellow;
          Edit2.Font.Color:=clBlue;
          Edit2.ReadOnly:=False;
          Edit2.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=1;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit2.Text:=IntToStr(evalt);
            inummer:=evalt;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit2;
          Edit2.AutoSelect:=True;
        end;
      end;
      if dart = 'Fluggesellschaften' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        eiata:=ialpha;
        if mart = 1 then
        begin
          mlauf:=3;
          Edit3.Enabled:=True;
          Edit3.Color:=clYellow;
          Edit3.Font.Color:=clBlue;
          Edit3.ReadOnly:=False;
          Edit3.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=2;
          istell:=0;
          ifunc:=5;
          ilanmax:=3;
          ilanmin:=1;
          iautocr:=1;
          Form1.ActiveControl:=Edit3;
          Edit3.AutoSelect:=True;
        end else begin
          mlauf:=12;
          Edit12.Enabled:=True;
          Edit12.Color:=clYellow;
          Edit12.Font.Color:=clBlue;
          Edit12.ReadOnly:=False;
          Edit12.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=5;
          ilanmax:=60;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit12.Text:=eflugg;
            ialpha:=eflugg;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit12;
          Edit12.AutoSelect:=True;
        end;
      end;
      if dart = 'ICAO Länder' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        if ialpha <> '' then
        begin
          h2:=ialpha;
          Hexum;
          if inummer > 0 then
          begin
            h1:=0;
            Form1.ZQuery3.SQL.Text:='SELECT * FROM icao WHERE von=:von';
            Form1.ZQuery3.ParamByName('von').asString:=h2;
            Form1.ZQuery3.Open;
            while not Form1.ZQuery3.EOF do
            begin
              h1:=1;
              Form1.ZQuery3.Next;
            end;
            Form1.ZQuery3.Close;
            if h1 = 0 then
            begin
              evhex:=h2;
              mlauf:=3;
              Edit3.Enabled:=True;
              Edit3.Color:=clYellow;
              Edit3.Font.Color:=clBlue;
              Edit3.ReadOnly:=False;
              Edit3.Text:='';
              ialpha:='';
              inummer:=0;
              iart:=2;
              inumkom:=0;
              ikomma:=0;
              izeich:=2;
              istell:=0;
              ifunc:=5;
              ilanmax:=6;
              ilanmin:=1;
              iautocr:=1;
              Form1.ActiveControl:=Edit3;
              Edit3.AutoSelect:=True;
            end else begin
              Label2.Caption:='von Hex-ID schon vorhanden, Abbruch';
              mtasts:=1;
              mlauf:=0;
              mart:=0;
              Combobox1.Enabled:=True;
              ComboBox1.Color:=clYellow;
              ComboBox1.Font.Color:=clBlue;
              Combobox2.Enabled:=True;
              ComboBox2.Color:=clYellow;
              ComboBox2.Font.Color:=clBlue;
              BLoe;
            end;
          end else begin
            Label2.Caption:='von Hex-ID muß eine Hexadezimalzahl sein';
            Edit2.Enabled:=True;
            Edit2.Color:=clYellow;
            Edit2.Font.Color:=clBlue;
            Edit2.ReadOnly:=False;
            Edit2.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=2;
            istell:=0;
            ifunc:=5;
            ilanmax:=6;
            ilanmin:=1;
            iautocr:=1;
            Form1.ActiveControl:=Edit2;
            Edit2.AutoSelect:=True;
          end;
        end else begin
          Label2.Caption:='von Hex-ID muß eingegeben werden';
          Edit2.Enabled:=True;
          Edit2.Color:=clYellow;
          Edit2.Font.Color:=clBlue;
          Edit2.ReadOnly:=False;
          Edit2.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=2;
          istell:=0;
          ifunc:=5;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          Form1.ActiveControl:=Edit2;
          Edit2.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit3KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 3 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit3);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit3KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  var h1: integer;
  var h2: string;
begin
  if mlauf = 3 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit3.ReadOnly:=True;
      Edit3.Color:=clSilver;
      Edit3.Font.Color:=clGray;
      Edit3.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        if inummer > 0 then
        begin
          ebalt:=inummer;
          mlauf:=4;
          Edit4.Enabled:=True;
          Edit4.Color:=clYellow;
          Edit4.Font.Color:=clBlue;
          Edit4.ReadOnly:=False;
          Edit4.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=1;
          ilanmax:=4;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit4.Text:=IntToStr(evspeed);
            inummer:=evspeed;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit4;
          Edit4.AutoSelect:=True;
        end else begin
          Label2.Caption:='bis Höhe muß größer Null sein';
          Edit3.Enabled:=True;
          Edit3.Color:=clYellow;
          Edit3.Font.Color:=clBlue;
          Edit3.ReadOnly:=False;
          Edit3.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=1;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit3.Text:=IntToStr(ebalt);
            inummer:=ebalt;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit3;
          Edit3.AutoSelect:=True;
        end;
      end;
      if dart = 'Fluggesellschaften' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        if ialpha <> '' then
        begin
          h1:=0;
          Form1.ZQuery3.SQL.Text:='SELECT * FROM flightclub WHERE icao=:von';
          Form1.ZQuery3.ParamByName('von').asString:=ialpha;
          Form1.ZQuery3.Open;
          while not Form1.ZQuery3.EOF do
          begin
            h1:=1;
            Form1.ZQuery3.Next;
          end;
          Form1.ZQuery3.Close;
          if h1 = 0 then
          begin
            eicao:=ialpha;
            mlauf:=12;
            Edit12.Enabled:=True;
            Edit12.Color:=clYellow;
            Edit12.Font.Color:=clBlue;
            Edit12.ReadOnly:=False;
            Edit12.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=3;
            istell:=0;
            ifunc:=5;
            ilanmax:=60;
            ilanmin:=1;
            iautocr:=1;
            Form1.ActiveControl:=Edit12;
            Edit12.AutoSelect:=True;
          end else begin
            Label2.Caption:='ICAI-ID schon vorhanden, Abbruch';
            mtasts:=1;
            mlauf:=0;
            mart:=0;
            Combobox1.Enabled:=True;
            ComboBox1.Color:=clYellow;
            ComboBox1.Font.Color:=clBlue;
            Combobox2.Enabled:=True;
            ComboBox2.Color:=clYellow;
            ComboBox2.Font.Color:=clBlue;
            BLoe;
          end;
        end else begin
          Label2.Caption:='ICAO-ID muß eingegeben werden';
          Edit3.Enabled:=True;
          Edit3.Color:=clYellow;
          Edit3.Font.Color:=clBlue;
          Edit3.ReadOnly:=False;
          Edit3.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=2;
          istell:=0;
          ifunc:=5;
          ilanmax:=3;
          ilanmin:=1;
          iautocr:=1;
          Form1.ActiveControl:=Edit3;
          Edit3.AutoSelect:=True;
        end;
      end;
      if dart = 'ICAO Länder' then
      begin
        Form1.Blankwegh;
        Form1.Blankwegv;
        if ialpha <> '' then
        begin
          Hexum;
          if inummer > 0 then
          begin
            h1:=inummer;
            h2:=ialpha;
            ialpha:=evhex;
            Hexum;
            if h1 > inummer then
            begin
              ebhex:=h2;
              mlauf:=13;
              Edit13.Enabled:=True;
              Edit13.Color:=clYellow;
              Edit13.Font.Color:=clBlue;
              Edit13.ReadOnly:=False;
              Edit13.Text:='';
              ialpha:='';
              inummer:=0;
              iart:=2;
              inumkom:=0;
              ikomma:=0;
              izeich:=3;
              istell:=0;
              ifunc:=5;
              ilanmax:=40;
              ilanmin:=1;
              iautocr:=1;
              if mart = 2 then
              begin
                Edit13.Text:=eland;
                ialpha:=eland;
                iart:=1;
              end;
              Form1.ActiveControl:=Edit13;
              Edit13.AutoSelect:=True;
            end else begin
              Label2.Caption:='bis Hex-ID muß größer von Hex-ID sein';
              Edit3.Enabled:=True;
              Edit3.Color:=clYellow;
              Edit3.Font.Color:=clBlue;
              Edit3.ReadOnly:=False;
              Edit3.Text:='';
              ialpha:='';
              inummer:=0;
              iart:=2;
              inumkom:=0;
              ikomma:=0;
              izeich:=2;
              istell:=0;
              ifunc:=5;
              ilanmax:=6;
              ilanmin:=1;
              iautocr:=1;
              if mart = 2 then
              begin
                Edit3.Text:=ebhex;
                ialpha:=ebhex;
                iart:=1;
              end;
              Form1.ActiveControl:=Edit3;
              Edit3.AutoSelect:=True;
            end;
          end else begin
            Label2.Caption:='bis Hex-ID muß eine Hexadezimalzahl sein';
            Edit3.Enabled:=True;
            Edit3.Color:=clYellow;
            Edit3.Font.Color:=clBlue;
            Edit3.ReadOnly:=False;
            Edit3.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=2;
            istell:=0;
            ifunc:=5;
            ilanmax:=6;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit3.Text:=ebhex;
              ialpha:=ebhex;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit3;
            Edit3.AutoSelect:=True;
          end;
        end else begin
          Label2.Caption:='bis Hex-ID muß eingegeben werden';
          Edit3.Enabled:=True;
          Edit3.Color:=clYellow;
          Edit3.Font.Color:=clBlue;
          Edit3.ReadOnly:=False;
          Edit3.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=2;
          istell:=0;
          ifunc:=5;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit3.Text:=ebhex;
            ialpha:=ebhex;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit3;
          Edit3.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit4KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 4 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit4);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 4 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit4.ReadOnly:=True;
      Edit4.Color:=clSilver;
      Edit4.Font.Color:=clGray;
      Edit4.AutoSelect:=False;
      if ((dart = 'Flugdaten') or (dart = 'Flugverfolgung')) then
      begin
        if inummer > 0 then
        begin
          evspeed:=inummer;
          if dart = 'Flugdaten' then
          begin
            mlauf:=5;
            Edit5.Enabled:=True;
            Edit5.Color:=clYellow;
            Edit5.Font.Color:=clBlue;
            Edit5.ReadOnly:=False;
            Edit5.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=3;
            istell:=0;
            ifunc:=1;
            ilanmax:=4;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit5.Text:=IntToStr(ebspeed);
              inummer:=ebspeed;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit5;
            Edit5.AutoSelect:=True;
          end;
          if dart = 'Flugverfolgung' then
          begin
            mlauf:=6;
            Edit6.Enabled:=True;
            Edit6.Color:=clYellow;
            Edit6.Font.Color:=clBlue;
            Edit6.ReadOnly:=False;
            Edit6.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=0;
            izeich:=3;
            istell:=0;
            ifunc:=1;
            ilanmax:=4;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit6.Text:=IntToStr(evhead);
              inummer:=evhead;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit6;
            Edit6.AutoSelect:=True;
          end;
        end else begin
          Label2.Caption:='von Geschwindigkeit muß größer Null sein';
          Edit4.Enabled:=True;
          Edit4.Color:=clYellow;
          Edit4.Font.Color:=clBlue;
          Edit4.ReadOnly:=False;
          Edit4.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=1;
          ilanmax:=4;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit4.Text:=IntToStr(evspeed);
            inummer:=evspeed;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit4;
          Edit4.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit5KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 5 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit5);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit5KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 5 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit5.ReadOnly:=True;
      Edit5.Color:=clSilver;
      Edit5.Font.Color:=clGray;
      Edit5.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        if inummer > 0 then
        begin
          ebspeed:=inummer;
          mlauf:=6;
          Edit6.Enabled:=True;
          Edit6.Color:=clYellow;
          Edit6.Font.Color:=clBlue;
          Edit6.ReadOnly:=False;
          Edit6.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=1;
          ilanmax:=4;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit6.Text:=IntToStr(evhead);
            inummer:=evhead;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit6;
          Edit6.AutoSelect:=True;
        end else begin
          Label2.Caption:='bis Geschwindigkeit muß größer Null sein';
          Edit5.Enabled:=True;
          Edit5.Color:=clYellow;
          Edit5.Font.Color:=clBlue;
          Edit5.ReadOnly:=False;
          Edit5.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=1;
          ilanmax:=4;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit5.Text:=IntToStr(ebspeed);
            inummer:=ebspeed;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit5;
          Edit5.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit6KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 6 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit6);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit6KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 6 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit6.ReadOnly:=True;
      Edit6.Color:=clSilver;
      Edit6.Font.Color:=clGray;
      Edit6.AutoSelect:=False;
      if ((dart = 'Flugdaten') or (dart = 'Flugverfolgung')) then
      begin
        evhead:=inummer;
        if dart = 'Flugdaten' then
        begin
          mlauf:=7;
          Edit7.Enabled:=True;
          Edit7.Color:=clYellow;
          Edit7.Font.Color:=clBlue;
          Edit7.ReadOnly:=False;
          Edit7.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=0;
          izeich:=3;
          istell:=0;
          ifunc:=1;
          ilanmax:=4;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit7.Text:=IntToStr(ebhead);
            inummer:=ebhead;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit7;
          Edit7.AutoSelect:=True;
        end;
        if dart = 'Flugverfolgung' then
        begin
          mlauf:=8;
          Edit8.Enabled:=True;
          Edit8.Color:=clYellow;
          Edit8.Font.Color:=clBlue;
          Edit8.ReadOnly:=False;
          Edit8.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit8.Text:=FloatToStr(evlat);
            inumkom:=evlat;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit8;
          Edit8.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit7KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 7 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit7);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit7KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 7 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit7.ReadOnly:=True;
      Edit7.Color:=clSilver;
      Edit7.Font.Color:=clGray;
      Edit7.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        ebhead:=inummer;
        mlauf:=8;
        Edit8.Enabled:=True;
        Edit8.Color:=clYellow;
        Edit8.Font.Color:=clBlue;
        Edit8.ReadOnly:=False;
        Edit8.Text:='';
        ialpha:='';
        inummer:=0;
        iart:=2;
        inumkom:=0;
        ikomma:=3;
        izeich:=3;
        istell:=0;
        ifunc:=3;
        ilanmax:=6;
        ilanmin:=1;
        iautocr:=1;
        if mart = 2 then
        begin
          Edit8.Text:=FloatToStr(evlat);
          inumkom:=evlat;
          iart:=1;
        end;
        Form1.ActiveControl:=Edit8;
        Edit8.AutoSelect:=True;
      end;
    end;
  end;
end;

procedure TForm1.Edit8KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 8 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit8);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit8KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 8 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit8.ReadOnly:=True;
      Edit8.Color:=clSilver;
      Edit8.Font.Color:=clGray;
      Edit8.AutoSelect:=False;
      if ((dart = 'Flugdaten') or (dart = 'Flugverfolgung')) then
      begin
        if inumkom > 0 then
        begin
          evlat:=inumkom;
          if dart = 'Flugdaten' then
          begin
            mlauf:=9;
            Edit9.Enabled:=True;
            Edit9.Color:=clYellow;
            Edit9.Font.Color:=clBlue;
            Edit9.ReadOnly:=False;
            Edit9.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=3;
            izeich:=3;
            istell:=0;
            ifunc:=3;
            ilanmax:=6;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit9.Text:=FloatToStr(eblat);
              inumkom:=eblat;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit9;
            Edit9.AutoSelect:=True;
          end;
          if dart = 'Flugverfolgung' then
          begin
            mlauf:=10;
            Edit10.Enabled:=True;
            Edit10.Color:=clYellow;
            Edit10.Font.Color:=clBlue;
            Edit10.ReadOnly:=False;
            Edit10.Text:='';
            ialpha:='';
            inummer:=0;
            iart:=2;
            inumkom:=0;
            ikomma:=3;
            izeich:=3;
            istell:=0;
            ifunc:=3;
            ilanmax:=6;
            ilanmin:=1;
            iautocr:=1;
            if mart = 2 then
            begin
              Edit10.Text:=FloatToStr(evlong);
              inumkom:=evlong;
              iart:=1;
            end;
            Form1.ActiveControl:=Edit10;
            Edit10.AutoSelect:=True;
          end;
        end else begin
          Label2.Caption:='von Latitude muß größer Null sein';
          Edit8.Enabled:=True;
          Edit8.Color:=clYellow;
          Edit8.Font.Color:=clBlue;
          Edit8.ReadOnly:=False;
          Edit8.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit8.Text:=FloatToStr(evlat);
            inumkom:=evlat;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit8;
          Edit8.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Edit9KeyPress(Sender: TObject; var Key: char);
begin
  if mlauf = 9 then
  begin
    itaste:=Key;
    FeldEingabe(Form1.Edit9);
    Key:=itaste;
  end;
end;

procedure TForm1.Edit9KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if mlauf = 9 then
  begin
    if ((istell = ilanmax) and (ord(itaste) > 0) and (iautocr = 1)) then
    begin
      Key:=ord(chr(13));
    end;
    if ord(Key) = 13 then
    begin
      Label1.Caption:=widechar(169)+'DG5UAP               L O G B U C H                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
      istell:=0;
      Label2.Caption:='';
      Edit9.ReadOnly:=True;
      Edit9.Color:=clSilver;
      Edit9.Font.Color:=clGray;
      Edit9.AutoSelect:=False;
      if dart = 'Flugdaten' then
      begin
        if inumkom > 0 then
        begin
          eblat:=inumkom;
          mlauf:=10;
          Edit10.Enabled:=True;
          Edit10.Color:=clYellow;
          Edit10.Font.Color:=clBlue;
          Edit10.ReadOnly:=False;
          Edit10.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit10.Text:=FloatToStr(evlong);
            inumkom:=evlong;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit10;
          Edit10.AutoSelect:=True;
        end else begin
          Label2.Caption:='bis Latitude muß größer Null sein';
          Edit9.Enabled:=True;
          Edit9.Color:=clYellow;
          Edit9.Font.Color:=clBlue;
          Edit9.ReadOnly:=False;
          Edit9.Text:='';
          ialpha:='';
          inummer:=0;
          iart:=2;
          inumkom:=0;
          ikomma:=3;
          izeich:=3;
          istell:=0;
          ifunc:=3;
          ilanmax:=6;
          ilanmin:=1;
          iautocr:=1;
          if mart = 2 then
          begin
            Edit9.Text:=FloatToStr(eblat);
            inumkom:=eblat;
            iart:=1;
          end;
          Form1.ActiveControl:=Edit9;
          Edit9.AutoSelect:=True;
        end;
      end;
    end;
  end;
end;

procedure TForm1.FormActivate(Sender: TObject);
  var h1: integer;
  var h2: integer;
  var h3: integer;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if sta = 1 then
  begin
    Form1.Caption:='                   Flugdatenverwaltung            Version '+vers+'                   <'+BUser+'>';
    Closestat:=0;
    mtasts:=1;
    ialpha:='';
    inummer:=0;
    inumkom:=0;
    ikomma:=0;
    iart:=1;
    izeich:=3;
    istell:=0;
    mlauf:=0;
    mver:=0;
    sta:=2;
    sperr:=1;
    DateSeparator:='.';
    ShortDateFormat:='dd.mm.yyyy';
    CurrencyString:='€';
    ThousandSeparator:=Chr(0);
    DecimalSeparator:=',';
    CurrencyDecimals:=2;
    sort:='Flight';
    dart:='Flugdaten';
    Button1.Visible:=False;
    Combobox2.Enabled:=True;
    ComboBox2.Color:=clYellow;
    ComboBox2.Font.Color:=clBlue;
    ComboBox2.Text:='';
    ComboBox2.ItemIndex:=-1;
    ComboBox2.ItemHeight:=22;
    ComboBox2.Items.Clear;
    ComboBox2.Items.Add('Hex_ID');
    ComboBox2.Items.Add('Datum und Zeit');
    ComboBox2.Items.Add('Flight');
    ComboBox2.Items.Add('Alt');
    ComboBox2.Items.Add('Speed');
    ComboBox2.Items.Add('Heading');
    ComboBox2.Items.Add('Lat');
    ComboBox2.Items.Add('Long');
    ComboBox2.Items.Add('Anzahl Daten');
    ComboBox2.Items.Add('Flugverfolgung');
    ComboBox2.Items.Add('Abflughafen');
    ComboBox2.Items.Add('Zielflughafen');
    ComboBox2.Text:='Flight';
    h1:=ComboBox2.Items.IndexOf('Flight');
    ComboBox2.ItemIndex:=h1;
    Combobox1.Enabled:=True;
    ComboBox1.Color:=clYellow;
    ComboBox1.Font.Color:=clBlue;
    ComboBox1.Text:='';
    ComboBox1.ItemIndex:=-1;
    ComboBox1.ItemHeight:=22;
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add('Flugdaten');
    ComboBox1.Items.Add('Fluggesellschaften');
    ComboBox1.Items.Add('ICAO Länder');
    ComboBox1.Items.Add('Flugverfolgung');
    ComboBox1.Text:='Flugdaten';
    h1:=ComboBox1.Items.IndexOf('Flugdaten');
    ComboBox1.ItemIndex:=h1;
    StringGrid1.RowCount:=2;
    StringGrid1.ColCount:=20;
    StringGrid1.ColWidths[0]:=120;
    StringGrid1.ColWidths[1]:=180;
    StringGrid1.ColWidths[2]:=260;
    StringGrid1.ColWidths[3]:=260;
    StringGrid1.ColWidths[4]:=140;
    StringGrid1.ColWidths[5]:=150;
    StringGrid1.ColWidths[6]:=150;
    StringGrid1.ColWidths[7]:=220;
    StringGrid1.ColWidths[8]:=220;
    StringGrid1.ColWidths[9]:=180;
    StringGrid1.ColWidths[10]:=180;
    StringGrid1.ColWidths[11]:=150;
    StringGrid1.ColWidths[12]:=150;
    StringGrid1.ColWidths[13]:=150;
    StringGrid1.ColWidths[14]:=150;
    StringGrid1.ColWidths[15]:=810;
    StringGrid1.ColWidths[16]:=550;
    StringGrid1.ColWidths[17]:=180;
    StringGrid1.ColWidths[18]:=680;
    StringGrid1.ColWidths[19]:=680;
    StringGrid1.Cells[0, 0]:='ICAO-ID';
    StringGrid1.Cells[1, 0]:='Anzahl Daten';
    StringGrid1.Cells[2, 0]:='von Zeit';
    StringGrid1.Cells[3, 0]:='bis Zeit';
    StringGrid1.Cells[4, 0]:='Flight';
    StringGrid1.Cells[5, 0]:='von Alt [m]';
    StringGrid1.Cells[6, 0]:='bis Alt [m]';
    StringGrid1.Cells[7, 0]:='von Speed [Km/h]';
    StringGrid1.Cells[8, 0]:='bis Speed [Km/h]';
    StringGrid1.Cells[9, 0]:='von Heading [°]';
    StringGrid1.Cells[10, 0]:='bis Heading [°]';
    StringGrid1.Cells[11, 0]:='von Lat [°]';
    StringGrid1.Cells[12, 0]:='von Long [°]';
    StringGrid1.Cells[13, 0]:='bis Lat [°]';
    StringGrid1.Cells[14, 0]:='bis Long [°]';
    StringGrid1.Cells[15, 0]:='Fluggesellschaft';
    StringGrid1.Cells[16, 0]:='Land';
    StringGrid1.Cells[17, 0]:='Flugverfolgung';
    StringGrid1.Cells[18, 0]:='Abflughafen';
    StringGrid1.Cells[19, 0]:='Zielflughafen';
    StringGrid1.Cells[0, 1]:='';
    StringGrid1.Cells[1, 1]:='';
    StringGrid1.Cells[2, 1]:='';
    StringGrid1.Cells[3, 1]:='';
    StringGrid1.Cells[4, 1]:='';
    StringGrid1.Cells[5, 1]:='';
    StringGrid1.Cells[6, 1]:='';
    StringGrid1.Cells[7, 1]:='';
    StringGrid1.Cells[8, 1]:='';
    StringGrid1.Cells[9, 1]:='';
    StringGrid1.Cells[10, 1]:='';
    StringGrid1.Cells[11, 1]:='';
    StringGrid1.Cells[12, 1]:='';
    StringGrid1.Cells[13, 1]:='';
    StringGrid1.Cells[14, 1]:='';
    StringGrid1.Cells[15, 1]:='';
    StringGrid1.Cells[16, 1]:='';
    StringGrid1.Cells[17, 1]:='';
    StringGrid1.Cells[18, 1]:='';
    StringGrid1.Cells[19, 1]:='';
    BLoe;
    h1:=Printers.Printer.Printers.Count;
    h2:=Printers.Printer.PrinterIndex;
    if h1 > 0 then
    begin
      for h3:=0 to h1-1 do
      begin
        if h3 = h2 then
        begin
          drucker:=Printers.Printer.Printers.Strings[h3];
          druckn:=h3;
        end;
      end;
    end;
    if dcon = 0 then
    begin
      egrid:=0;
      ZConnection1.Connect;
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Form1.Cursor:=crDefault;
  Form1.Refresh;
  if dcon = 1 then
  begin
    ZConnection1.Disconnect;
  end;
  DateSeparator:=sdate1;
  ShortDateFormat:=sdate2;
  CurrencyString:=vwaehrs;
  ThousandSeparator:=vtaus;
  DecimalSeparator:=vdezim;
  CurrencyDecimals:=vwaehrz;
  CloseAction:=caFree;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (abbruch) then
  begin
    CanClose:=true;
  end else begin
    Form1.Cursor:=crDefault;
    Form1.Refresh;
    CanClose:=false;
    if (Closestat = 0) then
    begin
      Closestat:=1;
      JaNein:=messagedlg('Programm-Ende ?', mtConfirmation, [mbYes, mbNo], 0);
      Closestat:=0;
      if (JaNein = mrYes) then
      begin
        CanClose:=true;
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
  var heute: string;
  var h1: integer;
  var h3: string;
  var Rec: LongRec;
  var h2: string;
  var h4: string;
  var h5: integer;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  Closestat:=0;
  mtasts:=1;
  ialpha:='';
  inummer:=0;
  inumkom:=0;
  ikomma:=0;
  iart:=1;
  izeich:=3;
  istell:=0;
  mlauf:=0;
  BUser:='';
  try
    BUser:=GetEnvironmentVariable('USERNAME');
  except
    BUser:='unknown';
  end;
  heute:=FormatDateTime('DD.MM.YYYY',now);
  h1:=StrLen(PChar(heute));
  if (h1 = 10) then
  begin
    h3:=Copy(heute, 1, 2);
    Tag:=StrToInt(h3);
    h3:=Copy(heute, 4, 2);
    Monat:=StrToInt(h3);
    h3:=Copy(heute, 7, 4);
    Jahr:=StrToInt(h3);
  end;
  vwaehrs:=CurrencyString;
  vtaus:=ThousandSeparator;
  vdezim:=DecimalSeparator;
  vwaehrz:=CurrencyDecimals;
  sdate1:=DateSeparator;
  sdate2:=ShortDateFormat;
  DateSeparator:='.';
  ShortDateFormat:='dd.mm.yyyy';
  CurrencyString:='€';
  ThousandSeparator:=Chr(0);
  DecimalSeparator:=',';
  CurrencyDecimals:=2;
  abbruch:=false;
  sta:=1;
  dcon:=0;
  Rec:=LongRec(GetFileVersion(ParamStr(0)));
  h2:=IntToStr(Rec.Hi);
  h5:=Length(h2);
  if h5 = 1 then h2:='0'+IntToStr(Rec.Hi);
  h4:=IntToStr(Rec.Lo);
  h5:=Length(h4);
  if h5 = 1 then h4:='0'+IntToStr(Rec.Lo);
  vers:=h2+'.'+h4;
  ZConnection1.Connected:=False;
  ZQuery1.Active:=False;
  Form1.Caption:='                   Flugdatenverwaltung            Version '+vers+'                   <'+BUser+'>';
  Label1.Caption:=widechar(169)+'LINSOFT               Flugdatatenverwaltung                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
end;

procedure TForm1.Blankwegh;
  var laenge: integer;
  var stelle: integer;
  var vari12: integer;
  var zeichen: string;
begin
  laenge:=Length(ialpha);
  vari12:=0;
  if laenge > 0 then
  begin
    for stelle:=laenge downto 1 do
    begin
      zeichen:=Copy(ialpha,stelle,1);
      if (vari12 = 0) then
      begin
        if (zeichen <> ' ') then
        begin
          vari12:=stelle;
        end;
      end;
    end;
  end;
  if (vari12 > 0) then
  begin
    zeichen:=ialpha;
    ialpha:=Copy(zeichen,1,vari12);
  end else begin
    ialpha:='';
  end;
end;

procedure TForm1.Blankwegv;
  var laenge: integer;
  var stelle: integer;
  var vari12: integer;
  var zeichen: string;
begin
  laenge:=Length(ialpha);
  vari12:=0;
  if laenge > 0 then
  begin
    for stelle:=1 to laenge do
    begin
      zeichen:=Copy(ialpha,stelle,1);
      if (vari12 = 0) then
      begin
        if (zeichen <> ' ') then
        begin
          vari12:=stelle;
        end;
      end;
    end;
  end;
  if (vari12 > 0) then
  begin
    zeichen:=ialpha;
    ialpha:=Copy(zeichen,vari12,laenge-vari12+1);
  end else begin
    ialpha:='';
  end;
end;

procedure TForm1.BLoe;
begin
  Label5.Caption:='';
  Label10.Caption:='';
  Label12.Caption:='';
  Label14.Caption:='';
  Label21.Caption:='';
  Edit1.Enabled:=False;
  Edit1.Color:=clSilver;
  Edit1.Font.Color:=clGray;
  Edit1.Text:='';
  Edit2.Enabled:=False;
  Edit2.Color:=clSilver;
  Edit2.Font.Color:=clGray;
  Edit2.Text:='';
  Edit3.Enabled:=False;
  Edit3.Color:=clSilver;
  Edit3.Font.Color:=clGray;
  Edit3.Text:='';
  Edit4.Enabled:=False;
  Edit4.Color:=clSilver;
  Edit4.Font.Color:=clGray;
  Edit4.Text:='';
  Edit5.Enabled:=False;
  Edit5.Color:=clSilver;
  Edit5.Font.Color:=clGray;
  Edit5.Text:='';
  Edit6.Enabled:=False;
  Edit6.Color:=clSilver;
  Edit6.Font.Color:=clGray;
  Edit6.Text:='';
  Edit7.Enabled:=False;
  Edit7.Color:=clSilver;
  Edit7.Font.Color:=clGray;
  Edit7.Text:='';
  Edit8.Enabled:=False;
  Edit8.Color:=clSilver;
  Edit8.Font.Color:=clGray;
  Edit8.Text:='';
  Edit9.Enabled:=False;
  Edit9.Color:=clSilver;
  Edit9.Font.Color:=clGray;
  Edit9.Text:='';
  Edit10.Enabled:=False;
  Edit10.Color:=clSilver;
  Edit10.Font.Color:=clGray;
  Edit10.Text:='';
  Edit11.Enabled:=False;
  Edit11.Color:=clSilver;
  Edit11.Font.Color:=clGray;
  Edit11.Text:='';
  Edit12.Enabled:=False;
  Edit12.Color:=clSilver;
  Edit12.Font.Color:=clGray;
  Edit12.Text:='';
  Edit13.Enabled:=False;
  Edit13.Color:=clSilver;
  Edit13.Font.Color:=clGray;
  Edit13.Text:='';
  Edit14.Enabled:=False;
  Edit14.Color:=clSilver;
  Edit14.Font.Color:=clGray;
  Edit14.Text:='';
  Edit15.Enabled:=False;
  Edit15.Color:=clSilver;
  Edit15.Font.Color:=clGray;
  Edit15.Text:='';
  Edit16.Enabled:=False;
  Edit16.Color:=clSilver;
  Edit16.Font.Color:=clGray;
  Edit16.Text:='';
end;

procedure TForm1.Hexum;
  var h1: integer;
  var h2: string;
  var h3: integer;
  var h4: integer;
  var h5: integer;
  var h6: integer;
  var h7: integer;
  var h8: integer;
  var h9: integer;
  var ha: integer;
  var hb: integer;
  var hc: integer;
  var hd: integer;
  var he: integer;
begin
  inummer:=0;
  h1:=Length(ialpha);
  if h1 = 6 then
  begin
    h4:=0;
    h6:=1;
    h8:=0;
    h9:=0;
    ha:=0;
    hb:=0;
    hc:=0;
    hd:=0;
    he:=1;
    for h3:=1 to h1 do
    begin
      if he = 1 then
      begin
        h2:=Copy(ialpha,h3,1);
        h5:=Ord(h2[1]);
        if ((h5 > 47) and (h5 < 58)) then
        begin
          h4:=1;
          h7:=StrToInt(h2);
        end else begin
          if ((h5 > 64) and (h5 < 71)) then
          begin
            h4:=1;
            if h2 = 'A' then h7:=10;
            if h2 = 'B' then h7:=11;
            if h2 = 'C' then h7:=12;
            if h2 = 'D' then h7:=13;
            if h2 = 'E' then h7:=14;
            if h2 = 'F' then h7:=15;
          end else begin
            he:=0;
          end;
        end;
        if h4 = 1 then
        begin
          if h6 = 1 then h8:=h7;
          if h6 = 2 then h9:=h7;
          if h6 = 3 then ha:=h7;
          if h6 = 4 then hb:=h7;
          if h6 = 5 then hc:=h7;
          if h6 = 6 then hd:=h7;
          h6:=h6+1;
        end;
      end;
    end;
    if he = 1 then inummer:=h8*1048576+h9*65536+ha*4096+hb*256+hc*16+hd;
  end;
end;

procedure TForm1.Privflug;
  var h1: integer;
  var h2: string;
  var h3: integer;
  var h4: integer;
  var h5: integer;
begin
  inummer:=0;
  h1:=Length(ialpha);
  if h1 > 0 then
  begin
    h4:=0;
    for h3:=1 to h1 do
    begin
      h2:=Copy(ialpha,h3,1);
      h5:=Ord(h2[1]);
      if ((h5 > 47) and (h5 < 58)) then h4:=1;
    end;
    if h4 = 0 then inummer:=1;
  end;
end;

end.

