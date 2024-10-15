
unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ZConnection, ZDataset, ZAbstractRODataset, Eingabe, Printers, ExtCtrls,
  LazHelpHTML, Buttons, SynEdit, SynHighlighterHTML, IpHtml, IpFileBroker, shellapi,
  mvMapViewer, System.UITypes, DB, MVTYPES, LCLIntf, LCLType, Messages, pl_win_api,
  BGRABitmap, BGRABitmapTypes, BGRATransform, fgl, ComCtrls, DateUtils, Process,
  uWVBrowser, uWVWindowParent, uWVLoader, uWVBrowserBase, uWVTypes, uWVEvents,
  uWVWinControl, uWVConstants, uWVTypeLibrary, uWVLibFunctions, uwVInterfaces,
  uwVCoreWebView2Args;

type

  { TPlaneItem }

  TPlaneItem = class
    PlaneStream: TMemoryStream;
    PosX: integer;
    PosY: integer;
    Angle: Integer;
    Color: TColor;
    HexId: String;
    vonZeit: TDateTime;
    Hoehe: Integer;
    constructor Create;
    destructor Destroy; override;
  end;

  { TPlaneList }

  TPlaneList = class(specialize TFPGObjectList<TPlaneItem>)
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit99: TEdit;
    Image3: TImage;
    Image2: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ListBox1: TListBox;
    MapView1: TMapView;
    PaintBox1: TPaintBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    StringGrid1: TStringGrid;
    Timer1: TTimer;
    Timer2: TTimer;
    WVBrowser1: TWVBrowser;
    WVBrowser2: TWVBrowser;
    WVWindowParent1: TWVWindowParent;
    WVWindowParent2: TWVWindowParent;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    ZTransaction1: TZTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit99KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MapView1Change(Sender: TObject);
    procedure MapView1ZoomChange(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject;
      aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser1NavigationCompleted(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure WVBrowser1RetrieveHTMLCompleted(Sender: TObject;
      aResult: boolean; const aHTML: wvstring);
    procedure WVBrowser2AfterCreated(Sender: TObject);
    procedure WVBrowser2InitializationError(Sender: TObject;
      aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure WVBrowser2NavigationCompleted(Sender: TObject;
      const aWebView: ICoreWebView2;
      const aArgs: ICoreWebView2NavigationCompletedEventArgs);
    procedure ZConnection1AfterConnect(Sender: TObject);
  protected
    // It's necessary to handle these messages to call NotifyParentWindowPositionChanged or some page elements will be misaligned.
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
  private
    procedure Laden;
  public
    procedure Hexum;
    procedure Blankwegh;
    procedure Blankwegv;
    procedure Privflug;
    procedure Nummer;
    procedure Geoum;
    procedure Lesen;
    procedure zeichne;
    procedure Mapan;
    procedure Mapaus;
    procedure PaintMassstab;
    procedure PaintHome;
    function PreparePlane(aColor: TColor; aAngle, aSize: Integer): TMemoryStream;
    function PrepareText: TMemoryStream;
    function XYKorrektur(zoomfaktor, richtung: integer): integer;
  end;

type tflight = record
  hex: string;
  mode: string;
  sqwk: integer;
  flight: string;
  alt: integer;
  spd: integer;
  hdg: integer;
  lat: double;
  long: double;
  sig: integer;
  msgs: integer;
  ti: integer;
  vx: integer;
  bx: integer;
  vy: integer;
  by: integer;
end;

type hflight = record
  hex: string;
  art: integer;
  vzeit: TDateTime;
  bzeit: TDateTime;
  flight: string;
  valt: integer;
  balt: integer;
  vspd: integer;
  bspd: integer;
  vhdg: integer;
  bhdg: integer;
  vlat: double;
  vlong: double;
  blat: double;
  blong: double;
end;

type tflieger = record
  posx: integer;
  posy: integer;
  farbe: TColor;
  richtung: integer;
  anaus: integer;
end;

type tposi = record
  latvy: double;
  latby: double;
  longvx: double;
  longbx: double;
end;

type talt = record
  althex: string;
  altart: integer;
  altvzeit: TDateTime;
  altbzeit: TDateTime;
  altflight: string;
  altvalt: integer;
  altbalt: integer;
  altvspd: integer;
  altbspd: integer;
  altvhdg: integer;
  altbhdg: integer;
  altvlat: double;
  altvlong: double;
  altblat: double;
  altblong: double;
  altvon: string;
  altnach: string;
  altftyp: string;
end;

const
  flightmax1: integer = 50;
  flightmax2: integer = 2000;

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
  fnum: TextFile;
  flighttab1: array [1..50] of string;
  flightanz1: integer;
  flighttab2: array [1..50] of string;
  flightanz2: integer;
  habb: integer;
  habb2: integer;
  heof: integer;
  htimerrun: integer;
  Webanzeige: integer;
  flighttab3: array [1..50] of tflight;
  flightanz3: integer;
  flighttab4: array [1..2000] of hflight;
  flightanz4: integer;
  latvy: double;
  latby: double;
  longvx: double;
  longbx: double;
  flugx: integer;
  flugy: integer;
  flugh: integer;
  flugr: integer;
  hgrid: integer;
  mapnr: integer;
  zeit: integer;
  posi: array [1..19] of tposi;
  webanz: integer;
  ffehl: integer;
  imgloe: integer;
  hlat: double;
  hlong: double;
  glatv: double;
  glongv: double;
  glatb: double;
  glongb: double;
  pmeterb: double;
  pmeterl: double;
  pmetere: integer;
  loeim2: integer;
  flieger: array [1..50] of tflieger;
  fliegeranz: integer;
  flugx2: integer;
  flugy2: integer;
  blinkaa: integer;
  mvmap: integer;
  murl: string;
  murllad: integer;
  loops: integer;
  planelist: TPlaneList;
  Homepunkt, Kartenpunkt: TRealPoint;
  zoomfakt: integer;
  orgzoom: integer;
  vonLat: Double;
  bisLat: Double;
  vonLon: Double;
  bisLon: Double;
  mgebiet: integer;
  zoomsave: integer;
  pfunkt: integer;
  mapnrsave: integer;
  zeichenart: integer;
  textausgabe: integer;
  startmerk: integer;
  flugzeugnr: integer;
  flugzeugrichtung: integer;
  flugzeugX: integer;
  flugzeugY: integer;
  flugzeugfarbe: TColor;
  flugzeughexid: string;
  flugzeugzeit: TDateTime;
  flugzeughoehe: integer;
  zoomsi: integer;
  herrmsg: string;
  URL: string;
  HTMLText: wvstring;
  HTMLErr: integer;
  Paintab: integer;
  webseitegeladen: integer;
  feldalt: string;
  feldneu: string;
  alttab: array [1..2000] of talt;
  textflight: string;
  timeraus: integer;
  bildgeklickt: integer;
  nummerflug: integer;
  ladenwebart: integer;
  mittimeron: integer;

implementation

{$R *.lfm}

{ TPlaneItem }

constructor TPlaneItem.Create;
begin
  inherited Create;
  PlaneStream := nil;
  PosX := 0;
  PosY := 0;
  Angle := 0;
  Color := clBlack;
  HexId := '';
  vonZeit := now;
  Hoehe := 0;
end;

destructor TPlaneItem.Destroy;
begin
  if Assigned(PlaneStream) then
    PlaneStream.Free;
  inherited Destroy;
end;

function Tform1.XYKorrektur(zoomfaktor, richtung: Integer): integer;
  var v7: integer;
begin
  v7:=0;
  if richtung = 1 then
  begin
    if zoomfaktor = 2 then v7:=35;
    if zoomfaktor = 16 then v7:=5;
    if zoomfaktor = 17 then v7:=10;
    if zoomfaktor = 18 then v7:=25;
    if zoomfaktor = 19 then v7:=60;
  end;
  if richtung = 2 then
  begin
    if zoomfaktor = 2 then v7:=165;
    if zoomfaktor = 3 then v7:=115;
    if zoomfaktor = 4 then v7:=70;
    if zoomfaktor = 5 then v7:=45;
    if zoomfaktor = 6 then v7:=23;
  end;
  Result:=v7;
end;

function TForm1.PreparePlane(aColor: TColor; aAngle, aSize: Integer): TMemoryStream;
var
  bmp, temp: TBGRABitmap;
  bmptranform: TBGRAAffineBitmapTransform;
  w, h: Integer;
begin
  Result := TMemoryStream.Create;
  bmp := TBGRABitmap.Create(ExtractFilePath(ParamStr(0))+'flieger.bmp');
  bmp.ReplaceColor(bmp.ClipRect, BGRABlack, BGRAPixelTransparent);  //Replace black to transparent
  bmp.ReplaceColor(clWhite, aColor);    //change plane color
  w := bmp.Width;
  if bmp.Height > w then
    w := bmp.Height;
  temp := TBGRABitmap.Create(w, w, BGRAPixelTransparent);
  bmptranform := TBGRAAffineBitmapTransform.Create(bmp);
  bmptranform.Translate(-bmp.Width div 2, -bmp.Height div 2);
  bmptranform.RotateDeg(aAngle);
  bmptranform.Translate(bmp.Width div 2, bmp.Height div 2);
  temp.Fill(bmptranform);
  bmptranform.Free;
  bmp.Assign(temp);
  temp.Free;
  if (bmp.Width > aSize) or (bmp.Height > aSize) then
  begin
    w := aSize;
    h := aSize;
    if bmp.Width >= bmp.Height then
      h := trunc(bmp.Height * (w / bmp.Width))
    else
      w := trunc(bmp.Width * (h / bmp.Height));
    BGRAReplace(bmp, bmp.Resample(w, h, rmFineResample));
  end;
  bmp.SaveToStreamAsPng(Result);
  bmp.Free;
end;

function TForm1.PrepareText: TMemoryStream;
var
  bmp, temp: TBGRABitmap;
  bmptranform: TBGRAAffineBitmapTransform;
  w, h: Integer;
begin
  Result := TMemoryStream.Create;
  bmp := TBGRABitmap.Create(ExtractFilePath(ParamStr(0))+'Flightdat.bmp');
  temp := TBGRABitmap.Create(bmp.Width, bmp.Height, BGRAPixelTransparent);
  bmp.ReplaceColor(clWhite, clWhite);    //change text color
  w := bmp.Width;
  h := bmp.Height;
  temp := TBGRABitmap.Create(w, h, BGRAPixelTransparent);
  bmptranform := TBGRAAffineBitmapTransform.Create(bmp);
  bmptranform.Translate(-bmp.Width div 2, -bmp.Height div 2);
  bmptranform.RotateDeg(0);
  bmptranform.Translate(bmp.Width div 2, bmp.Height div 2);
  temp.Fill(bmptranform);
  bmptranform.Free;
  bmp.Assign(temp);
  temp.Free;
  bmp.SaveToStreamAsPng(Result);
  bmp.Free;
end;

{ TPlaneList }

{ TForm1 }

procedure TForm1.WMMove(var aMessage : TWMMove);
begin
  inherited;
  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TForm1.WMMoving(var aMessage : TMessage);
begin
  inherited;
  if (WVBrowser1 <> nil) then
    WVBrowser1.NotifyParentWindowPositionChanged;
end;

procedure TForm1.Laden;
var z: integer;
var h1: integer;
var h2: integer;
var h3: integer;
var h4: integer;
var h5: double;
var h6: integer;
var h8: string;
var h9: string;
var ha: string;
var hb: string;
var hc: integer;
var hd: string;
var he: string;
var hf: string;
var hg: string;
var hi: integer;
var hj: integer;
var hk: integer;
var hv: string;
var hn: string;
var ho: string;
var hx: string;
begin
  Screen.Cursor:=crHourGlass;
  Form1.Cursor:=crHourGlass;
  Form1.Refresh;
  z:=1;
  if flightanz4 > 0 then
  begin
    for h2:=1 to flightanz4 do
    begin
      z:=z + 1;
      StringGrid1.RowCount:=z;
      z:=z - 1;
      h8:='';
      h9:='';
      hv:='';
      hn:='';
      ho:='';
      ialpha:=flighttab4[h2].hex;
      Hexum;
      hi:=inummer;
      ha:=flighttab4[h2].flight;
      hx:=DateTimeToStr(flighttab4[h2].vzeit);
      h6:=Length(ha);
      hb:='';
      hc:=0;
      if h6 > 2 then
      begin
        hx:=DateTimeToStr(flighttab4[h2].vzeit);
        Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE hexid=:hid AND vonzeit=:vzt1';
        Form1.ZQuery1.ParamByName('hid').asString:=flighttab4[h2].hex;
        Form1.ZQuery1.ParamByName('vzt1').asDateTime:=StrToDateTime(hx);
        Form1.ZQuery1.Open;
        while not Form1.ZQuery1.EOF do
        begin
          hv:=Form1.ZQuery1.Fields[16].AsString;
          hn:=Form1.ZQuery1.Fields[17].AsString;
          ho:=Form1.ZQuery1.Fields[18].AsString;
          Form1.ZQuery1.Next;
        end;
        Form1.ZQuery1.Close;
        hb:=Copy(ha,1,3);
        ialpha:=ha;
        Privflug;
        if inummer = 1 then hb:='001';
        Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
        Form1.ZQuery1.ParamByName('ica').asString:=hb;
        Form1.ZQuery1.Open;
        while not Form1.ZQuery1.EOF do
        begin
          hc:=1;
          h8:=Form1.ZQuery1.Fields[0].AsString;
          h9:=Form1.ZQuery1.Fields[4].AsString;
          Form1.ZQuery1.Next;
        end;
        Form1.ZQuery1.Close;
      end;
      if hc = 0 then
      begin
        if h6 > 0 then
        begin
          h1:=0;
          ialpha:=Copy(ha,1,1);
          inummer:=1;
          Nummer;
          h6:=Length(ialpha);
          if h6 > 0 then
          begin
            h1:=1;
          end else begin
            ialpha:=Copy(ha,2,1);
            inummer:=1;
            Nummer;
            h6:=Length(ialpha);
            if h6 > 0 then
            begin
              h1:=1;
            end;
          end;
          if h1 = 1 then
          begin
            hb:='002';
            Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
            Form1.ZQuery1.ParamByName('ica').asString:=hb;
            Form1.ZQuery1.Open;
            while not Form1.ZQuery1.EOF do
            begin
              h8:=Form1.ZQuery1.Fields[0].AsString;
              h9:=Form1.ZQuery1.Fields[4].AsString;
              Form1.ZQuery1.Next;
            end;
            Form1.ZQuery1.Close;
          end;
        end;
      end;
      if h9 = '' then
      begin
        Form1.ZQuery2.SQL.Text:='SELECT * FROM icao';
        Form1.ZQuery2.Open;
        while not Form1.ZQuery2.EOF do
        begin
          hd:=Form1.ZQuery2.Fields[0].AsString;
          he:=Form1.ZQuery2.Fields[1].AsString;
          hf:=Form1.ZQuery2.Fields[2].AsString;
          ialpha:=hd;
          Hexum;
          hj:=inummer;
          ialpha:=he;
          Hexum;
          hk:=inummer;
          if ((hi >= hj) and (hi <= hk)) then h9:=hf;
          Form1.ZQuery2.Next;
        end;
        Form1.ZQuery2.Close;
      end;
      StringGrid1.Cells[0, z]:=flighttab4[h2].hex;
      StringGrid1.Cells[1, z]:=IntToStr(flighttab4[h2].art);
      StringGrid1.Cells[2, z]:=DateTimeToStr(flighttab4[h2].vzeit);
      StringGrid1.Cells[3, z]:=DateTimeToStr(flighttab4[h2].bzeit);
      StringGrid1.Cells[4, z]:=flighttab4[h2].flight;
      h5:=flighttab4[h2].valt*0.3;
      StringGrid1.Cells[5, z]:=IntToStr(Round(h5));
      h5:=flighttab4[h2].balt*0.3;
      StringGrid1.Cells[6, z]:=IntToStr(Round(h5));
      h5:=flighttab4[h2].vspd*1.852;
      StringGrid1.Cells[7, z]:=FloatToStrF(h5,ffFixed,7,2);
      h5:=flighttab4[h2].bspd*1.852;
      StringGrid1.Cells[8, z]:=FloatToStrF(h5,ffFixed,7,2);
      StringGrid1.Cells[9, z]:=IntToStr(flighttab4[h2].vhdg);
      StringGrid1.Cells[10, z]:=IntToStr(flighttab4[h2].bhdg);
      StringGrid1.Cells[11, z]:=FloatToStrF(flighttab4[h2].vlat,ffFixed,6,3);
      StringGrid1.Cells[12, z]:=FloatToStrF(flighttab4[h2].vlong,ffFixed,6,3);
      StringGrid1.Cells[13, z]:=FloatToStrF(flighttab4[h2].blat,ffFixed,6,3);
      StringGrid1.Cells[14, z]:=FloatToStrF(flighttab4[h2].blong,ffFixed,6,3);
      StringGrid1.Cells[15, z]:=h8;
      StringGrid1.Cells[16, z]:=h9;
      StringGrid1.Cells[17, z]:=hv;
      StringGrid1.Cells[18, z]:=hn;
      StringGrid1.Cells[19, z]:=ho;
      z:=z + 1;
    end;
  end;
  if z = 1 then
  begin
    StringGrid1.RowCount:=2;
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
  Screen.Cursor:=crDefault;
  Form1.Cursor:=crDefault;
  Form1.Refresh;
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

procedure TForm1.Geoum;
  var h1: double;
  var h2: double;
  var h3: double;
  var ggrad: integer;
  var gmin: integer;
  var gsek: double;
begin
  pmeterb:=0;
  pmeterl:=0;
  if ((glatv > 0) and (glatb > 0)) then
  begin
    if glatb > glatv then
    begin
      h2:=glatb-glatv;
      ggrad:=Trunc(h2);
      h1:=(h2 - ggrad)*60;
      gmin:=Trunc(h1);
      gsek:=(h1 - gmin)*60;
      h3:=ggrad*71440+gmin*1190+gsek*19.8;
      pmeterb:=h3/672;
    end;
  end;
  if ((glongv > 0) and (glongb > 0)) then
  begin
    if glongb > glongv then
    begin
      h2:=glongb-glongv;
      ggrad:=Trunc(h2);
      h1:=(h2 - ggrad)*60;
      gmin:=Trunc(h1);
      gsek:=(h1 - gmin)*60;
      h3:=ggrad*111130+gmin*1850+gsek*30.9;
      pmeterl:=h3/1511;
    end;
  end;
end;

procedure TForm1.zeichne;
  var h5: double;
  var h6: TColor;
  var h8: integer;
  var h9: integer;
  var c: TColor;
  var x: integer;
  var y: integer;
  var pi: TPlaneItem;
begin
  h5:=flugzeughoehe*0.3;
  h6:=clWhite;
  imgloe:=1;
  loeim2:=1;
  if h5 < 13000 then h6:=clLime;
  if h5 < 12000 then h6:=clAqua;
  if h5 < 11000 then h6:=clYellow;
  if h5 < 10000 then h6:=clRed;
  if h5 < 9000 then h6:=clFuchsia;
  if h5 < 8000 then h6:=RGB(0,200,255);
  if h5 < 7000 then h6:=clBlue;
  if h5 < 6000 then h6:=clMaroon;
  if h5 < 5000 then h6:=clOlive;
  if h5 < 4000 then h6:=RGB(0,100,255);
  if h5 < 3000 then h6:=clGray;
  if h5 < 2000 then h6:=clGreen;
  if h5 < 1000 then h6:=clPurple;
  flugzeugfarbe:=h6;
  h9:=flugzeugrichtung;
  h8:=h9;
  if h9 > 0 then
  begin
    h9:=360-h8;
  end;
  if h9 = 360 then h9:=0;
  flugx2:=flugzeugX;
  flugy2:=flugzeugY;
  if zeichenart = 1 then
  begin
    fliegeranz:=fliegeranz+1;
    pi:=TPlaneItem.Create;
    pi.PlaneStream:=PreparePlane(flugzeugfarbe, flugzeugrichtung, 50);
    pi.Angle:=flugzeugrichtung;
    pi.PosX:=flugzeugX;
    pi.PosY:=flugzeugY;
    pi.Color:=flugzeugfarbe;
    pi.HexId:=flugzeughexid;
    pi.vonZeit:=flugzeugzeit;
    pi.Hoehe:=flugzeughoehe;
    planelist.Add(pi);
  end else begin
    if flugzeugnr > 0 then
    begin
      PlaneList.Items[flugzeugnr].PlaneStream:=PreparePlane(flugzeugfarbe, flugzeugrichtung, 50);
      PlaneList.Items[flugzeugnr].Angle:=flugzeugrichtung;
      PlaneList.Items[flugzeugnr].PosX:=flugzeugX;
      PlaneList.Items[flugzeugnr].PosY:=flugzeugY;
      PlaneList.Items[flugzeugnr].Color:=flugzeugfarbe;
      PlaneList.Items[flugzeugnr].HexId:=flugzeughexid;
      PlaneList.Items[flugzeugnr].vonZeit:=flugzeugzeit;
      PlaneList.Items[flugzeugnr].Hoehe:=flugzeughoehe;
    end;
  end;
  PaintBox1.Invalidate;
  PaintBox1.Repaint;
end;

procedure TForm1.Lesen;
  var h1: integer;
  var h2: string;
  var h3: integer;
  var h4: AnsiChar;
  var h5: integer;
  var h6: integer;
  var h7: string;
begin
  flightanz1:=0;
  flightanz2:=0;
  h2:='';
  h1:=1;
  h3:=0;
  heof:=0;
  while h1 = 1 do
  begin
    if habb = 0 then
    begin
      if not Eof(fnum) then
      begin
        if habb = 0 then
        begin
          Read(fnum,h4);
          heof:=1;
          h6:=Length(h4);
          if h6 <> 1 then
          begin
            h1:=0;
            Label2.Caption:='Readlänge falsch '+IntToStr(h6);
          end else begin
            h2:=h2+h4;
            h6:=Length(h2);
            if h3 = 0 then
            begin
              if ((h6 = 4) and (h2 = 'Hex ')) then h3:=1;
              h6:=Ord(h4);
              if h6 = 10 then
              begin
                h2:='';
              end;
            end else begin
              if h3 = 1 then
              begin
                if ((h6 = 4) and (h2 = '----')) then h3:=2;
                h6:=Ord(h4);
                if h6 = 10 then
                begin
                  h2:='';
                end;
              end else begin
                if h3 = 2 then
                begin
                  h6:=Ord(h4);
                  if h6 = 10 then
                  begin
                    h2:='';
                    h3:=3;
                    flightanz1:=0;
                  end;
                end else begin
                  if h3 = 3 then
                  begin
                    h6:=Length(h2);
                    if ((h6 = 4) and (h2 = 'Hex ')) then
                    begin
                      if flightanz1 > 0 then
                      begin
                        for h3:=1 to flightanz1 do
                        begin
                          flighttab2[h3]:=flighttab1[h3];
                        end;
                      end;
                      flightanz2:=flightanz1;
                      h3:=1;
                    end else begin
                      h6:=Ord(h4);
                      if h6 = 13 then
                      begin
                        h6:=Length(h2);
                        if h6 > 4 then
                        begin
                          if flightanz1 < flightmax1 then
                          begin
                            flightanz1:=flightanz1+1;
                            h7:=Copy(h2,1,h6-1);
                            flighttab1[flightanz1]:=h7;
                          end;
                        end;
                      end else begin
                        if h6 = 10 then
                        begin
                          h2:='';
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end else begin
          h1:=0;
        end;
      end else begin
        h1:=0;
      end;
    end else begin
      h1:=0;
    end;
  end;
end;

procedure TForm1.PaintMassstab;
  var h1: integer;
  var h2: integer;
  var h3: integer;
  var h4: string;
  var m1: double;
  var m2: double;
  var m3: double;
  var ggrad: integer;
  var gmin: integer;
  var gsek: double;
  var pmeterl: double;
  var pmeterb: double;
  var pmetere: integer;
  var a1: integer;
  var a2: integer;
  var a3: integer;
  var a4: integer;
  var a5: integer;
  var a6: integer;
  var a7: string;
  var a8: integer;
  var a9: integer;
  var aa: string;
  var ab: integer;
  var ac: string;
  var ad: integer;
begin
  pmeterb:=0;
  pmeterl:=0;
  if ((vonLat > 0) and (bisLat > 0)) then
  begin
    if bisLat > vonLat then
    begin
      m2:=bisLat-vonLat;
      ggrad:=Trunc(m2);
      m1:=(m2 - ggrad)*60;
      gmin:=Trunc(m1);
      gsek:=(m1 - gmin)*60;
      m3:=ggrad*71440+gmin*1190+gsek*19.8;
      pmeterb:=m3/672;
    end;
  end;
  if ((vonLon > 0) and (bisLon > 0)) then
  begin
    if bisLon > vonLon then
    begin
      m2:=bisLon-vonLon;
      ggrad:=Trunc(m2);
      m1:=(m2 - ggrad)*60;
      gmin:=Trunc(m1);
      gsek:=(m1 - gmin)*60;
      m3:=ggrad*111130+gmin*1850+gsek*30.9;
      pmeterl:=m3/1511;
    end;
  end;
  if pmeterl > 0 then
  begin
    a2:=0;
    a3:=0;
    a4:=0;
    a6:=0;
    pmetere:=2;
    for a1:=201 downto 50 do
    begin
      a5:=Round(pmeterl*a1);
      if a4 = 0 then
      begin
        a4:=1;
        if a5 < 1000 then
        begin
          a6:=Trunc(a5);
          pmetere:=1;
        end else begin
          a6:=Trunc(a5/1000);
          pmetere:=2;
        end;
        a7:=IntToStr(a6);
        a8:=Length(a7);
        a9:=a6;
        if a8 = 2 then
        begin
          a6:=Trunc(a9/10)*10;
        end;
        if a8 = 3 then
        begin
          a6:=Trunc(a9/100)*100;
        end;
        if a8 = 4 then
        begin
          a6:=Trunc(a9/1000)*1000;
        end;
      end;
      a8:=Round(a5/1000);
      if a8 < a6 then
      begin
        if a2 = 0 then
        begin
          a2:=a1+1;
          a3:=a6;
        end;
      end;
    end;
    a7:=' Km';
    if pmetere = 1 then a7:=' m';
  end;
  h2:=a2;
  h3:=a3;
  h4:=a7;
  PaintBox1.Canvas.Pen.Color:=clRed;
  PaintBox1.Canvas.Pen.Style:=psSolid;
  PaintBox1.Canvas.Pen.Width:=1;
  PaintBox1.Canvas.Brush.Color:=clWhite;
  PaintBox1.Canvas.Brush.Style:=bsClear;
  PaintBox1.Canvas.Font.Color:=clRed;
  PaintBox1.Canvas.Font.Size:=8;
  PaintBox1.Canvas.Font.Name:='Courier';
  PaintBox1.Canvas.Font.Style:=[fsBold];
  for h1:=PaintBox1.Height-5 to PaintBox1.Height-1 do
  begin
    PaintBox1.Canvas.MoveTo(Round(PaintBox1.Width/2-h2/2),h1);
    PaintBox1.Canvas.LineTo(Round(PaintBox1.Width/2+h2/2),h1);
  end;
  for h1:=Round(PaintBox1.Width/2-h2/2) to Round(PaintBox1.Width/2-h2/2)+4 do
  begin
    PaintBox1.Canvas.MoveTo(h1,PaintBox1.Height-41);
    PaintBox1.Canvas.LineTo(h1,PaintBox1.Height-1);
  end;
  for h1:=Round(PaintBox1.Width/2-h2/2)+h2-4 to Round(PaintBox1.Width/2-h2/2)+h2 do
  begin
    PaintBox1.Canvas.MoveTo(h1,PaintBox1.Height-41);
    PaintBox1.Canvas.LineTo(h1,PaintBox1.Height-1);
  end;
  PaintBox1.Canvas.Brush.Style:=bsSolid;
  PaintBox1.Canvas.TextOut(Round(PaintBox1.Width/2-h2/2)+5,PaintBox1.Height-36,'Entfernung: '+IntToStr(h3)+h4);
  PaintBox1.Canvas.Brush.Style:=bsClear;
  if pmeterb > 0 then
  begin
    a2:=0;
    a3:=0;
    a4:=0;
    a6:=0;
    pmetere:=2;
    for a1:=201 downto 50 do
    begin
      a5:=Round(pmeterb*a1);
      if a4 = 0 then
      begin
        a4:=1;
        if a5 < 1000 then
        begin
          a6:=Trunc(a5);
          pmetere:=1;
        end else begin
          a6:=Trunc(a5/1000);
          pmetere:=2;
        end;
        a7:=IntToStr(a6);
        a8:=Length(a7);
        a9:=a6;
        if a8 = 2 then
        begin
          a6:=Trunc(a9/10)*10;
        end;
        if a8 = 3 then
        begin
          a6:=Trunc(a9/100)*100;
        end;
        if a8 = 4 then
        begin
          a6:=Trunc(a9/1000)*1000;
        end;
      end;
      a8:=Round(a5/1000);
      if a8 < a6 then
      begin
        if a2 = 0 then
        begin
          a2:=a1+1;
          a3:=a6;
        end;
      end;
    end;
  end;
  h2:=a2;
  h3:=a3;
  h4:=a7;
  for h1:=4 to 9 do
  begin
    PaintBox1.Canvas.MoveTo(h1,Round(PaintBox1.Height/2-h2/2));
    PaintBox1.Canvas.LineTo(h1,Round(PaintBox1.Height/2+h2/2));
  end;
  for h1:=Round(PaintBox1.Height/2-h2/2) to Round(PaintBox1.Height/2-h2/2)+4 do
  begin
    PaintBox1.Canvas.MoveTo(4,h1);
    PaintBox1.Canvas.LineTo(40,h1);
  end;
  for h1:=Round(PaintBox1.Height/2+h2/2)-4 to Round(PaintBox1.Height/2+h2/2) do
  begin
    PaintBox1.Canvas.MoveTo(4,h1);
    PaintBox1.Canvas.LineTo(40,h1);
  end;
  PaintBox1.Canvas.Brush.Style:=bsSolid;
  h4:=' Km';
  if pmetere = 1 then h4:=' m';
  aa:='Entfernung: '+IntToStr(h3)+h4;
  ab:=Length(aa);
  ad:=Round(PaintBox1.Height/2-h2/2)+5;
  for a1:=1 to ab do
  begin
    ac:=Copy(aa,a1,1);
    PaintBox1.Canvas.TextOut(24,ad,ac);
    ad:=ad+11;
  end;
end;

procedure TForm1.Mapan;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'ProcMap.jpg') then
  begin
    DeleteFile(ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  end;
  StringGrid1.Visible:=False;
  MapView1.Visible:=True;
  MapView1.Active:=True;
  MapView1.Zoom:=zoomfakt;
  Kartenpunkt.Lat:=hlat;
  Kartenpunkt.Lon:=hlong;
  MapView1.Center:=Kartenpunkt;
  MapView1.SaveToFile(TJpegImage, ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  MapView1.Visible:=False;
  PaintBox1.Visible:=True;
  SpeedButton1.Visible:=True;
  SpeedButton2.Visible:=True;
  SpeedButton3.Visible:=True;
  SpeedButton4.Visible:=True;
end;

procedure TForm1.Mapaus;
begin
  MapView1.Active:=False;
  MapView1.Visible:=False;
  PaintBox1.Visible:=False;
  SpeedButton1.Visible:=False;
  SpeedButton2.Visible:=False;
  SpeedButton3.Visible:=False;
  SpeedButton4.Visible:=False;
  StringGrid1.Visible:=True;
end;

procedure TForm1.PaintHome;
  var v8: double;
  var v9: double;
  var va: double;
  var vx: integer;
  var vy: integer;
begin
  if pfunkt <> 1 then
  begin
    if ((Homepunkt.Lat >= vonLat) and (Homepunkt.Lat <= bisLat)) then
    begin
      if ((Homepunkt.Lon >= vonLon) and (Homepunkt.Lon <= bisLon)) then
      begin
        v8:=bisLon-vonLon;
        v9:=1511/v8/1000;
        va:=Homepunkt.Lon-vonLon;
        vx:=Round(va*1000*v9)-XYKorrektur(zoomfakt, 1);
        v8:=bisLat-vonLat;
        v9:=672/v8/1000;
        va:=bisLat-Homepunkt.Lat;
        vy:=Round(va*1000*v9)+XYKorrektur(zoomfakt,2);
        PaintBox1.Canvas.Pen.Color:=clRed;
        PaintBox1.Canvas.Pen.Style:=psSolid;
        PaintBox1.Canvas.Pen.Width:=1;
        PaintBox1.Canvas.Brush.Color:=clRed;
        PaintBox1.Canvas.Brush.Style:=bsSolid;
        PaintBox1.Canvas.Font.Color:=clRed;
        PaintBox1.Canvas.Font.Size:=8;
        PaintBox1.Canvas.Font.Name:='Courier';
        PaintBox1.Canvas.Font.Style:=[fsBold];
        PaintBox1.Canvas.Ellipse(vx-5,vy-5,vx+5,vy+5);
        PaintBox1.Canvas.Brush.Style:=bsClear;
        PaintBox1.Canvas.TextOut(vx+7,vy-7,'Home');
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
  var heute: string;
  var h1: integer;
  var h3: string;
  var Rec: LongRec;
  var pi: TPlaneItem;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
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
  BUser:='                                                     ';
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
  Paintab:=0;
  Rec:=LongRec(GetFileVersion(ParamStr(0)));
  vers:=Format('%.*d.%.*d', [2, Rec.Hi,2, Rec.Lo]);
  ZConnection1.Connected:=False;
  ZQuery1.Active:=False;
  ZQuery2.Active:=False;
  planelist:=TPlaneList.Create;
  Form1.Caption:='                   F L I G H T R A D A R            Version '+vers+'                   <'+BUser+'>';
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if FileExists(ExtractFilePath(ParamStr(0))+'ProcMap.jpg') then
  begin
    DeleteFile(ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  end;
  pi:=TPlaneItem.Create;
  pi.PlaneStream:=nil;
  pi.PosX:=0;
  pi.PosY:=0;
  pi.Angle:=0;
  pi.Color:=clBlack;
  pi.HexId:='';
  pi.vonZeit:=now;
  pi.Hoehe:=0;
  planelist.Add(pi);
  zoomfakt:=11;
  MapView1.Visible:=True;
  MapView1.Active:=True;
  MapView1.Zoom:=11;
  Kartenpunkt.Lat:=49.509;
  Kartenpunkt.Lon:=8.533;
  MapView1.Center:=Kartenpunkt;
  MapView1.SaveToFile(TJpegImage, ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  MapView1.Active:=False;
  MapView1.Visible:=False;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  planelist.Delete(0);
  planelist.Free;
end;

procedure TForm1.ListBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var h1: string;
  var h2: integer;
  var h3: TDateTime;
  var hc: TDate;
  var hd: TTime;
  var he: TDate;
  var hf: TTime;
  var hg: TDateTime;
  var hh: String;
  var hi: integer;
  var hj: integer;
  var hk: integer;
  var hl: string;
begin
  if flightanz3 > 0 then
  begin
    if flightanz4 > 0 then
    begin
      if Button = mbRight then
      begin
        h2:=Trunc(Y/16);
        h1:=Listbox1.Items.Strings[h2];
        hg:=now;
        hh:=DateToStr(hg);
        hc:=StrToDate(hh);
        hh:=TimeToStr(hg);
        hd:=StrToTime(hh);
        h2:=0;
        hl:='N';
        Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE flight=:fly';
        Form1.ZQuery1.ParamByName('fly').asString:=h1;
        Form1.ZQuery1.Open;
        while not Form1.ZQuery1.EOF do
        begin
          if h2 = 0 then
          begin
            hg:=Form1.ZQuery1.Fields[1].AsDateTime;
            hl:=Form1.ZQuery1.Fields[15].AsString;
            hh:=DateToStr(hg);
            he:=StrToDate(hh);
            hh:=TimeToStr(hg);
            hf:=StrToTime(hh);
            hi:=HourOf(hd);
            hj:=HourOf(hf);
            hk:=hj+1;
            if hc = he then
            begin
              if ((hi>=hj) and (hi<=hk)) then
              begin
                h2:=1;
                h3:=hg;
              end;
            end;
          end;
          Form1.ZQuery1.Next;
        end;
        Form1.ZQuery1.Close;
        if hl = 'N' then
        begin
          if h2 = 1 then
          begin
            JaNein:=messagedlg('Flugverfolgung für '+h1+' starten ?', mtConfirmation, [mbYes, mbNo], 0);
            if (JaNein = mrYes) then
            begin
              SqlRet:=True;
              herrmsg:='';
              Label2.Caption:=herrmsg;
              Form1.ZQuery2.SQL.Clear;
              Form1.ZQuery2.SQL.Add('UPDATE flight SET verfolgung=:ver WHERE flight=:fly AND vonzeit=:vzt');
              Form1.ZQuery2.ParamByName('ver').asString:='J';
              Form1.ZQuery2.ParamByName('fly').asString:=h1;
              Form1.ZQuery2.ParamByName('vzt').asDateTime:=h3;
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
              if SqlRet then
              begin
                ListBox1.Items.BeginUpdate;
                ListBox1.Items.Strings[h2]:=h1+' V';
                ListBox1.Items.EndUpdate;
              end else begin
                Label2.Caption:='Fehler bei Update Flight (Flugverfolgung)';
              end;
            end;
          end;
        end else begin
          Label2.Caption:='Flugverfolgung für '+h1+' ist bereits an';
        end;
      end;
    end;
  end;
end;

procedure TForm1.MapView1Change(Sender: TObject);
  var XPos: integer;
  var YPos: integer;
begin
  XPos:=Trunc(MapView1.Width/2);
  YPos:=0;
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  bisLat:=Kartenpunkt.Lat;
  XPos:=Trunc(MapView1.Width/2);
  YPos:=MapView1.Height-1;
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  vonLat:=Kartenpunkt.Lat;
  XPos:=0;
  YPos:=Trunc(MapView1.Height/2);
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  vonLon:=Kartenpunkt.Lon;
  XPos:=MapView1.Width-1;
  YPos:=Trunc(MapView1.Height/2);
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  bisLon:=Kartenpunkt.Lon;
  mapnr:=zoomfakt;
  posi[mapnr].latvy:=vonLat;
  posi[mapnr].latby:=bisLat;
  posi[mapnr].longvx:=vonLon;
  posi[mapnr].longbx:=bisLon;
  if FileExists(ExtractFilePath(ParamStr(0))+'ProcMap.jpg') then
  begin
    DeleteFile(ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  end;
  MapView1.SaveToFile(TJpegImage, ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  PaintBox1.Repaint;
  Kartenpunkt:=MapView1.Center;
end;

procedure TForm1.MapView1ZoomChange(Sender: TObject);
  var XPos: integer;
  var YPos: integer;
  var spunkt: TRealPoint;
begin
  spunkt:=Kartenpunkt;
  XPos:=Trunc(MapView1.Width/2);
  YPos:=0;
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  bisLat:=Kartenpunkt.Lat;
  XPos:=Trunc(MapView1.Width/2);
  YPos:=MapView1.Height-1;
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  vonLat:=Kartenpunkt.Lat;
  XPos:=0;
  YPos:=Trunc(MapView1.Height/2);
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  vonLon:=Kartenpunkt.Lon;
  XPos:=MapView1.Width-1;
  YPos:=Trunc(MapView1.Height/2);
  Kartenpunkt:=MapView1.ScreenToLonLat(Point(XPos, YPos));
  bisLon:=Kartenpunkt.Lon;
  mapnr:=zoomfakt;
  posi[mapnr].latvy:=vonLat;
  posi[mapnr].latby:=bisLat;
  posi[mapnr].longvx:=vonLon;
  posi[mapnr].longbx:=bisLon;
  if FileExists(ExtractFilePath(ParamStr(0))+'ProcMap.jpg') then
  begin
    DeleteFile(ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  end;
  MapView1.SaveToFile(TJpegImage, ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  PaintBox1.Repaint;
  Kartenpunkt:=spunkt;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var h1: integer;
  var h2: integer;
  var h3: integer;
  var h4: integer;
  var h5: double;
  var h6: integer;
  var h7: integer;
  var h8: double;
  var h9: double;
  var ha: double;
  var hb: double;
  var hc: double;
  var hd: double;
  var he: double;
  var hf: integer;
  var hg: integer;
  var hh: string;
  var hi: string;
  var hj: integer;
  var hk: string;
  var hl: string;
  var hm: integer;
  var hn: string;
  var ho: integer;
  var hp: integer;
  var hq: integer;
  var hr: integer;
  var hs: integer;
  var ht: integer;
  var hu: integer;
  var hv: integer;
  var hw: string;
  var hx: string;
  var hy: TDateTime;
  var hz: integer;
begin
  if htimerrun > 0 then
  begin
    if flightanz3 > 0 then
    begin
      if Button = mbLeft then
      begin
        h2:=0;
        for h1:=1 to flightanz3 do
        begin
          hp:=flighttab3[h1].vx-31;
          if hp < 0 then hp:=0;
          hq:=flighttab3[h1].vx+31;
          if hq > 1511 then hq:=1511;
          hr:=flighttab3[h1].vy-31;
          if hr < 0 then hr:=0;
          hs:=flighttab3[h1].vy+31;
          if hs > 672 then hs:=672;
          if ((X >= hp) and (X <= hq) and (Y >= hr) and (Y <= hs)) then h2:=h1;
        end;
        if h2 > 0 then
        begin
          hz:=0;
          hw:=flighttab3[h2].hex;
          hx:=flighttab3[h2].flight;
          for h1:=1 to flightanz4 do
          begin
            if ((hw = flighttab4[h1].hex) and (hx = flighttab4[h1].flight)) then
            begin
              hy:=flighttab4[h1].vzeit;
              hz:=1;
            end;
          end;
          hw:='';
          hx:='';
          if hz = 1 then
          begin
            hx:=DateTimeToStr(hy);
            Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE hexid=:hid AND vonzeit=:vzt1';
            Form1.ZQuery1.ParamByName('hid').asString:=flighttab3[h2].hex;
            Form1.ZQuery1.ParamByName('vzt1').asDateTime:=StrToDateTime(hx);
            hx:='';
            Form1.ZQuery1.Open;
            while not Form1.ZQuery1.EOF do
            begin
              hw:=Form1.ZQuery1.Fields[16].AsString;
              hx:=Form1.ZQuery1.Fields[17].AsString;
              Form1.ZQuery1.Next;
            end;
            Form1.ZQuery1.Close;
          end;
          if bildgeklickt = 0 then
          begin
            bildgeklickt:=1;
            if textausgabe = 0 then
            begin
              nummerflug:=h2;
              ht:=0;
              while htimerrun > 0 do
              begin
                timeraus:=1;
                Application.ProcessMessages;
                sleep(100);
                ht:=ht+1;
                hu:=htimerrun;
                if ht > 21 then
                begin
                  htimerrun:=0;
                end;
              end;
              htimerrun:=hu;
              if htimerrun = 0 then
              begin
                PaintBox1.Canvas.Pen.Color:=clRed;
                PaintBox1.Canvas.Pen.Style:=psSolid;
                PaintBox1.Canvas.Pen.Width:=1;
                PaintBox1.Canvas.Brush.Color:=clWhite;
                PaintBox1.Canvas.Brush.Style:=bsSolid;
                PaintBox1.Canvas.Font.Color:=clWhite;
                PaintBox1.Canvas.Font.Size:=16;
                PaintBox1.Canvas.Font.Name:='Courier';
                PaintBox1.Canvas.Font.Style:=[fsBold];
                hgrid:=1;
                hk:='';
                ho:=0;
                hl:=flighttab3[h2].flight;
                hm:=Length(hl);
                if hm > 3 then
                begin
                  hn:=Copy(hl,1,3);
                  ialpha:=hl;
                  Privflug;
                  if inummer = 1 then hn:='001';
                  Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
                  Form1.ZQuery1.ParamByName('ica').asString:=hn;
                  Form1.ZQuery1.Open;
                  while not Form1.ZQuery1.EOF do
                  begin
                    ho:=1;
                    hk:=Form1.ZQuery1.Fields[0].AsString;
                    Form1.ZQuery1.Next;
                  end;
                  Form1.ZQuery1.Close;
                end;
                if ho = 0 then
                begin
                  if hm > 0 then
                  begin
                    h1:=0;
                    ialpha:=Copy(hl,1,1);
                    inummer:=1;
                    Nummer;
                    h6:=Length(ialpha);
                    if h6 > 0 then
                    begin
                     h1:=1;
                    end else begin
                      ialpha:=Copy(hl,2,1);
                      inummer:=1;
                      Nummer;
                      h6:=Length(ialpha);
                      if h6 > 0 then
                      begin
                        h1:=1;
                      end;
                    end;
                    if h1 = 1 then
                    begin
                      hn:='002';
                      Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
                      Form1.ZQuery1.ParamByName('ica').asString:=hn;
                      Form1.ZQuery1.Open;
                      while not Form1.ZQuery1.EOF do
                      begin
                        hk:=Form1.ZQuery1.Fields[0].AsString;
                        Form1.ZQuery1.Next;
                      end;
                      Form1.ZQuery1.Close;
                    end;
                  end;
                end;
                loeim2:=1;
                image2.Canvas.Pen.Color:=clBlack;
                image2.Canvas.Pen.Style:=psSolid;
                image2.Canvas.Pen.Width:=1;
                image2.Canvas.Brush.Color:=clBlack;
                image2.Canvas.Brush.Style:=bsSolid;
                image2.Canvas.Font.Color:=clWhite;
                image2.Canvas.Font.Size:=16;
                image2.Canvas.Font.Name:='Courier';
                image2.Canvas.Font.Style:=[fsBold];
                image2.Canvas.Brush.Style:=bsSolid;
                image2.Canvas.FillRect(0,0,image2.Width-1,image2.Height-1);
                h3:=20;
                h4:=20;
                image2.Canvas.TextOut(h3,h4,'Flight: '+flighttab3[h2].flight);
                h4:=h4+16;
                h5:=flighttab3[h2].alt*0.3;
                image2.Canvas.TextOut(h3,h4,'ALT: '+IntToStr(Round(h5))+' m');
                h4:=h4+16;
                h5:=flighttab3[h2].spd*1.852;
                image2.Canvas.TextOut(h3,h4,'Speed: '+FloatToStrF(h5,ffFixed,7,2)+' Km/h');
                h4:=h4+16;
                image2.Canvas.TextOut(h3,h4,'Heading: '+IntToStr(flighttab3[h2].hdg)+' °');
                h4:=h4+16;
                image2.Canvas.TextOut(h3,h4,'Fluggesellschaft: '+hk);
                h4:=h4+16;
                image2.Canvas.TextOut(h3,h4,'von: '+hw);
                h4:=h4+16;
                image2.Canvas.TextOut(h3,h4,'nach: '+hx);
                textflight:=flighttab3[h2].flight;
                if FileExists(ExtractFilePath(ParamStr(0))+'Flightdat.bmp') then
                begin
                  DeleteFile(ExtractFilePath(ParamStr(0))+'Flightdat.bmp');
                end;
                image2.Picture.Bitmap.SaveToFile(ExtractFilePath(ParamStr(0))+'Flightdat.bmp');
                PlaneList.Items[0].PlaneStream:=PrepareText;
                PlaneList.Items[0].Angle:=0;
                PlaneList.Items[0].PosX:=0;
                PlaneList.Items[0].PosY:=500;
                PlaneList.Items[0].Color:=clWhite;
                PlaneList.Items[0].HexId:=flighttab3[h2].hex;
                PlaneList.Items[0].vonZeit:=now;
                PlaneList.Items[0].Hoehe:=0;
                textflight:=flighttab3[h2].flight;
                textausgabe:=1;
                MapView1.Visible:=True;
                MapView1.Zoom:=zoomfakt;
                MapView1.Visible:=False;
              end;
            end else begin
              if h2 = nummerflug then
              begin
                textausgabe:=0;
                nummerflug:=0;
                MapView1.Visible:=True;
                MapView1.Zoom:=zoomfakt;
                MapView1.Visible:=False;
              end else begin
                nummerflug:=h2;
                textausgabe:=0;
                ht:=0;
                while htimerrun > 0 do
                begin
                  timeraus:=1;
                  Application.ProcessMessages;
                  sleep(100);
                  ht:=ht+1;
                  hu:=htimerrun;
                  if ht > 21 then
                  begin
                    htimerrun:=0;
                  end;
                end;
                htimerrun:=hu;
                if htimerrun = 0 then
                begin
                  PaintBox1.Canvas.Pen.Color:=clRed;
                  PaintBox1.Canvas.Pen.Style:=psSolid;
                  PaintBox1.Canvas.Pen.Width:=1;
                  PaintBox1.Canvas.Brush.Color:=clWhite;
                  PaintBox1.Canvas.Brush.Style:=bsSolid;
                  PaintBox1.Canvas.Font.Color:=clWhite;
                  PaintBox1.Canvas.Font.Size:=16;
                  PaintBox1.Canvas.Font.Name:='Courier';
                  PaintBox1.Canvas.Font.Style:=[fsBold];
                  hgrid:=1;
                  hk:='';
                  ho:=0;
                  hl:=flighttab3[h2].flight;
                  hm:=Length(hl);
                  if hm > 3 then
                  begin
                    hn:=Copy(hl,1,3);
                    ialpha:=hl;
                    Privflug;
                    if inummer = 1 then hn:='001';
                    Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
                    Form1.ZQuery1.ParamByName('ica').asString:=hn;
                    Form1.ZQuery1.Open;
                    while not Form1.ZQuery1.EOF do
                    begin
                      ho:=1;
                      hk:=Form1.ZQuery1.Fields[0].AsString;
                      Form1.ZQuery1.Next;
                    end;
                    Form1.ZQuery1.Close;
                  end;
                  if ho = 0 then
                  begin
                    if hm > 0 then
                    begin
                      h1:=0;
                      ialpha:=Copy(hl,1,1);
                      inummer:=1;
                      Nummer;
                      h6:=Length(ialpha);
                      if h6 > 0 then
                      begin
                       h1:=1;
                      end else begin
                        ialpha:=Copy(hl,2,1);
                        inummer:=1;
                        Nummer;
                        h6:=Length(ialpha);
                        if h6 > 0 then
                        begin
                          h1:=1;
                        end;
                      end;
                      if h1 = 1 then
                      begin
                        hn:='002';
                        Form1.ZQuery1.SQL.Text:='SELECT * FROM flightclub WHERE icao=:ica';
                        Form1.ZQuery1.ParamByName('ica').asString:=hn;
                        Form1.ZQuery1.Open;
                        while not Form1.ZQuery1.EOF do
                        begin
                          hk:=Form1.ZQuery1.Fields[0].AsString;
                          Form1.ZQuery1.Next;
                        end;
                        Form1.ZQuery1.Close;
                      end;
                    end;
                  end;
                  loeim2:=1;
                  image2.Canvas.Pen.Color:=clBlack;
                  image2.Canvas.Pen.Style:=psSolid;
                  image2.Canvas.Pen.Width:=1;
                  image2.Canvas.Brush.Color:=clBlack;
                  image2.Canvas.Brush.Style:=bsSolid;
                  image2.Canvas.Font.Color:=clWhite;
                  image2.Canvas.Font.Size:=16;
                  image2.Canvas.Font.Name:='Courier';
                  image2.Canvas.Font.Style:=[fsBold];
                  image2.Canvas.Brush.Style:=bsSolid;
                  image2.Canvas.FillRect(0,0,image2.Width-1,image2.Height-1);
                  h3:=20;
                  h4:=20;
                  image2.Canvas.TextOut(h3,h4,'Flight: '+flighttab3[h2].flight);
                  h4:=h4+16;
                  h5:=flighttab3[h2].alt*0.3;
                  image2.Canvas.TextOut(h3,h4,'ALT: '+IntToStr(Round(h5))+' m');
                  h4:=h4+16;
                  h5:=flighttab3[h2].spd*1.852;
                  image2.Canvas.TextOut(h3,h4,'Speed: '+FloatToStrF(h5,ffFixed,7,2)+' Km/h');
                  h4:=h4+16;
                  image2.Canvas.TextOut(h3,h4,'Heading: '+IntToStr(flighttab3[h2].hdg)+' °');
                  h4:=h4+16;
                  image2.Canvas.TextOut(h3,h4,'Fluggesellschaft: '+hk);
                  h4:=h4+16;
                  image2.Canvas.TextOut(h3,h4,'von: '+hw);
                  h4:=h4+16;
                  image2.Canvas.TextOut(h3,h4,'nach: '+hx);
                  textflight:=flighttab3[h2].flight;
                  if FileExists(ExtractFilePath(ParamStr(0))+'Flightdat.bmp') then
                  begin
                    DeleteFile(ExtractFilePath(ParamStr(0))+'Flightdat.bmp');
                  end;
                  image2.Picture.Bitmap.SaveToFile(ExtractFilePath(ParamStr(0))+'Flightdat.bmp');
                  PlaneList.Items[0].PlaneStream:=PrepareText;
                  PlaneList.Items[0].Angle:=0;
                  PlaneList.Items[0].PosX:=0;
                  PlaneList.Items[0].PosY:=500;
                  PlaneList.Items[0].Color:=clWhite;
                  PlaneList.Items[0].HexId:=flighttab3[h2].hex;
                  PlaneList.Items[0].vonZeit:=now;
                  PlaneList.Items[0].Hoehe:=0;
                  textflight:=flighttab3[h2].flight;
                  textausgabe:=1;
                  MapView1.Visible:=True;
                  MapView1.Zoom:=zoomfakt;
                  MapView1.Visible:=False;
                end else begin
                  textausgabe:=0;
                  nummerflug:=0;
                  MapView1.Visible:=True;
                  MapView1.Zoom:=zoomfakt;
                  MapView1.Visible:=False;
                end;
              end;
            end;
            hgrid:=0;
            timeraus:=0;
            sleep(2000);
            bildgeklickt:=0;
            Timer1.Enabled:=True;
          end;
        end;
      end;
      if Button = mbRight then
      begin
        hgrid:=1;
        h2:=0;
        for h1:=1 to flightanz3 do
        begin
          hp:=flighttab3[h1].vx-31;
          if hp < 0 then hp:=0;
          hq:=flighttab3[h1].vx+31;
          if hq > 1511 then hq:=1511;
          hr:=flighttab3[h1].vy-31;
          if hr < 0 then hr:=0;
          hs:=flighttab3[h1].vy+31;
          if hs > 672 then hs:=672;
          if ((X >= hp) and (X <= hq) and (Y >= hr) and (Y <= hs)) then h2:=h1;
        end;
        if h2 > 0 then
        begin
          hh:=flighttab3[h2].flight;
          h3:=Length(hh);
          if h3 > 0 then
          begin
            if bildgeklickt = 0 then
            begin
              bildgeklickt:=1;
              ht:=0;
              hv:=1;
              while hv = 1 do
              begin
                timeraus:=1;
                Application.ProcessMessages;
                sleep(100);
                ht:=ht+1;
                if htimerrun = 0 then
                begin
                  hv:=0;
                end else begin
                  if ht > 21 then
                  begin
                    hv:=0;
                  end;
                end;
              end;
              sleep(2000);
              if htimerrun = 0 then
              begin
                hv:=0;
                webseitegeladen:=0;
                ladenwebart:=0;
                ialpha:='https://de.flightaware.com/live/flight/'+hh;
                Blankwegh;
                URL:=ialpha;
                HTMLErr:=0;
                HTMLText:='';
                PaintBox1.Visible:=False;
                SpeedButton2.Visible:=False;
                SpeedButton2.Visible:=False;
                SpeedButton3.Visible:=False;
                SpeedButton4.Visible:=False;
                WVWindowParent2.Visible:=True;
                if GlobalWebView2Loader.InitializationError then
                begin
                  showmessage(UTF8Encode(GlobalWebView2Loader.ErrorMessage));
                end else begin
                  if GlobalWebView2Loader.Initialized then
                  begin
                    if WVBrowser2.Initialized then
                    begin
                      WVBrowser2.Navigate(UTF8Decode(URL));
                    end else begin
                      WVBrowser2.CreateBrowser(WVWindowParent2.Handle);
                    end;
                  end;
                end;
                ht:=0;
                while hv = 0 do
                begin
                  Application.ProcessMessages;
                  sleep(500);
                  ht:=ht+1;
                  if webseitegeladen = 1 then hv:=1;
                  if ht = loops then hv:=2;
                  if habb2 > 0 then hv:=3;
                  if HTMLErr > 0 then hv:=4;
                end;
                if hv = 1 then
                begin
                  if HTMLErr = 0 then
                  begin
                    Webanzeige:=1;
                    webanz:=1;
                    Edit99.Visible:=True;
                    Edit99.Refresh;
                    Form1.ActiveControl:=Edit99;
                    mittimeron:=1;
                  end;
                end;
              end;
              timeraus:=0;
              bildgeklickt:=0;
              sleep(2000);
            end;
          end;
        end;
        if webanz = 0 then
        begin
          hgrid:=0;
        end;
      end;
    end;
  end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
  var
    i, n: Integer;
    pi: TPlaneItem;
    bmp, pbmp: TBGRABitmap;
begin
  if Paintab = 0 then
  begin
    bmp := TBGRABitmap.Create(ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
    if planelist.Count > 1 then
    begin
      n:=1;
      if textausgabe = 1 then n:=0;
      for i:=n to planelist.Count-1 do
      begin
        pi := planelist.Items[i];
        pi.PlaneStream.Position := 0;
        pbmp := TBGRABitmap.Create(pi.PlaneStream);
        bmp.PutImage(pi.PosX, pi.PosY, pbmp, dmDrawWithTransparency);
        pbmp.Free;
      end;
    end;
    bmp.Draw(PaintBox1.Canvas, 0, 0);
    bmp.Free;
    PaintMassstab;
    PaintHome;
  end;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
  if zoomfakt > 2 then
  begin
    zoomfakt:=zoomfakt-1;
    SpeedButton2.Visible:=True;
  end;
  if zoomfakt = 2 then SpeedButton1.Visible:=False;
  zoomsi:=zoomfakt;
  MapView1.Visible:=True;
  MapView1.Zoom:=zoomfakt;
  MapView1.Visible:=False;
  if ((mgebiet > 0) and (mgebiet < 3)) then mgebiet:=1;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  if zoomfakt < 19 then
  begin
    zoomfakt:=zoomfakt+1;
    SpeedButton1.Visible:=True;
  end;
  if zoomfakt = 19 then SpeedButton2.Visible:=False;
  zoomsi:=zoomfakt;
  MapView1.Visible:=True;
  MapView1.Zoom:=zoomfakt;
  MapView1.Visible:=False;
  if ((mgebiet > 0) and (mgebiet < 3)) then mgebiet:=1;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
  PaintBox1.Visible:=False;
  MapView1.Visible:=True;
  SpeedButton1.Visible:=False;
  SpeedButton2.Visible:=False;
  SpeedButton3.Visible:=False;
  SpeedButton4.Visible:=False;
  Edit99.Visible:=True;
  Form1.ActiveControl:=Edit99;
  webanz:=1;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Kartenpunkt:=Homepunkt;
  MapView1.Visible:=True;
  MapView1.Center:=Kartenpunkt;
  MapView1.Visible:=False;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
  var h1: integer;
  var h2: integer;
  var h3: string;
  var h4: string;
  var h5: integer;
  var h6: integer;
  var h7: string;
  var h8: double;
  var h9: double;
  var ha: double;
  var hb: integer;
  var hc: TDate;
  var hd: TTime;
  var he: TDate;
  var hf: TTime;
  var hg: TDateTime;
  var hh: String;
  var hi: integer;
  var hj: integer;
  var hk: integer;
  var hl: integer;
  var vzt1: TDateTime;
  var hm: String;
  var hn: integer;
  var ho: integer;
  var hp: integer;
  var hq: integer;
  var hr: integer;
  var hs: double;
  var ht: double;
  var hu: double;
  var hv: double;
  var hw: double;
  var hx: integer;
  var hy: string;
  var v1: integer;
  var v2: integer;
  var v3: integer;
  var v4: integer;
  var v5: variant;
  var v6: Widestring;
  var v7: integer;
  var v8: Widestring;
  var va: string;
  var vb: string;
  var vc: Char;
  var vd: integer;
  var ve: integer;
  var vf: integer;
  var vg: integer;
  var vh: string;
  var vi: string;
  var vj: integer;
  var vk: TDateTime;
  var vl: String;
  var vm: TDate;
  var vn: TTime;
  var vo: string;
  var vp: integer;
  var vq: integer;
  var vr: TTime;
  var vs: integer;
  var vt: TDate;
  var filegr: File of Text;
  var loezaehl: integer;
begin
  if hgrid = 0 then
  begin
    Timer1.Enabled:=False;
    htimerrun:=2;
    if planelist.Count > 1 then
    begin
      if planelist.Count-1 > flightanz3 then
      begin
        for v7:=planelist.Count downto 2 do
        begin
          try
            planelist.Delete(v7-1);
          except
            on E: Exception do
            begin
              herrmsg:=E.Message;
            end;
          end;
        end;
      end;
      planelist.Count:=1;
      MapView1.Visible:=True;
      MapView1.Zoom:=zoomfakt;
      MapView1.Visible:=False;
    end;
    if textausgabe = 1 then
    begin
      if flightanz3 = 0 then
      begin
        textausgabe:=0;
        textflight:='';
        MapView1.Visible:=True;
        MapView1.Zoom:=zoomfakt;
        MapView1.Visible:=False;
      end else begin
        if textflight <> '' then
        begin
          vg:=0;
          for v7:=1 to flightanz3 do
          begin
            vh:=flighttab3[v7].flight;
            if vh = textflight then
            begin
              vg:=1;
            end;
          end;
          if vg = 0 then
          begin
            textausgabe:=0;
            textflight:='';
            MapView1.Visible:=True;
            MapView1.Zoom:=zoomfakt;
            MapView1.Visible:=False;
          end;
        end;
      end;
    end;
    v7:=0;
    vg:=0;
    ho:=1;
    hb:=0;
    hl:=0;
    flightanz3:=0;
    Label9.Caption:='';
    if flightanz4 > 0 then Label9.Caption:=IntToStr(flightanz4);
    ListBox1.Items.Clear;
    if habb = 0 then
    begin
      if FileExists(ExtractFilePath(ParamStr(0))+'daten.txt') then
      begin
        loezaehl:=0;
        if FileExists(ExtractFilePath(ParamStr(0))+'daten.fly') then
        begin
          AssignFile(filegr, ExtractFilePath(ParamStr(0))+'daten.fly');
          Reset(filegr);
          loezaehl:=FileSize(filegr);
          Closefile(filegr);
          DeleteFile(ExtractFilePath(ParamStr(0))+'daten.fly');
        end;
        hr:=0;
        if loezaehl > 4000 then
        begin
          hr:=1;
          h1:=ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-copy.bat'), nil, nil, SW_HIDE);
          sleep(zeit);
          if h1 = 42 then
          begin
            h1:=ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
            sleep(2000);
            if h1 = 42 then
            begin
              h1:=ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-batch.bat'), nil, nil, SW_SHOWMINIMIZED);
              sleep(5000);
              if h1 <> 42 then
              begin
                Label2.Caption:='ShellExecute Batch Returncode: '+IntToStr(h1);
                habb:=1;
                Label8.Caption:='';
                ListBox1.Items.Clear;
                ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
              end;
            end else begin
              Label2.Caption:='ShellExecute Abbruch Returncode: '+IntToStr(h1);
              habb:=1;
              Label8.Caption:='';
              ListBox1.Items.Clear;
              ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
            end;
          end else begin
            Label2.Caption:='ShellExecute Copy Returncode: '+IntToStr(h1);
            habb:=1;
            Label8.Caption:='';
            ListBox1.Items.Clear;
            ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
          end;
        end;
        h1:=42;
        if hr = 0 then
        begin
          h1:=ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-copy.bat'), nil, nil, SW_HIDE);
          sleep(zeit);
        end;
        if h1 = 42 then
        begin
          if FileExists(ExtractFilePath(ParamStr(0))+'daten.fly') then
          begin
            FileMode:=fmOpenRead;
            AssignFile(fnum, ExtractFilePath(ParamStr(0))+'daten.fly');
            hr:=0;
            try
              Reset(fnum);
            except
              hr:=1;
            end;
            if hr = 0 then
            begin
              ffehl:=0;
              ho:=1;
            end else begin
              ho:=0;
              ffehl:=ffehl+1;
              if ffehl > 3 then
              begin
                Label2.Caption:='File: '+ExtractFilePath(ParamStr(0))+'daten.fly nicht vorhanden, Abbruch';
                habb:=1;
                Label8.Caption:='';
                ListBox1.Items.Clear;
                ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
              end;
            end;
          end else begin
            ho:=0;
            ffehl:=ffehl+1;
            if ffehl > 3 then
            begin
              Label2.Caption:='File: '+ExtractFilePath(ParamStr(0))+'daten.fly nicht vorhanden, Abbruch';
              habb:=1;
              Label8.Caption:='';
              ListBox1.Items.Clear;
              ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
            end;
          end;
        end else begin
          Label2.Caption:='ShellExecute Copy Returncode: '+IntToStr(h1);
          habb:=1;
          Label8.Caption:='';
          ListBox1.Items.Clear;
          ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
        end;
      end else begin
        Label2.Caption:='File: '+ExtractFilePath(ParamStr(0))+'daten.txt nicht vorhanden, Abbruch';
        habb:=1;
        Label8.Caption:='';
        ListBox1.Items.Clear;
        ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
      end;
    end else begin
      Label8.Caption:='';
      ListBox1.Items.Clear;
    end;
    if habb = 0 then
    begin
      if ho = 1 then
      begin
        Lesen;
        CloseFile(fnum);
        if hl  = 0 then
        begin
          if imgloe = 1 then
          begin
            hl:=1;
            imgloe:=0;
          end;
        end;
        Label8.Caption:='';
        ListBox1.Items.Clear;
        if habb = 0 then
        begin
          if heof = 1 then
          begin
            ht:=latvy;
            hu:=latby;
            hv:=longvx;
            hw:=longbx;
            if flightanz2 > 0 then
            begin
              for h1:=1 to flightanz2 do
              begin
                ialpha:=flighttab2[h1];
                h2:=Length(ialpha);
                hq:=9999999;
                if h2 = 78 then
                begin
                  hx:=1;
                  h3:=Copy(ialpha,48,6);
                  if h3 = '      ' then
                  begin
                    hx:=0;
                  end else begin
                    h4:='';
                    h5:=Length(h3);
                    for h6:=1 to h5 do
                    begin
                      h7:=Copy(h3,h6,1);
                      if h7 = '.' then h7:=',';
                      h4:=h4+h7;
                    end;
                    hs:=StrToFloat(h4);
                  end;
                  h3:=Copy(ialpha,57,6);
                  if h3 = '      ' then
                  begin
                    hx:=0;
                  end else begin
                    h4:='';
                    h5:=Length(h3);
                    for h6:=1 to h5 do
                    begin
                      h7:=Copy(h3,h6,1);
                      if h7 = '.' then h7:=',';
                      h4:=h4+h7;
                    end;
                    hs:=StrToFloat(h4);
                  end;
                  if hx = 1 then
                  begin
                    hq:=0;
                    h3:=Copy(ialpha,1,6);
                    if flightanz3 > 0 then
                    begin
                      for hp:=1 to flightanz3 do
                      begin
                        h4:=flighttab3[hp].hex;
                        if h4 = h3 then hq:=hp;
                      end;
                    end;
                  end;
                  if hq <> 9999999 then
                  begin
                    if hq = 0 then
                    begin
                      v7:=1;
                      if flightanz3 < flightmax1 then
                      begin
                        flightanz3:=flightanz3+1;
                        hq:=flightanz3;
                        Label8.Caption:=IntToStr(flightanz3);
                        h3:=Copy(ialpha,1,6);
                        flighttab3[flightanz3].hex:=h3;
                        h3:=Copy(ialpha,9,1);
                        flighttab3[flightanz3].mode:=h3;
                        h3:=Copy(ialpha,15,4);
                        if h3 = '    ' then
                        begin
                          flighttab3[flightanz3].sqwk:=0;
                        end else begin
                          flighttab3[flightanz3].sqwk:=StrToInt(h3);
                        end;
                        h3:=Copy(ialpha,21,7);
                        flighttab3[flightanz3].flight:=h3;
                        if h3 <> '       ' then
                        begin
                          vi:='N';
                          vj:=0;
                          vk:=now;
                          vl:=DateToStr(vk);
                          vt:=StrToDate(vl);
                          vl:=TimeToStr(vk);
                          vr:=StrToTime(vl);
                          Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE flight=:fly';
                          Form1.ZQuery1.ParamByName('fly').asString:=h3;
                          Form1.ZQuery1.Open;
                          while not Form1.ZQuery1.EOF do
                          begin
                            if vj = 0 then
                            begin
                              vk:=Form1.ZQuery1.Fields[1].AsDateTime;
                              vo:=DateToStr(vk);
                              vm:=StrToDate(vo);
                              vo:=TimeToStr(vk);
                              vn:=StrToTime(vo);
                              vp:=HourOf(vr);
                              vq:=HourOf(vn);
                              vs:=vq+1;
                              if vt = vm then
                              begin
                                if ((vp>=vq) and (vp<=vs)) then
                                begin
                                  vj:=1;
                                  vi:=Form1.ZQuery1.Fields[15].AsString;
                                end;
                              end;
                            end;
                            Form1.ZQuery1.Next;
                          end;
                          Form1.ZQuery1.Close;
                          if vi = 'J' then
                          begin
                            ListBox1.Items.Add(h3+' V');
                          end else begin
                            ListBox1.Items.Add(h3);
                          end;
                        end;
                        h3:=Copy(ialpha,30,5);
                        if h3 = '     ' then
                        begin
                          flighttab3[flightanz3].alt:=0;
                        end else begin
                          flighttab3[flightanz3].alt:=StrToInt(h3);
                        end;
                        h3:=Copy(ialpha,37,3);
                        if h3 = '   ' then
                        begin
                          flighttab3[flightanz3].spd:=0;
                        end else begin
                          flighttab3[flightanz3].spd:=StrToInt(h3);
                        end;
                        h3:=Copy(ialpha,42,3);
                        if h3 = '   ' then
                        begin
                          flighttab3[flightanz3].hdg:=0;
                        end else begin
                          hx:=StrToInt(h3);
                          if hx > 360 then hx:=0;
                          flighttab3[flightanz3].hdg:=hx;
                        end;
                        h3:=Copy(ialpha,48,6);
                        if h3 = '      ' then
                        begin
                          flighttab3[flightanz3].lat:=0;
                        end else begin
                          h4:='';
                          h5:=Length(h3);
                          for h6:=1 to h5 do
                          begin
                            h7:=Copy(h3,h6,1);
                            if h7 = '.' then h7:=',';
                            h4:=h4+h7;
                          end;
                          flighttab3[flightanz3].lat:=StrToFloat(h4);
                        end;
                        h3:=Copy(ialpha,57,6);
                        if h3 = '      ' then
                        begin
                          flighttab3[flightanz3].long:=0;
                        end else begin
                          h4:='';
                          h5:=Length(h3);
                          for h6:=1 to h5 do
                          begin
                            h7:=Copy(h3,h6,1);
                            if h7 = '.' then h7:=',';
                            h4:=h4+h7;
                          end;
                          flighttab3[flightanz3].long:=StrToFloat(h4);
                        end;
                        h3:=Copy(ialpha,66,2);
                        if h3 = '  ' then
                        begin
                          flighttab3[flightanz3].sig:=0;
                        end else begin
                          flighttab3[flightanz3].sig:=StrToInt(h3);
                        end;
                        h3:=Copy(ialpha,70,4);
                        if h3 = '    ' then
                        begin
                          flighttab3[flightanz3].msgs:=0;
                        end else begin
                          flighttab3[flightanz3].msgs:=StrToInt(h3);
                        end;
                        h3:=Copy(ialpha,77,2);
                        if h3 = '  ' then
                        begin
                          flighttab3[flightanz3].ti:=0;
                        end else begin
                          flighttab3[flightanz3].ti:=StrToInt(h3);
                        end;
                      end;
                    end else begin
                      v7:=2;
                      h3:=Copy(ialpha,9,1);
                      flighttab3[hq].mode:=h3;
                      h3:=Copy(ialpha,15,4);
                      if h3 <> '    ' then
                      begin
                        flighttab3[hq].sqwk:=StrToInt(h3);
                      end;
                      h3:=Copy(ialpha,21,7);
                      flighttab3[hq].flight:=h3;
                      h3:=Copy(ialpha,30,5);
                      if h3 <> '     ' then
                      begin
                        flighttab3[hq].alt:=StrToInt(h3);
                      end;
                      h3:=Copy(ialpha,37,3);
                      if h3 <> '   ' then
                      begin
                        flighttab3[hq].spd:=StrToInt(h3);
                      end;
                      h3:=Copy(ialpha,42,3);
                      if h3 <> '   ' then
                      begin
                        hx:=StrToInt(h3);
                        if hx > 360 then hx:=0;
                        flighttab3[hq].hdg:=hx;
                      end;
                      h3:=Copy(ialpha,48,6);
                      if h3 <> '      ' then
                      begin
                        h4:='';
                        h5:=Length(h3);
                        for h6:=1 to h5 do
                        begin
                          h7:=Copy(h3,h6,1);
                          if h7 = '.' then h7:=',';
                          h4:=h4+h7;
                        end;
                        flighttab3[hq].lat:=StrToFloat(h4);
                      end;
                      h3:=Copy(ialpha,57,6);
                      if h3 <> '      ' then
                      begin
                        h4:='';
                        h5:=Length(h3);
                        for h6:=1 to h5 do
                        begin
                          h7:=Copy(h3,h6,1);
                          if h7 = '.' then h7:=',';
                          h4:=h4+h7;
                        end;
                        flighttab3[hq].long:=StrToFloat(h4);
                      end;
                      h3:=Copy(ialpha,66,2);
                      if h3 <> '  ' then
                      begin
                        flighttab3[hq].sig:=StrToInt(h3);
                      end;
                      h3:=Copy(ialpha,70,4);
                      if h3 <> '    ' then
                      begin
                        flighttab3[hq].msgs:=StrToInt(h3);
                      end;
                      h3:=Copy(ialpha,77,2);
                      if h3 <> '  ' then
                      begin
                        flighttab3[hq].ti:=StrToInt(h3);
                      end;
                    end;
                    flighttab3[hq].vx:=0;
                    flighttab3[hq].bx:=0;
                    flighttab3[hq].vy:=0;
                    flighttab3[hq].by:=0;
                    ialpha:=flighttab3[hq].flight;
                    Blankwegh;
                    Blankwegv;
                    if ialpha <> '' then
                    begin
                      if flighttab3[hq].alt > 0 then
                      begin
                        if flighttab3[hq].spd > 0 then
                        begin
                          if flighttab3[hq].hdg >= 0 then
                          begin
                            if flighttab3[hq].lat >= 0 then
                            begin
                              if flighttab3[hq].long >= 0 then
                              begin
                                h5:=0;
                                hb:=0;
                                if flightanz4 > 0 then
                                begin
                                  for h6:=1 to flightanz4 do
                                  begin
                                    if flighttab3[hq].hex = flighttab4[h6].hex then
                                    begin
                                      hg:=now;
                                      hh:=DateToStr(hg);
                                      hc:=StrToDate(hh);
                                      hh:=TimeToStr(hg);
                                      hd:=StrToTime(hh);
                                      hg:=flighttab4[h6].vzeit;
                                      hh:=DateToStr(hg);
                                      he:=StrToDate(hh);
                                      hh:=TimeToStr(hg);
                                      hf:=StrToTime(hh);
                                      hi:=HourOf(hd);
                                      hj:=HourOf(hf);
                                      hk:=hj+1;
                                      if hc = he then
                                      begin
                                        if ((hi>=hj) and (hi<=hk)) then
                                        begin
                                          h5:=h6;
                                        end;
                                      end;
                                    end;
                                  end;
                                  if h5 > 0 then
                                  begin
                                    vg:=h5;
                                    h6:=flighttab4[h5].art;
                                    flighttab4[h5].art:=h6+1;
                                    flighttab4[h5].bzeit:=now;
                                    flighttab4[h5].balt:=flighttab3[hq].alt;
                                    flighttab4[h5].bspd:=flighttab3[hq].spd;
                                    flighttab4[h5].bhdg:=flighttab3[hq].hdg;
                                    flighttab4[h5].blat:=flighttab3[hq].lat;
                                    flighttab4[h5].blong:=flighttab3[hq].long;
                                    vzt1:=flighttab4[h5].vzeit;
                                    hn:=h5;
                                    hb:=1;
                                  end else begin
                                    if flightanz4 < flightmax2 then
                                    begin
                                      flightanz4:=flightanz4+1;
                                      vg:=flightanz4;
                                      flighttab4[flightanz4].hex:=flighttab3[hq].hex;
                                      flighttab4[flightanz4].art:=1;
                                      flighttab4[flightanz4].vzeit:=now;
                                      flighttab4[flightanz4].bzeit:=now;
                                      flighttab4[flightanz4].flight:=flighttab3[hq].flight;
                                      flighttab4[flightanz4].valt:=flighttab3[hq].alt;
                                      flighttab4[flightanz4].balt:=flighttab3[hq].alt;
                                      flighttab4[flightanz4].vspd:=flighttab3[hq].spd;
                                      flighttab4[flightanz4].bspd:=flighttab3[hq].spd;
                                      flighttab4[flightanz4].vhdg:=flighttab3[hq].hdg;
                                      flighttab4[flightanz4].bhdg:=flighttab3[hq].hdg;
                                      flighttab4[flightanz4].vlat:=flighttab3[hq].lat;
                                      flighttab4[flightanz4].vlong:=flighttab3[hq].long;
                                      flighttab4[flightanz4].blat:=flighttab3[hq].lat;
                                      flighttab4[flightanz4].blong:=flighttab3[hq].long;
                                      vzt1:=flighttab4[flightanz4].vzeit;
                                      hn:=flightanz4;
                                      hb:=1;
                                      Label9.Caption:=IntToStr(flightanz4);
                                    end;
                                  end;
                                end else begin
                                  if flightanz4 < flightmax2 then
                                  begin
                                    flightanz4:=flightanz4+1;
                                    vg:=flightanz4;
                                    flighttab4[flightanz4].hex:=flighttab3[hq].hex;
                                    flighttab4[flightanz4].art:=1;
                                    flighttab4[flightanz4].vzeit:=now;
                                    flighttab4[flightanz4].bzeit:=now;
                                    flighttab4[flightanz4].flight:=flighttab3[hq].flight;
                                    flighttab4[flightanz4].valt:=flighttab3[hq].alt;
                                    flighttab4[flightanz4].balt:=flighttab3[hq].alt;
                                    flighttab4[flightanz4].vspd:=flighttab3[hq].spd;
                                    flighttab4[flightanz4].bspd:=flighttab3[hq].spd;
                                    flighttab4[flightanz4].vhdg:=flighttab3[hq].hdg;
                                    flighttab4[flightanz4].bhdg:=flighttab3[hq].hdg;
                                    flighttab4[flightanz4].vlat:=flighttab3[hq].lat;
                                    flighttab4[flightanz4].vlong:=flighttab3[hq].long;
                                    flighttab4[flightanz4].blat:=flighttab3[hq].lat;
                                    flighttab4[flightanz4].blong:=flighttab3[hq].long;
                                    vzt1:=flighttab4[flightanz4].vzeit;
                                    hn:=flightanz4;
                                    hb:=1;
                                    Label9.Caption:=IntToStr(flightanz4);
                                  end;
                                end;
                                if webanz = 0 then
                                begin
                                  if flightanz4 > 0 then
                                  begin
                                    Button3.Visible:=True;
                                    Label6.Visible:=False;
                                    Label7.Visible:=False;
                                    Label9.Caption:=IntToStr(flightanz4);
                                  end;
                                end;
                                Button3.Caption:='Anzeigen History an';
                                StringGrid1.Visible:=False;
                                hy:='N';
                                if hb = 1 then
                                begin
                                  hh:=DateTimeToStr(vzt1);
                                  h6:=0;
                                  if habb2 = 0 then
                                  begin
                                    Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE hexid=:hid AND vonzeit=:vzt1';
                                    Form1.ZQuery1.ParamByName('hid').asString:=flighttab4[hn].hex;
                                    Form1.ZQuery1.ParamByName('vzt1').asDateTime:=StrToDateTime(hh);
                                    Form1.ZQuery1.Open;
                                    while not Form1.ZQuery1.EOF do
                                    begin
                                      hy:=Form1.ZQuery1.Fields[15].AsString;
                                      h6:=1;
                                      Form1.ZQuery1.Next;
                                    end;
                                    Form1.ZQuery1.Close;
                                  end;
                                  if hy = 'J' then
                                  begin
                                    SqlRet:=True;
                                    herrmsg:='';
                                    Label2.Caption:=herrmsg;
                                    ZQuery2.SQL.Clear;
                                    ZQuery2.SQL.Add('INSERT INTO verfolgung (hexid, zeit, flight, alt, speed, heading, lat, longi) VALUES (:hid, :vzt, :fly, :valt, :vspe, :vhd, :vla, :vlo)');
                                    ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                    ZQuery2.ParamByName('vzt').asDateTime:=flighttab4[hn].bzeit;
                                    ZQuery2.ParamByName('fly').asString:=flighttab4[hn].flight;
                                    ZQuery2.ParamByName('valt').asInteger:=flighttab4[hn].balt;
                                    ZQuery2.ParamByName('vspe').asInteger:=flighttab4[hn].bspd;
                                    ZQuery2.ParamByName('vhd').asInteger:=flighttab4[hn].bhdg;
                                    ZQuery2.ParamByName('vla').asFloat:=flighttab4[hn].blat;
                                    ZQuery2.ParamByName('vlo').asFloat:=flighttab4[hn].blong;
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
                                      Label2.Caption:=herrmsg+'  Fehler beim Anlegen flight (Verfolgung), Abbruch';
                                      habb:=2;
                                    end;
                                  end;
                                  if h6 = 1 then
                                  begin
                                    hm:=DateTimeToStr(vzt1);
                                    SqlRet:=True;
                                    feldalt:=DateTimeToStr(alttab[hn].altbzeit);
                                    feldneu:=DateTimeToStr(flighttab4[hn].bzeit);
                                    herrmsg:='';
                                    Label2.Caption:=herrmsg;
                                    if feldalt <> feldneu then
                                    begin
                                      ZQuery2.SQL.Clear;
                                      ZQuery2.SQL.Add('UPDATE flight SET biszeit=:bzt WHERE hexid=:hid AND vonzeit=:vzt');
                                      ZQuery2.ParamByName('bzt').asDateTime:=flighttab4[hn].bzeit;
                                      ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                      ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hm);
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
                                      alttab[hn].altbzeit:=flighttab4[hn].bzeit;
                                      hm:=DateTimeToStr(vzt1);
                                      SqlRet:=True;
                                      herrmsg:='';
                                      feldalt:=IntToStr(alttab[hn].altbalt);
                                      feldneu:=IntToStr(flighttab4[hn].balt);
                                      Label2.Caption:=herrmsg;
                                      if feldalt <> feldneu then
                                      begin
                                        ZQuery2.SQL.Clear;
                                        ZQuery2.SQL.Add('UPDATE flight SET balt=:balt WHERE hexid=:hid AND vonzeit=:vzt');
                                        ZQuery2.ParamByName('balt').asInteger:=flighttab4[hn].balt;
                                        ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                        ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hm);
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
                                        alttab[hn].altbalt:=flighttab4[hn].balt;
                                        hm:=DateTimeToStr(vzt1);
                                        SqlRet:=True;
                                        herrmsg:='';
                                        feldalt:=IntToStr(alttab[hn].altbspd);
                                        feldneu:=IntToStr(flighttab4[hn].bspd);
                                        Label2.Caption:=herrmsg;
                                        if feldalt <> feldneu then
                                        begin
                                          ZQuery2.SQL.Clear;
                                          ZQuery2.SQL.Add('UPDATE flight SET bspeed=:bspe WHERE hexid=:hid AND vonzeit=:vzt');
                                          ZQuery2.ParamByName('bspe').asInteger:=flighttab4[hn].bspd;
                                          ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                          ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hm);
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
                                          alttab[hn].altbspd:=flighttab4[hn].bspd;
                                          hm:=DateTimeToStr(vzt1);
                                          SqlRet:=True;
                                          herrmsg:='';
                                          feldalt:=IntToStr(alttab[hn].altbhdg);
                                          feldneu:=IntToStr(flighttab4[hn].bhdg);
                                          Label2.Caption:=herrmsg;
                                          if feldalt <> feldneu then
                                          begin
                                            ZQuery2.SQL.Clear;
                                            ZQuery2.SQL.Add('UPDATE flight SET bheading=:bhd WHERE hexid=:hid AND vonzeit=:vzt');
                                            ZQuery2.ParamByName('bhd').asInteger:=flighttab4[hn].bhdg;
                                            ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                            ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hm);
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
                                            alttab[hn].altbhdg:=flighttab4[hn].bhdg;
                                            hm:=DateTimeToStr(vzt1);
                                            SqlRet:=True;
                                            herrmsg:='';
                                            feldalt:=FloatToStr(alttab[hn].altblat);
                                            feldneu:=FloatToStr(flighttab4[hn].blat);
                                            Label2.Caption:=herrmsg;
                                            if feldalt <> feldneu then
                                            begin
                                              ZQuery2.SQL.Clear;
                                              ZQuery2.SQL.Add('UPDATE flight SET blat=:bla WHERE hexid=:hid AND vonzeit=:vzt');
                                              ZQuery2.ParamByName('bla').asFloat:=flighttab4[hn].blat;
                                              ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                              ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hm);
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
                                              alttab[hn].altblat:=flighttab4[hn].blat;
                                              hm:=DateTimeToStr(vzt1);
                                              SqlRet:=True;
                                              herrmsg:='';
                                              feldalt:=FloatToStr(alttab[hn].altblong);
                                              feldneu:=FloatToStr(flighttab4[hn].blong);
                                              Label2.Caption:=herrmsg;
                                              if feldalt <> feldneu then
                                              begin
                                                ZQuery2.SQL.Clear;
                                                ZQuery2.SQL.Add('UPDATE flight SET blong=:blo WHERE hexid=:hid AND vonzeit=:vzt');
                                                ZQuery2.ParamByName('blo').asFloat:=flighttab4[hn].blong;
                                                ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                                ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hm);
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
                                                alttab[hn].altblong:=flighttab4[hn].blong;
                                                hm:=DateTimeToStr(vzt1);
                                                SqlRet:=True;
                                                herrmsg:='';
                                                feldalt:=IntToStr(alttab[hn].altart);
                                                feldneu:=IntToStr(flighttab4[hn].art);
                                                Label2.Caption:=herrmsg;
                                                if feldalt <> feldneu then
                                                begin
                                                  ZQuery2.SQL.Clear;
                                                  ZQuery2.SQL.Add('UPDATE flight SET anz=:anz WHERE hexid=:hid AND vonzeit=:vzt');
                                                  ZQuery2.ParamByName('anz').asInteger:=flighttab4[hn].art;
                                                  ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                                  ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hm);
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
                                                  alttab[hn].altart:=flighttab4[hn].art;
                                                end;
                                                if not SqlRet then
                                                begin
                                                  Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                                  habb:=2;
                                                end;
                                              end else begin
                                                Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                                habb:=2;
                                              end;
                                            end else begin
                                              Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                              habb:=2;
                                            end;
                                          end else begin
                                            Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                            habb:=2;
                                          end;
                                        end else begin
                                          Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                          habb:=2;
                                        end;
                                      end else begin
                                        Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                        habb:=2;
                                      end;
                                    end else begin
                                      Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                      habb:=2;
                                    end;
                                  end else begin
                                    SqlRet:=False;
                                    if habb2 = 0 then
                                    begin
                                      SqlRet:=True;
                                      herrmsg:='';
                                      Label2.Caption:=herrmsg;
                                      ZQuery2.SQL.Clear;
                                      ialpha:='INSERT INTO flight (hexid, vonzeit, biszeit, flight, valt, balt, vspeed, bspeed, vheading, bheading, vlat, vlong, blat, blong, anz, verfolgung, von, nach, ftyp) ';
                                      ialpha:=ialpha+'VALUES (:hid, :vzt, :bzt, :fly, :valt, :balt, :vspe, :bspe, :vhd, :bhd, :vla, :vlo, :bla, :blo, :anz, :ver, :von, :nach, :ftyp)';
                                      ZQuery2.SQL.Add(ialpha);
                                      ZQuery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                      ZQuery2.ParamByName('vzt').asDateTime:=flighttab4[hn].vzeit;
                                      ZQuery2.ParamByName('bzt').asDateTime:=flighttab4[hn].bzeit;
                                      ZQuery2.ParamByName('fly').asString:=flighttab4[hn].flight;
                                      ZQuery2.ParamByName('valt').asInteger:=flighttab4[hn].valt;
                                      ZQuery2.ParamByName('balt').asInteger:=flighttab4[hn].valt;
                                      ZQuery2.ParamByName('vspe').asInteger:=flighttab4[hn].vspd;
                                      ZQuery2.ParamByName('bspe').asInteger:=flighttab4[hn].vspd;
                                      ZQuery2.ParamByName('vhd').asInteger:=flighttab4[hn].vhdg;
                                      ZQuery2.ParamByName('bhd').asInteger:=flighttab4[hn].bhdg;
                                      ZQuery2.ParamByName('vla').asFloat:=flighttab4[hn].vlat;
                                      ZQuery2.ParamByName('vlo').asFloat:=flighttab4[hn].vlong;
                                      ZQuery2.ParamByName('bla').asFloat:=flighttab4[hn].blat;
                                      ZQuery2.ParamByName('blo').asFloat:=flighttab4[hn].blong;
                                      ZQuery2.ParamByName('anz').asInteger:=flighttab4[hn].art;
                                      ZQuery2.ParamByName('ver').asString:='N';
                                      ZQuery2.ParamByName('von').asString:='';
                                      ZQuery2.ParamByName('nach').asString:='';
                                      ZQuery2.ParamByName('ftyp').asString:='';
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
                                      alttab[hn].althex:=flighttab4[hn].hex;
                                      alttab[hn].altart:=flighttab4[hn].art;
                                      alttab[hn].altvzeit:=flighttab4[hn].vzeit;
                                      alttab[hn].altbzeit:=flighttab4[hn].bzeit;
                                      alttab[hn].altflight:=flighttab4[hn].flight;
                                      alttab[hn].altvalt:=flighttab4[hn].valt;
                                      alttab[hn].altbalt:=flighttab4[hn].balt;
                                      alttab[hn].altvspd:=flighttab4[hn].vspd;
                                      alttab[hn].altbspd:=flighttab4[hn].bspd;
                                      alttab[hn].altvhdg:=flighttab4[hn].vhdg;
                                      alttab[hn].altbhdg:=flighttab4[hn].bhdg;
                                      alttab[hn].altvlat:=flighttab4[hn].vlat;
                                      alttab[hn].altvlong:=flighttab4[hn].vlong;
                                      alttab[hn].altblat:=flighttab4[hn].blat;
                                      alttab[hn].altblong:=flighttab4[hn].blong;
                                      alttab[hn].altvon:='';
                                      alttab[hn].altnach:='';
                                      alttab[hn].altftyp:='';
                                      if flighttab4[hn].flight <> '       ' then
                                      begin
                                        murllad:=0;
                                        webseitegeladen:=0;
                                        ladenwebart:=1;
                                        ialpha:='https://de.flightaware.com/live/flight/'+flighttab4[hn].flight;
                                        Blankwegh;
                                        murl:=ialpha;
                                        URL:=murl;
                                        HTMLErr:=0;
                                        HTMLText:='';
                                        if GlobalWebView2Loader.InitializationError then
                                        begin
                                          showmessage(UTF8Encode(GlobalWebView2Loader.ErrorMessage));
                                        end else begin
                                          if GlobalWebView2Loader.Initialized then
                                          begin
                                            if WVBrowser1.Initialized then
                                            begin
                                              WVBrowser1.Navigate(UTF8Decode(URL));
                                            end else begin
                                              WVBrowser1.CreateBrowser(WVWindowParent1.Handle);
                                            end;
                                          end;
                                        end;
                                        v2:=0;
                                        while murllad = 0 do
                                        begin
                                          Application.ProcessMessages;
                                          sleep(500);
                                          v2:=v2+1;
                                          if webseitegeladen = 2 then murllad:=1;
                                          if v2 = loops then murllad:=2;
                                          if habb2 > 0 then murllad:=3;
                                          if HTMLErr > 0 then murllad:=4;
                                        end;
                                        if murllad = 1 then
                                        begin
                                          if HTMLErr = 0 then
                                          begin
                                            v6:=HTMLText;
                                            v2:=Length(v6);
                                            if v2 > 0 then
                                            begin
                                              ialpha:=flighttab4[hn].flight;
                                              Blankwegh;
                                              v2:=Length(ialpha);
                                              if v2 > 1 then
                                              begin
                                                v8:=Copy(ialpha,2,v2-1);
                                                v1:=Pos(v8, v6);
                                                if v1 > 0 then
                                                begin
                                                  v8:='flightPageSummaryAirportLink';
                                                  v1:=Pos(v8, v6);
                                                  if v1 > 0 then
                                                  begin
                                                    ialpha:=Copy(v6,v1,250);
                                                    va:='';
                                                    FSatz:=Copy(ialpha,61,1);
                                                    vc:=FSatz[1];
                                                    vd:=39;
                                                    ve:=Ord(vc);
                                                    if vd <> ve then
                                                    begin
                                                      FSatz:=Copy(ialpha,68,1);
                                                      vc:=FSatz[1];
                                                      vd:=39;
                                                      ve:=Ord(vc);
                                                      if vd <> ve then
                                                      begin
                                                        v2:=Length(ialpha);
                                                        v3:=1;
                                                        for v4:=76 to v2 do
                                                        begin
                                                          if v3 = 1 then
                                                          begin
                                                            FSatz:=Copy(ialpha,v4,1);
                                                            if FSatz <> '-' then
                                                            begin
                                                              va:=va+FSatz;
                                                            end else begin
                                                              v3:=0;
                                                            end;
                                                          end;
                                                        end;
                                                      end else begin
                                                        v8:='origin'+chr(34)+':{'+chr(34)+'TZ';
                                                        v1:=Pos(v8, v6, v1);
                                                        if v1 > 0 then
                                                        begin
                                                          v8:='friendlyName';
                                                          v1:=Pos(v8, v6, v1);
                                                          if v1 > 0 then
                                                          begin
                                                            ialpha:=Copy(v6,v1,100);
                                                            v3:=1;
                                                            for v4:=16 to 100 do
                                                            begin
                                                              if v3 = 1 then
                                                              begin
                                                                FSatz:=Copy(ialpha,v4,1);
                                                                vc:=FSatz[1];
                                                                vd:=34;
                                                                ve:=Ord(vc);
                                                                if vd <> ve then
                                                                begin
                                                                  va:=va+FSatz;
                                                                end else begin
                                                                  v3:=0;
                                                                end;
                                                              end;
                                                            end;
                                                          end;
                                                        end;
                                                      end;
                                                    end;
                                                    v2:=v1+10;
                                                    vf:=v2;
                                                    v8:='flightPageSummaryAirportLink';
                                                    v1:=Pos(v8, v6, v2);
                                                    if v1 > 0 then
                                                    begin
                                                      ialpha:=Copy(v6,v1,250);
                                                      vb:='';
                                                      FSatz:=Copy(ialpha,61,1);
                                                      vc:=FSatz[1];
                                                      vd:=39;
                                                      ve:=Ord(vc);
                                                      if vd <> ve then
                                                      begin
                                                        FSatz:=Copy(ialpha,68,1);
                                                        vc:=FSatz[1];
                                                        vd:=39;
                                                        ve:=Ord(vc);
                                                        if vd <> ve then
                                                        begin
                                                          v2:=Length(ialpha);
                                                          v3:=1;
                                                          for v4:=76 to v2 do
                                                          begin
                                                            if v3 = 1 then
                                                            begin
                                                              FSatz:=Copy(ialpha,v4,1);
                                                              if FSatz <> '-' then
                                                              begin
                                                                vb:=vb+FSatz;
                                                              end else begin
                                                                v3:=0;
                                                              end;
                                                            end;
                                                          end;
                                                        end;
                                                      end;
                                                    end;
                                                    if vb = '' then
                                                    begin
                                                      v8:='destination';
                                                      v1:=Pos(v8, v6, vf);
                                                      if v1 > 0 then
                                                      begin
                                                        v8:='friendlyName';
                                                        v1:=Pos(v8, v6, v1);
                                                        if v1 > 0 then
                                                        begin
                                                          ialpha:=Copy(v6,v1,100);
                                                          v3:=1;
                                                          for v4:=16 to 100 do
                                                          begin
                                                            if v3 = 1 then
                                                            begin
                                                              FSatz:=Copy(ialpha,v4,1);
                                                              vc:=FSatz[1];
                                                              vd:=34;
                                                              ve:=Ord(vc);
                                                              if vd <> ve then
                                                              begin
                                                                vb:=vb+FSatz;
                                                              end else begin
                                                                v3:=0;
                                                              end;
                                                            end;
                                                          end;
                                                        end;
                                                      end;
                                                    end;
                                                    if vb <> '' then
                                                    begin
                                                      v2:=Length(vb);
                                                      if v2 > 3 then
                                                      begin
                                                        FSatz:=Copy(vb,1,4);
                                                        if FSatz = 'ull,' then vb:='';
                                                        if FSatz = '{nam' then vb:='';
                                                      end;
                                                    end;
                                                    hh:=DateTimeToStr(flighttab4[hn].vzeit);
                                                    v2:=Length(va);
                                                    if v2 > 0 then
                                                    begin
                                                      SqlRet:=True;
                                                      herrmsg:='';
                                                      feldalt:=alttab[hn].altvon;
                                                      feldneu:=va;
                                                      Label2.Caption:=herrmsg;
                                                      if feldalt <> feldneu then
                                                      begin
                                                        ZQuery2.SQL.Clear;
                                                        ZQuery2.SQL.Add('UPDATE flight SET von=:von WHERE hexid=:hid AND vonzeit=:vzt');
                                                        ZQuery2.ParamByName('von').asString:=va;
                                                        Zquery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                                        ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hh);
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
                                                      alttab[hn].altvon:=va;
                                                      if not SqlRet then
                                                      begin
                                                        Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                                        habb:=2;
                                                      end;
                                                    end;
                                                    v2:=Length(vb);
                                                    if v2 > 0 then
                                                    begin
                                                      SqlRet:=True;
                                                      herrmsg:='';
                                                      feldalt:=alttab[hn].altnach;
                                                      feldneu:=vb;
                                                      Label2.Caption:=herrmsg;
                                                      if feldalt <> feldneu then
                                                      begin
                                                        ZQuery2.SQL.Clear;
                                                        ZQuery2.SQL.Add('UPDATE flight SET nach=:nach WHERE hexid=:hid AND vonzeit=:vzt');
                                                        ZQuery2.ParamByName('nach').asString:=vb;
                                                        Zquery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                                        ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hh);
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
                                                      alttab[hn].altnach:=vb;
                                                      if not SqlRet then
                                                      begin
                                                        Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                                        habb:=2;
                                                      end;
                                                    end;
                                                  end;
                                                  v8:='aircraft_make';
                                                  v1:=Pos(v8, v6);
                                                  if v1 > 0 then
                                                  begin
                                                    ialpha:=Copy(v6,v1,250);
                                                    va:='';
                                                    vb:='';
                                                    FSatz:=Copy(ialpha,16,10);
                                                    vc:=FSatz[1];
                                                    vd:=32;
                                                    ve:=Ord(vc);
                                                    if vd = ve then
                                                    begin
                                                      v3:=1;
                                                      for v4:=18 to 67 do
                                                      begin
                                                        if v3 = 1 then
                                                        begin
                                                          FSatz:=Copy(ialpha,v4,1);
                                                          vc:=FSatz[1];
                                                          ve:=Ord(vc);
                                                          vd:=39;
                                                          if vd = ve then
                                                          begin
                                                            v3:=0;
                                                          end else begin
                                                            va:=va+FSatz;
                                                          end;
                                                        end;
                                                      end;
                                                    end;
                                                    if va <> '' then
                                                    begin
                                                      v8:='aircraft_model';
                                                      v1:=Pos(v8, v6, v1);
                                                      if v1 > 0 then
                                                      begin
                                                        ialpha:=Copy(v6,v1,250);
                                                        FSatz:=Copy(ialpha,17,10);
                                                        vc:=FSatz[1];
                                                        vd:=32;
                                                        ve:=Ord(vc);
                                                        if vd = ve then
                                                        begin
                                                          v3:=1;
                                                          for v4:=19 to 67 do
                                                          begin
                                                            if v3 = 1 then
                                                            begin
                                                              FSatz:=Copy(ialpha,v4,1);
                                                              vc:=FSatz[1];
                                                              ve:=Ord(vc);
                                                              vd:=39;
                                                              if vd = ve then
                                                              begin
                                                                v3:=0;
                                                              end else begin
                                                                vb:=vb+FSatz;
                                                              end;
                                                            end;
                                                          end;
                                                        end;
                                                      end;
                                                      if vb <> '' then
                                                      begin
                                                        va:=va+' '+vb;
                                                      end;
                                                    end;
                                                    hh:=DateTimeToStr(flighttab4[hn].vzeit);
                                                    v2:=Length(va);
                                                    if v2 > 0 then
                                                    begin
                                                      SqlRet:=True;
                                                      herrmsg:='';
                                                      feldalt:=alttab[hn].altftyp;
                                                      feldneu:=va;
                                                      Label2.Caption:=herrmsg;
                                                      if feldalt <> feldneu then
                                                      begin
                                                        ZQuery2.SQL.Clear;
                                                        ZQuery2.SQL.Add('UPDATE flight SET ftyp=:ftyp WHERE hexid=:hid AND vonzeit=:vzt');
                                                        ZQuery2.ParamByName('ftyp').asString:=va;
                                                        Zquery2.ParamByName('hid').asString:=flighttab4[hn].hex;
                                                        ZQuery2.ParamByName('vzt').asDateTime:=StrToDateTime(hh);
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
                                                      alttab[hn].altftyp:=va;
                                                      if not SqlRet then
                                                      begin
                                                        Label2.Caption:=herrmsg+'  Fehler beim Updaten flight, Abbruch';
                                                        habb:=2;
                                                      end;
                                                    end;
                                                  end;
                                                end;
                                              end;
                                            end;
                                          end else begin
                                            Label2.Caption:='Fehler beim Laden Webseite <'+murl+'> HTML, Abbruch';
                                            habb:=2;
                                          end;
                                        end else begin
                                          if murllad <> 3 then
                                          begin
                                            Label2.Caption:='Fehler beim Laden Webseite <'+murl+'>, Abbruch';
                                            habb:=2;
                                          end;
                                        end;
                                      end;
                                    end else begin
                                      if habb2 = 0 then
                                      begin
                                        Label2.Caption:=herrmsg+'  Fehler beim Anlegen flight, Abbruch';
                                        habb:=2;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;
                      if habb = 0 then
                      begin
                        if flighttab3[hq].lat > 0 then
                        begin
                          if flighttab3[hq].long > 0 then
                          begin
                            if ((flighttab3[hq].lat >= latvy) and (flighttab3[hq].lat <= latby)) then
                            begin
                              if ((flighttab3[hq].long >= longvx) and (flighttab3[hq].long <= longbx)) then
                              begin
                                h8:=longbx-longvx;
                                h9:=1511/h8/1000;
                                ha:=flighttab3[hq].long-longvx;
                                flugx:=Round(ha*1000*h9);
                                h8:=latby-latvy;
                                h9:=672/h8/1000;
                                ha:=latby-flighttab3[hq].lat;
                                flugy:=Round(ha*1000*h9);
                                flugh:=flighttab3[hq].alt;
                                flugr:=flighttab3[hq].hdg;
                                if flugx >= 0 then
                                begin
                                  if flugy >= 0 then
                                  begin
                                    if flugx <= 1511 then
                                    begin
                                      if flugy <= 672 then
                                      begin
                                        if v7 > 0 then
                                        begin
                                          if vg > 0 then
                                          begin
                                            flugzeugnr:=flightanz3;
                                            flugzeugrichtung:=flugr;
                                            flugzeugX:=flugx;
                                            flighttab3[hq].vx:=flugx;
                                            flighttab3[hq].bx:=flugx;
                                            flugzeugY:=flugy;
                                            flighttab3[hq].vy:=flugy;
                                            flighttab3[hq].by:=flugy;
                                            flugzeughexid:=flighttab4[vg].hex;
                                            flugzeugzeit:=flighttab4[vg].vzeit;
                                            flugzeughoehe:=flugh;
                                            zeichenart:=v7;    // 1=neues Flugzeug    2=Weiterflug
                                            zeichne;
                                          end;
                                        end;
                                      end;
                                    end;
                                  end;
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
    if ((habb = 0) and (habb2 = 0)) then
    begin
      htimerrun:=0;
      if ((Webanzeige = 0) and (timeraus = 0)) then
      begin
        Timer1.Enabled:=True;
        htimerrun:=1;
      end;
      hgrid:=0;
    end else begin
      if planelist.Count > 1 then
      begin
        for v7:=planelist.Count downto 2 do
        begin
          try
            planelist.Delete(v7-1);
          except
            on E: Exception do
            begin
              herrmsg:=E.Message;
            end;
          end;
        end;
        planelist.Count:=1;
        textausgabe:=0;
        MapView1.Visible:=True;
        MapView1.Zoom:=zoomfakt;
        MapView1.Visible:=False;
      end;
      if textausgabe = 1 then
      begin
        textausgabe:=0;
        MapView1.Visible:=True;
        MapView1.Zoom:=zoomfakt;
        MapView1.Visible:=False;
      end;
      mtasts:=1;
      Button1.Caption:='Start FlightRadar';
      Label6.Visible:=True;
      Label7.Visible:=True;
      Label9.Caption:='';
      Button3.Visible:=False;
      if flightanz4 > 0 then
      begin
        Button3.Visible:=True;
        Label6.Visible:=False;
        Label7.Visible:=False;
        Label9.Caption:=IntToStr(flightanz4);
      end;
      Button3.Caption:='Anzeigen History an';
      Label8.Caption:='';
      ListBox1.Items.Clear;
      StringGrid1.Visible:=False;
      hgrid:=0;
      htimerrun:=0;
      Webanzeige:=0;
      webanz:=0;
      timeraus:=0;
      textflight:='';
      bildgeklickt:=0;
      nummerflug:=0;
      ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
    end;
  end;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
  var h2: string;
  var h3: integer;
  var h4: string;
begin
  if Paintab = 0 then
  begin
    h2:=DateTimeToStr(now);
    h4:='';
    h3:=DayOfWeek(now);
    if h3 = 1 then h4:='Sonntag';
    if h3 = 2 then h4:='Montag';
    if h3 = 3 then h4:='Dienstag';
    if h3 = 4 then h4:='Mittwoch';
    if h3 = 5 then h4:='Donnerstag';
    if h3 = 6 then h4:='Freitag';
    if h3 = 7 then h4:='Samstag';
    Label10.Caption:=h4+' '+h2;
    Label10.Refresh;
  end;
end;

procedure TForm1.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  WVBrowser1.Navigate(UTF8Decode(URL));
end;

procedure TForm1.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(UTF8Encode(aErrorMessage));
  HTMLErr:=2;
end;

procedure TForm1.WVBrowser1NavigationCompleted(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  WVBrowser1.RetrieveHTML;
  webseitegeladen:=1;
end;
procedure TForm1.WVBrowser1RetrieveHTMLCompleted(Sender: TObject;
  aResult: boolean; const aHTML: wvstring);
begin
  if aResult then
  begin
    HTMLText:=aHTML;
    if webseitegeladen = 1 then webseitegeladen:=2;
  end else begin
    HTMLErr:=1;
  end;
end;

procedure TForm1.WVBrowser2AfterCreated(Sender: TObject);
begin
  WVWindowParent2.UpdateSize;
  WVBrowser2.Navigate(UTF8Decode(URL));
end;

procedure TForm1.WVBrowser2InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(UTF8Encode(aErrorMessage));
  HTMLErr:=2;
end;

procedure TForm1.WVBrowser2NavigationCompleted(Sender: TObject;
  const aWebView: ICoreWebView2;
  const aArgs: ICoreWebView2NavigationCompletedEventArgs);
begin
  webseitegeladen:=1;
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
    if startmerk = 1 then
    begin
      zoomsi:=zoomfakt;
      Mapan;
      latvy:=vonLat;
      latby:=bisLat;
      longvx:=vonLon;
      longbx:=bisLon;
      glatv:=latvy;
      glatb:=latby;
      glongv:=longvx;
      glongb:=longbx;
      Geoum;
      loeim2:=1;
      Label6.Caption:='von Lat: '+FloatToStrF(latvy,ffFixed,6,3)+' Long: '+FloatToStrF(longvx,ffFixed,6,3);
      Label7.Caption:='bis Lat: '+FloatToStrF(latby,ffFixed,6,3)+' Long: '+FloatToStrF(longbx,ffFixed,6,3);
      Label6.Visible:=True;
      Label7.Visible:=True;
      Timer2.Enabled:=True;
      startmerk:=0;
    end;
  end else begin
    dcon:=2;
    JaNein:=messagedlg('keine Verbindung zur Datenbank flight', mtError, [mbOk], 0);
    close;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
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
  if htimerrun = 1 then Timer1.Enabled:=False;
  CloseAction:=caFree;
end;

procedure TForm1.FormActivate(Sender: TObject);
  var h1: integer;
  var h2: integer;
  var h3: string;
  var h4: AnsiChar;
  var h5: integer;
  var h6: integer;
  var h7: integer;
  var h8: integer;
  var h9: string;
  var ha: integer;
  var hb: string;
  var hc: string;
  var hd: string;
  var hf: integer;
  var hg: integer;
  var hh: integer;
  var fnum: textFile;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if sta = 1 then
  begin
    Form1.Caption:='                   F L I G H T R A D A R            Version '+vers+'                   <'+BUser+'>';
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
    mgebiet:=0;
    pfunkt:=0;
    textausgabe:=0;
    iart:=0;
    fliegeranz:=0;
    Timer1.Enabled:=False;
    Timer2.Enabled:=False;
    htimerrun:=0;
    Webanzeige:=0;
    webanz:=0;
    timeraus:=0;
    bildgeklickt:=0;
    Button3.Caption:='Anzeigen History an';
    Button3.Visible:=False;
    StringGrid1.Visible:=False;
    pmeterl:=0;
    loeim2:=1;
    Label8.Caption:='';
    Label9.Caption:='';
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
    StringGrid1.ColWidths[17]:=680;
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
    StringGrid1.Cells[17, 0]:='Abflughafen';
    StringGrid1.Cells[18, 0]:='Zielflughafen';
    StringGrid1.Cells[19, 0]:='Flugzeugtyp';
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
    ListBox1.Items.Clear;
    Image2.Visible:=False;
    SpeedButton1.Visible:=False;
    SpeedButton2.Visible:=False;
    SpeedButton3.Visible:=False;
    SpeedButton4.Visible:=False;
    MapView1.Visible:=False;
    PaintBox1.Visible:=False;
    WVWindowParent1.Visible:=False;
    WVWindowParent2.Visible:=False;
    zeit:=1500;
    loops:=100;
    orgzoom:=11;
    zoomfakt:=11;
    hlat:=49.509;
    hlong:=8.533;
    mgebiet:=0;
    pfunkt:=0;
    habb2:=0;
    flugzeugnr:=0;
    textflight:='';
    nummerflug:=0;
    mittimeron:=0;
    Image3.Canvas.Pen.Color:=clBlack;
    image3.Canvas.Pen.Style:=psSolid;
    image3.Canvas.Pen.Width:=1;
    Image3.Canvas.Brush.Color:=clBlack;
    Image3.Canvas.Brush.Style:=bsSolid;
    Image3.Canvas.FillRect(Rect(0,0,147,300));
    image3.Canvas.Font.Color:=clRed;
    image3.Canvas.Font.Size:=12;
    image3.Canvas.Font.Name:='Courier';
    image3.Canvas.Font.Style:=[fsBold];
    image3.Canvas.Brush.Color:=clWhite;
    image3.Canvas.Ellipse(10,10,25,25);
    image3.Canvas.FloodFill(15,15,clWhite,fsBorder);
    image3.Canvas.Brush.Color:=clLime;
    image3.Canvas.Ellipse(10,30,25,45);
    image3.Canvas.FloodFill(15,35,clLime,fsBorder);
    image3.Canvas.Brush.Color:=clAqua;
    image3.Canvas.Ellipse(10,50,25,65);
    image3.Canvas.FloodFill(15,55,clAqua,fsBorder);
    image3.Canvas.Brush.Color:=clYellow;
    image3.Canvas.Ellipse(10,70,25,85);
    image3.Canvas.FloodFill(15,75,clYellow,fsBorder);
    image3.Canvas.Brush.Color:=clRed;
    image3.Canvas.Ellipse(10,90,25,105);
    image3.Canvas.FloodFill(15,95,clRed,fsBorder);
    image3.Canvas.Brush.Color:=clFuchsia;
    image3.Canvas.Ellipse(10,110,25,125);
    image3.Canvas.FloodFill(15,115,clFuchsia,fsBorder);
    image3.Canvas.Brush.Color:=clGradientActiveCaption;
    image3.Canvas.Ellipse(10,130,25,145);
    image3.Canvas.FloodFill(15,135,clGradientActiveCaption,fsBorder);
    image3.Canvas.Brush.Color:=clBlue;
    image3.Canvas.Ellipse(10,150,25,165);
    image3.Canvas.FloodFill(15,155,clBlue,fsBorder);
    image3.Canvas.Brush.Color:=clMaroon;
    image3.Canvas.Ellipse(10,170,25,185);
    image3.Canvas.FloodFill(15,175,clMaroon,fsBorder);
    image3.Canvas.Brush.Color:=clOlive;
    image3.Canvas.Ellipse(10,190,25,205);
    image3.Canvas.FloodFill(15,195,clOlive,fsBorder);
    image3.Canvas.Brush.Color:=clMenuHighlight;
    image3.Canvas.Ellipse(10,210,25,225);
    image3.Canvas.FloodFill(15,215,clMenuHighlight,fsBorder);
    image3.Canvas.Brush.Color:=clGray;
    image3.Canvas.Ellipse(10,230,25,245);
    image3.Canvas.FloodFill(15,235,clGray,fsBorder);
    image3.Canvas.Brush.Color:=clGreen;
    image3.Canvas.Ellipse(10,250,25,265);
    image3.Canvas.FloodFill(15,255,clGreen,fsBorder);
    image3.Canvas.Brush.Color:=clPurple;
    image3.Canvas.Ellipse(10,270,25,285);
    image3.Canvas.FloodFill(15,275,clPurple,fsBorder);
    image3.Canvas.Brush.Color:=clBlack;
    image3.Canvas.TextOut(30,10,'über 13000m');
    image3.Canvas.TextOut(30,30,'über 12000m');
    image3.Canvas.TextOut(30,50,'über 11000m');
    image3.Canvas.TextOut(30,70,'über 10000m');
    image3.Canvas.TextOut(30,90,'über  9000m');
    image3.Canvas.TextOut(30,110,'über  8000m');
    image3.Canvas.TextOut(30,130,'über  7000m');
    image3.Canvas.TextOut(30,150,'über  6000m');
    image3.Canvas.TextOut(30,170,'über  5000m');
    image3.Canvas.TextOut(30,190,'über  4000m');
    image3.Canvas.TextOut(30,210,'über  3000m');
    image3.Canvas.TextOut(30,230,'über  2000m');
    image3.Canvas.TextOut(30,250,'ab    1000m');
    image3.Canvas.TextOut(30,270,'unter 1000m');
    if FileExists(ExtractFilePath(ParamStr(0))+'zeit.dat') then
    begin
      FileMode:=fmOpenRead;
      AssignFile(fnum, ExtractFilePath(ParamStr(0))+'zeit.dat');
      {$I-}
      Reset(fnum);
      {$I+}
      if IORESULT = 0 then
      begin
        h3:='';
        h5:=1;
        h7:=0;
        While not Eof(fnum) do
        begin
          readln(fnum,h3);
          if h5 = 1 then
          begin
            h7:=h7+1;
            if h7 = 1 then
            begin
              h6:=Length(h3);
              if h6 > 0 then
              begin
                ha:=0;
                hb:='';
                for h8:=1 to h6 do
                begin
                  if h5 = 1 then
                  begin
                    h9:=Copy(h3,h8,1);
                    if h9 = ' ' then
                    begin
                      ha:=ha+1;
                      if ha = 1 then
                      begin
                        if hb <> 'Wartezeit' then h5:=2;
                      end;
                      if ha = 2 then
                      begin
                        hf:=Length(hb);
                        if hf > 0 then
                        begin
                          zeit:=StrToInt(hb);
                        end else begin
                          h5:=2;
                        end;
                      end;
                      hb:='';
                    end else begin
                      hb:=hb+h9;
                    end;
                  end;
                end;
              end else begin
                h5:=2;
              end;
            end else begin
              if h7 = 2 then
              begin
                h6:=Length(h3);
                if h6 > 0 then
                begin
                  ha:=0;
                  hb:='';
                  for h8:=1 to h6 do
                  begin
                    if h5 = 1 then
                    begin
                      h9:=Copy(h3,h8,1);
                      if h9 = ' ' then
                      begin
                        ha:=ha+1;
                        if ha = 1 then
                        begin
                          if hb <> 'Internetzeit' then h5:=2;
                        end;
                        if ha = 2 then
                        begin
                          hf:=Length(hb);
                          if hf > 0 then
                          begin
                            loops:=StrToInt(hb);
                          end else begin
                            h5:=2;
                          end;
                        end;
                        hb:='';
                      end else begin
                        hb:=hb+h9;
                      end;
                    end;
                  end;
                end else begin
                  h5:=2;
                end;
              end else begin
                if h7 = 3 then
                begin
                  h6:=Length(h3);
                  if h6 > 0 then
                  begin
                    ha:=0;
                    hb:='';
                    for h8:=1 to h6 do
                    begin
                      if h5 = 1 then
                      begin
                        h9:=Copy(h3,h8,1);
                        if h9 = ' ' then
                        begin
                          ha:=ha+1;
                          if ha = 1 then
                          begin
                            if hb <> 'Zoomfaktor' then h5:=2;
                          end;
                          if ha = 2 then
                          begin
                            hf:=Length(hb);
                            if hf > 0 then
                            begin
                              orgzoom:=StrToInt(hb);
                            end else begin
                              h5:=2;
                            end;
                          end;
                          hb:='';
                        end else begin
                          hb:=hb+h9;
                        end;
                      end;
                    end;
                    ha:=ha+1;
                    if ha = 2 then
                    begin
                      hf:=Length(hb);
                      if hf > 0 then
                      begin
                        orgzoom:=StrToInt(hb);
                      end else begin
                        h5:=2;
                      end;
                    end;
                  end else begin
                    h5:=2;
                  end;
                end else begin
                  if h7 = 4 then
                  begin
                    h6:=Length(h3);
                    if h6 > 0 then
                    begin
                      ha:=0;
                      hb:='';
                      for h8:=1 to h6 do
                      begin
                        if h5 = 1 then
                        begin
                          h9:=Copy(h3,h8,1);
                          if h9 = ' ' then
                          begin
                            ha:=ha+1;
                            if ha = 1 then
                            begin
                              if hb <> 'Home' then h5:=2;
                            end;
                            if ha = 2 then
                            begin
                              if hb <> 'Lat' then h5:=2;
                            end;
                            if ha = 3 then
                            begin
                              hf:=Length(hb);
                              if hf > 0 then
                              begin
                                hlat:=StrToFloat(hb);
                              end else begin
                                h5:=2;
                              end;
                            end;
                            if ha = 4 then
                            begin
                              if hb <> 'Long' then h5:=2;
                            end;
                            if ha = 5 then
                            begin
                              hf:=Length(hb);
                              if hf > 0 then
                              begin
                                hlong:=StrToFloat(hb);
                              end else begin
                                h5:=2;
                              end;
                            end;
                            hb:='';
                          end else begin
                            hb:=hb+h9;
                          end;
                        end;
                      end;
                      ha:=ha+1;
                      if ha = 5 then
                      begin
                        hf:=Length(hb);
                        if hf > 0 then
                        begin
                          hlong:=StrToFloat(hb);
                        end else begin
                          h5:=2;
                        end;
                      end;
                    end else begin
                      h5:=2;
                    end;
                  end;
                end;
              end;
            end;
            h3:='';
          end;
        end;
        CloseFile(fnum);
        if h5 <> 2 then
        begin
          if h7 <> 4 then
          begin
            Label2.Caption:='Anzahl Sätze in Zeit-Datei stimmt nicht';
            Label2.Refresh;
            sleep(10000);
            abbruch:=True;
            close;
          end else begin
            if dcon = 0 then
            begin
              Homepunkt.Lat:=hlat;
              Homepunkt.Lon:=hlong;
              startmerk:=1;
              if zeit < 10 then zeit:=10;
              if zeit > 3500 then zeit:=3500;
              if loops < 10 then loops:=10;
              if loops > 250 then loops:=250;
              if orgzoom < 2 then orgzoom:=2;
              if orgzoom > 19 then orgzoom:=19;
              if orgzoom = 2 then SpeedButton1.Visible:=False;
              if orgzoom = 19 then SpeedButton2.Visible:=False;
              zoomfakt:=orgzoom;
              if mapnr = 0 then mapnr:=zoomfakt;
              mapnrsave:=mapnr;
              zoomsave:=zoomfakt;
              ZConnection1.Connect;
            end;
          end;
        end else begin
          Label2.Caption:='Aufbau der Zeit-Datei nicht korrekt';
          Label2.Refresh;
          sleep(10000);
          abbruch:=True;
          close;
        end;
      end else begin
        Label2.Caption:='konnte Zeit-Datei nicht öffnen';
        Label2.Refresh;
        sleep(10000);
        abbruch:=True;
        close;
      end;
    end else begin
      Label2.Caption:='Zeit-Datei fehlt';
      Label2.Refresh;
      sleep(10000);
      abbruch:=True;
      close;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if (Closestat = 0) then
  begin
    if (mtasts = 1) then
    begin
      mtasts:=1;
      mlauf:=0;
      close;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if mtasts = 0 then
  begin
    if (hgrid = 1) then
    begin
      Button3.Caption:='Anzeigen History an';
      Button3.Refresh;
      StringGrid1.Visible:=False;
      PaintBox1.Visible:=True;
      SpeedButton1.Visible:=True;
      SpeedButton2.Visible:=True;
      SpeedButton3.Visible:=true;
      SpeedButton4.Visible:=True;
      Image3.Visible:=True;
      hgrid:=0;
      ListBox1.Visible:=True;
      Label10.Visible:=True;
      Timer2.Enabled:=True;
      mtasts:=1;
      MapView1.Visible:=True;
      MapView1.Zoom:=zoomfakt;
      MapView1.Visible:=False;
    end;
  end else begin
    if mtasts = 1 then
    begin
      if (hgrid = 0) then
      begin
        mtasts:=0;
        Label2.Caption:='';
        Button3.Caption:='Anzeigen History aus';
        PaintBox1.Visible:=False;
        SpeedButton1.Visible:=False;
        SpeedButton2.Visible:=False;
        SpeedButton3.Visible:=False;
        SpeedButton4.Visible:=False;
        Image3.Visible:=False;
        StringGrid1.Visible:=True;
        hgrid:=1;
        ListBox1.Visible:=False;
        Label10.Visible:=False;
        Timer2.Enabled:=False;
        Laden;
      end;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
  var h1: integer;
  var h2: integer;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  h2:=0;
  if (mtasts = 0) then
  begin
    if Button1.Caption = 'Stop FlightRadar' then
    begin
      if webanz = 0 then
      begin
        habb2:=1;
        Button1.Caption:='Start FlightRadar';
        mtasts:=1;
        h2:=1;
      end;
    end;
  end;
  if ((mtasts = 1) and (h2 = 0)) then
  begin
    mtasts:=0;
    habb:=0;
    habb2:=0;
    htimerrun:=0;
    Webanzeige:=0;
    webanz:=0;
    Label2.Caption:='';
    Button1.Caption:='Stop FlightRadar';
    Button1.Refresh;
    Label6.Visible:=True;
    Label7.Visible:=True;
    Label9.Caption:='';
    Button3.Visible:=False;
    if flightanz4 > 0 then
    begin
      Button3.Visible:=True;
      Label6.Visible:=False;
      Label7.Visible:=False;
      Label9.Caption:=IntToStr(flightanz4);
    end;
    Label9.Refresh;
    Button3.Caption:='Anzeigen History an';
    Button3.Refresh;
    Label8.Caption:='';
    ListBox1.Items.Clear;
    StringGrid1.Visible:=False;
    StringGrid1.Refresh;
    ffehl:=0;
    imgloe:=0;
    if FileExists(ExtractFilePath(ParamStr(0))+'daten.fly') then
    begin
      DeleteFile(ExtractFilePath(ParamStr(0))+'daten.fly');
    end;
    h1:=ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-batch.bat'), nil, nil, SW_SHOWMINIMIZED);
    sleep(5000);
    if h1 = 42 then
    begin
      Timer1.Enabled:=True;
    end else begin
      Label2.Caption:='Fehler start dump1090';
      Button1.Caption:='Start FlightRadar';
      mtasts:=1;
    end;
  end;
end;

procedure TForm1.Edit99KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var h1: integer;
begin
  if Key = 27 then
  begin
    if webanz = 1 then
    begin
      webanz:=0;
      Edit99.Visible:=False;
      Webanzeige:=0;
      hgrid:=0;
      WVWindowParent2.Visible:=False;
      MapView1.Visible:=False;
      PaintBox1.Visible:=True;
      SpeedButton1.Visible:=True;
      SpeedButton2.Visible:=True;
      SpeedButton3.Visible:=True;
      SpeedButton4.Visible:=True;
      MapView1.Visible:=True;
      MapView1.Zoom:=zoomfakt;
      MapView1.Visible:=False;
      if mittimeron = 1 then
      begin
        Timer1.Enabled:=True;
      end;
      mittimeron:=0;
    end;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L I G H T R A D A R                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (abbruch) then
  begin
    textausgabe:=0;
    Paintab:=1;
    Timer1.Enabled:=False;
    Timer2.Enabled:=False;
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
        textausgabe:=0;
        Paintab:=1;
        Timer1.Enabled:=False;
        Timer2.Enabled:=False;
        CanClose:=true;
      end;
    end;
  end;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := UTF8Decode(ExtractFileDir(Application.ExeName) + '\CustomCache');
  GlobalWebView2Loader.StartWebView2;

end.

