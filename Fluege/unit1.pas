unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Grids,
  ZConnection, ZDataset, ZAbstractRODataset, Eingabe, Printers, ExtCtrls,
  LazHelpHTML, Buttons, SynEdit, SynHighlighterHTML, IpHtml, IpFileBroker,
  mvMapViewer, System.UITypes, DB, MVTYPES, LCLIntf, LCLType, Messages,
  BGRABitmap, BGRABitmapTypes, BGRATransform, fgl, ComCtrls, DateUtils,
  uWVBrowser, uWVWindowParent, uWVLoader, uWVBrowserBase, uWVTypes, uWVEvents;

type

  { TPlaneItem }

  TPlaneItem = class
    PlaneStream: TMemoryStream;
    Location: TPoint;
    Angle: Integer;
    Color: TColor;
    constructor Create;
    destructor Destroy; override;
  end;

  { TPlaneList }

  TPlaneList = class(specialize TFPGObjectList<TPlaneItem>)
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button1: TButton;
    Button6: TButton;
    Button3: TButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Edit99: TEdit;
    Image2: TImage;
    Label1: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label9: TLabel;
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
    WVWindowParent1: TWVWindowParent;
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
    procedure Button6Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Edit99KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MapView1Change(Sender: TObject);
    procedure MapView1MouseLeave(Sender: TObject);
    procedure MapView1ZoomChange(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
      var CanSelect: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure WVBrowser1AfterCreated(Sender: TObject);
    procedure WVBrowser1DocumentTitleChanged(Sender: TObject);
    procedure WVBrowser1InitializationError(Sender: TObject;
      aErrorCode: HRESULT; const aErrorMessage: wvstring);
    procedure ZConnection1AfterConnect(Sender: TObject);
  protected
    // It's necessary to handle these messages to call NotifyParentWindowPositionChanged or some page elements will be misaligned.
    procedure WMMove(var aMessage : TWMMove); message WM_MOVE;
    procedure WMMoving(var aMessage : TMessage); message WM_MOVING;
  private
    procedure Laden;
  public
    procedure Blankwegh;
    procedure Blankwegv;
    procedure Privflug;
    procedure Nummer;
    procedure Ausbreitung;
    procedure Geoum;
    procedure Hexum;
    procedure Verfolg;
    procedure zeichne;
    procedure PaintMassstab;
    procedure PaintHome;
    procedure Flugstrecke(Sender: TObject);
    procedure Mapan;
    procedure Mapaus;
    function PreparePlane(aColor: TColor; aAngle, aSize: Integer): TMemoryStream;
    function PrepareText: TMemoryStream;
    function XYKorrektur(zoomfaktor, richtung: integer): integer;
  end;

type tposi = record
  latvy: double;
  latby: double;
  longvx: double;
  longbx: double;
end;

type twflug = record
  flight: string;
  vonzeit: TDateTime;
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
  sort: string;
  egrid: integer;
  b3art: integer;
  b5art: integer;
  b6art: integer;
  webanz: integer;
  zeit: integer;
  posi: array [1..19] of tposi;
  hlat: double;
  hlong: double;
  mapnr: integer;
  vfhei: integer;
  bfhei: integer;
  latvy: Double;
  latby: Double;
  longvx: Double;
  longbx: Double;
  flugx1: integer;
  flugy1: integer;
  flugx2: integer;
  flugy2: integer;
  glatv: double;
  glongv: double;
  glatb: double;
  glongb: double;
  pmeterb: double;
  pmeterl: double;
  pmetere: integer;
  mim2lx: integer;
  mim2ly: integer;
  mim2rx: integer;
  mim2ry: integer;
  xlatv: double;
  xlongv: double;
  xlatb: double;
  xlongb: double;
  grdart: integer;
  wflug: array [1..99999] of twflug;
  wfluganz: integer;
  mvalt: integer;
  mvspeed: integer;
  mvhead: integer;
  mvlat: double;
  mvlong: double;
  mvhex: string;
  mvzeit: TDateTime;
  mvflight: string;
  mrot: integer;
  mrot2: integer;
  flugx: integer;
  flugy: integer;
  flugh: integer;
  flugr: integer;
  mpr: integer;
  mgebiet: integer;
  mgebietvx: integer;
  mgebietvy: integer;
  mgebietbx: integer;
  mgebietby: integer;
  m6art: integer;
  herrmsg: string;
  feldalt: string;
  feldneu: string;
  Homepunkt, Kartenpunkt: TRealPoint;
  zoomfakt: integer;
  vonLat: Double;
  bisLat: Double;
  vonLon: Double;
  bisLon: Double;
  URL: string;
  orgzoom: integer;
  interzeit: integer;
  planelist: TPlaneList;
  zoomsave: integer;
  pfunkt: integer;
  mapnrsave: integer;
  zeichenart: integer;
  p6plane: integer;
  fsh2: Double;
  fsh3: Double;
  fsh4: Double;
  fsh5: Double;
  textausgabe: integer;

implementation

{$R *.lfm}

{ TPlaneItem }

constructor TPlaneItem.Create;
begin
  inherited Create;
  PlaneStream := nil;
  Location := Point(0, 0);
  Angle := 0;
  Color := clBlack;
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
    if zoomfaktor = 2 then v7:=130;
    if zoomfaktor = 3 then v7:=90;
    if zoomfaktor = 4 then v7:=50;
    if zoomfaktor = 5 then v7:=35;
    if zoomfaktor = 6 then v7:=20;
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
  //rotate plane
  temp := TBGRABitmap.Create(w, w, BGRAPixelTransparent);
  bmptranform := TBGRAAffineBitmapTransform.Create(bmp);
  bmptranform.Translate(-bmp.Width div 2, -bmp.Height div 2);
  bmptranform.RotateDeg(aAngle);
  bmptranform.Translate(bmp.Width div 2, bmp.Height div 2);
  temp.Fill(bmptranform);
  bmptranform.Free;
  bmp.Assign(temp);
  temp.Free;
  //resize plane
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
  if bmp.Height > w then
    w := bmp.Height;
  //rotate text
  temp := TBGRABitmap.Create(w, w, BGRAPixelTransparent);
  bmptranform := TBGRAAffineBitmapTransform.Create(bmp);
  bmptranform.Translate(-bmp.Width div 2, -bmp.Height div 2);
  bmptranform.RotateDeg(0);
  bmptranform.Translate(bmp.Width div 2, bmp.Height div 2);
  temp.Fill(bmptranform);
  bmptranform.Free;
  bmp.Assign(temp);
  temp.Free;
  //resize text
  if (bmp.Width > 350) or (bmp.Height > 100) then
  begin
    w := 350;
    h := 100;
    if bmp.Width >= bmp.Height then
      h := trunc(bmp.Height * (w / bmp.Width))
    else
      w := trunc(bmp.Width * (h / bmp.Height));
    BGRAReplace(bmp, bmp.Resample(w, h, rmFineResample));
  end;
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
      pmeterb:=m3/652;
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
      pmeterl:=m3/1510;
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

procedure TForm1.Flugstrecke(Sender: TObject);
  var hd: TMouseButton;
  var he: TShiftState;
begin
  if flugx1 >= 0 then
  begin
    if flugy1 >= 0 then
    begin
      if flugx1 <= 1595 then
      begin
        if flugy1 <= 566 then
        begin
          if flugx2 >= 0 then
          begin
            if flugy2 >= 0 then
            begin
              if flugx2 <= 1595 then
              begin
                if flugy2 <= 566 then
                begin
                  PaintBox1.Canvas.Pen.Color:=clLime;
                  PaintBox1.Canvas.Brush.Color:=clLime;
                  PaintBox1.Canvas.Ellipse(flugx1-10,flugy1-10,flugx1+10,flugy1+10);
                  PaintBox1.Canvas.FloodFill(flugx1,flugy1,clLime,fsBorder);
                  PaintBox1.Canvas.Pen.Color:=clRed;
                  PaintBox1.Canvas.Brush.Color:=clRed;
                  PaintBox1.Canvas.Ellipse(flugx2-10,flugy2-10,flugx2+10,flugy2+10);
                  PaintBox1.Canvas.FloodFill(flugx2,flugy2,clRed,fsBorder);
                  PaintBox1.Canvas.Pen.Color:=clNavy;
                  PaintBox1.Canvas.Brush.Color:=clNavy;
                  PaintBox1.Canvas.MoveTo(flugx1,flugy1);
                  PaintBox1.Canvas.LineTo(flugx2,flugy2);
                  xlatv:=fsh2;
                  xlongv:=fsh5;
                  xlatb:=fsh4;
                  xlongb:=fsh3;
                  PaintBox1.OnMouseDown(Sender,hd,he,0,0);
                end;
              end;
            end;
          end;
        end;
      end;
    end;
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
        v9:=1595/v8/1000;
        va:=Homepunkt.Lon-vonLon;
        vx:=Round(va*1000*v9)-XYKorrektur(zoomfakt, 1);
        v8:=bisLat-vonLat;
        v9:=566/v8/1000;
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

procedure TForm1.Verfolg;
  var h1: TDateTime;
  var h2: TDateTime;
  var h3: integer;
  var h4: integer;
  var h5: integer;
  var h6: Double;
  var h7: Double;
  var h8: Double;
  var h9: Double;
  var ha: Double;
begin
  if mvlat > 0 then
  begin
    if mvlong > 0 then
    begin
      if ((mvlat >= latvy) and (mvlat <= latby)) then
      begin
        if ((mvlong >= longvx) and (mvlong <= longbx)) then
        begin
          h8:=longbx-longvx;
          h9:=1595/h8/1000;
          ha:=mvlong-longvx;
          flugx:=Round(ha*1000*h9);
          h8:=latby-latvy;
          h9:=566/h8/1000;
          ha:=latby-mvlat;
          flugy:=Round(ha*1000*h9);
          flugh:=mvalt;
          flugr:=mvhead;
          flugx:=flugx-XYKorrektur(zoomfakt,1);
          flugy:=flugy+XYKorrektur(zoomfakt,2);
          if flugx >= 0 then
          begin
            if flugy >= 0 then
            begin
              if flugx <= 1595 then
              begin
                if flugy <= 566 then
                begin
                  zeichenart:=1;
                  zeichne;
                end;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  sleep(200);
  h1:=IncHour(mvzeit,-1);
  h2:=IncHour(mvzeit,1);
  Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung WHERE hexid=:hex AND zeit>=:vei AND zeit<=:bei AND flight=:fly';
  Form1.ZQuery1.ParamByName('hex').asString:=mvhex;
  Form1.ZQuery1.ParamByName('vei').asDateTime:=h1;
  Form1.ZQuery1.ParamByName('bei').asDateTime:=h2;
  Form1.ZQuery1.ParamByName('fly').asString:=mvflight;
  Form1.ZQuery1.Open;
  while not Form1.ZQuery1.EOF do
  begin
    if b6art = 2 then
    begin
      h3:=Form1.ZQuery1.Fields[3].AsInteger;
      h4:=Form1.ZQuery1.Fields[4].AsInteger;
      h5:=Form1.ZQuery1.Fields[5].AsInteger;
      h6:=Form1.ZQuery1.Fields[6].AsFloat;
      h7:=Form1.ZQuery1.Fields[7].AsFloat;
      if h6 > 0 then
      begin
        if h7 > 0 then
        begin
          if ((h6 >= latvy) and (h6 <= latby)) then
          begin
            if ((h7 >= longvx) and (h7 <= longbx)) then
            begin
              h8:=longbx-longvx;
              h9:=1595/h8/1000;
              ha:=h7-longvx;
              flugx:=Round(ha*1000*h9);
              h8:=latby-latvy;
              h9:=566/h8/1000;
              ha:=latby-h6;
              flugy:=Round(ha*1000*h9);
              flugh:=h3;
              flugr:=h5;
              flugx:=flugx-XYKorrektur(zoomfakt,1);
              flugy:=flugy+XYKorrektur(zoomfakt,2);
              if flugx >= 0 then
              begin
                if flugy >= 0 then
                begin
                  if flugx <= 1595 then
                  begin
                    if flugy <= 566 then
                    begin
                      zeichenart:=2;
                      zeichne;
                      Application.ProcessMessages;
                    end;
                  end;
                end;
              end;
            end;
          end;
        end;
      end;
      sleep(200);
    end;
    Form1.ZQuery1.Next;
  end;
  Form1.ZQuery1.Close;
end;

procedure TForm1.Ausbreitung;
  var h1: integer;
  var h2: Double;
  var h3: Double;
  var h4: Double;
  var h5: Double;
  var h6: integer;
  var h8: double;
  var h9: Double;
  var ha: Double;
  var hb: Double;
begin
  latvy:=posi[mapnr].latvy;
  latby:=posi[mapnr].latby;
  longvx:=posi[mapnr].longvx;
  longbx:=posi[mapnr].longbx;
  glatv:=latvy;
  glatb:=latby;
  glongv:=longvx;
  glongb:=longbx;
  Geoum;
  Form1.ZQuery1.SQL.Text:='SELECT * FROM flight';
  Form1.ZQuery1.Open;
  while not Form1.ZQuery1.EOF do
  begin
    h1:=Form1.ZQuery1.Fields[4].AsInteger;
    h6:=Form1.ZQuery1.Fields[5].AsInteger;
    h2:=Form1.ZQuery1.Fields[10].AsFloat;
    h3:=Form1.ZQuery1.Fields[11].AsFloat;
    h4:=Form1.ZQuery1.Fields[12].AsFloat;
    h5:=Form1.ZQuery1.Fields[13].AsFloat;
    h8:=longbx-longvx;
    h9:=1595/h8/1000;
    ha:=h3-longvx;
    flugx1:=Round(ha*1000*h9);
    h8:=latby-latvy;
    h9:=566/h8/1000;
    ha:=latby-h2;
    flugy1:=Round(ha*1000*h9);
    h8:=longbx-longvx;
    h9:=1595/h8/1000;
    ha:=h5-longvx;
    flugx2:=Round(ha*1000*h9);
    h8:=latby-latvy;
    h9:=566/h8/1000;
    ha:=latby-h4;
    flugy2:=Round(ha*1000*h9);
    flugx1:=flugx1-XYKorrektur(zoomfakt,1);
    flugx2:=flugx2-XYKorrektur(zoomfakt,1);
    flugy1:=flugy1+XYKorrektur(zoomfakt,2);
    flugy2:=flugy2+XYKorrektur(zoomfakt,2);
    if flugx1 >= 0 then
    begin
      if flugy1 >= 0 then
      begin
        if flugx1 <= 1595 then
        begin
          if flugy1 <= 566 then
          begin
            if flugx2 >= 0 then
            begin
              if flugy2 >= 0 then
              begin
                if flugx2 <= 1595 then
                begin
                  if flugy2 <= 566 then
                  begin
                    if mgebiet = 3 then
                    begin
                      if ((flugx1 >= mgebietvx) and (flugx1 <= mgebietbx)) then
                      begin
                        if ((flugy1 >= mgebietvy) and (flugy1 <= mgebietby)) then
                        begin
                          if ((flugx2 >= mgebietvx) and (flugx2 <= mgebietbx)) then
                          begin
                            if ((flugy2 >= mgebietvy) and (flugy2 <= mgebietby)) then
                            begin
                              PaintBox1.Canvas.Pen.Color:=clRed;
                              PaintBox1.Canvas.Brush.Color:=clRed;
                              hb:=h1*0.3;
                              if ((hb >= vfhei) and (hb <= bfhei)) then
                              begin
                                PaintBox1.Canvas.Ellipse(flugx1-5,flugy1-5,flugx1+5,flugy1+5);
                                PaintBox1.Canvas.FloodFill(flugx1,flugy1,clRed,fsBorder);
                              end;
                              hb:=h6*0.3;
                              if ((hb >= vfhei) and (hb <= bfhei)) then
                              begin
                                PaintBox1.Canvas.Ellipse(flugx2-5,flugy2-5,flugx2+5,flugy2+5);
                                PaintBox1.Canvas.FloodFill(flugx2,flugy2,clRed,fsBorder);
                              end;
                            end;
                          end;
                        end;
                      end;
                    end else begin
                      PaintBox1.Canvas.Pen.Color:=clRed;
                      PaintBox1.Canvas.Brush.Color:=clRed;
                      hb:=h1*0.3;
                      if ((hb >= vfhei) and (hb <= bfhei)) then
                      begin
                        PaintBox1.Canvas.Ellipse(flugx1-5,flugy1-5,flugx1+5,flugy1+5);
                        PaintBox1.Canvas.FloodFill(flugx1,flugy1,clRed,fsBorder);
                      end;
                      hb:=h6*0.3;
                      if ((hb >= vfhei) and (hb <= bfhei)) then
                      begin
                        PaintBox1.Canvas.Ellipse(flugx2-5,flugy2-5,flugx2+5,flugy2+5);
                        PaintBox1.Canvas.FloodFill(flugx2,flugy2,clRed,fsBorder);
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
    Form1.ZQuery1.Next;
  end;
  Form1.ZQuery1.Close;
  if mgebiet = 0 then
  begin
    h8:=longbx-longvx;
    h9:=1595/h8/1000;
    ha:=hlong-longvx;
    flugx1:=Round(ha*1000*h9);
    h8:=latby-latvy;
    h9:=566/h8/1000;
    ha:=latby-hlat;
    flugy1:=Round(ha*1000*h9);
    flugx1:=flugx1-XYKorrektur(zoomfakt,1);
    flugy1:=flugy1+XYKorrektur(zoomfakt,2);
    if flugx1 >= 0 then
    begin
      if flugy1 >= 0 then
      begin
        if flugx1 <= 1595 then
        begin
          if flugy1 <= 566 then
          begin
            PaintBox1.Canvas.Pen.Color:=clLime;
            PaintBox1.Canvas.Brush.Color:=clLime;
            PaintBox1.Canvas.Ellipse(flugx1-5,flugy1-5,flugx1+5,flugy1+5);
            PaintBox1.Canvas.FloodFill(flugx1,flugy1,clLime,fsBorder);
          end;
        end;
      end;
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
  var hr: integer;
  var hs: integer;
  var ht: Double;
  var vh: Double;
  var bh: Double;
  var dh: Double;
  var hu: integer;
  var hv: integer;
  var hw: integer;
  var hx: string;
  var hy: string;
  var hz: string;
  var hfl: integer;
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
  var fzt: string;
begin
  Screen.Cursor:=crHourGlass;
  Form1.Cursor:=crHourGlass;
  Form1.Refresh;
  grdart:=1;
  StringGrid1.RowCount:=2;
  StringGrid1.ColCount:=21;
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
  StringGrid1.ColWidths[20]:=680;
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
  StringGrid1.Cells[20, 0]:='Flugzeugtyp';
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
  StringGrid1.Cells[20, 1]:='';
  if sort = 'wiederkehrende Flüge' then
  begin
    grdart:=2;
    StringGrid1.RowCount:=2;
    StringGrid1.ColCount:=21;
    StringGrid1.ColWidths[0]:=810;
    StringGrid1.ColWidths[1]:=140;
    StringGrid1.ColWidths[2]:=260;
    StringGrid1.ColWidths[3]:=260;
    StringGrid1.ColWidths[4]:=120;
    StringGrid1.ColWidths[5]:=180;
    StringGrid1.ColWidths[6]:=150;
    StringGrid1.ColWidths[7]:=150;
    StringGrid1.ColWidths[8]:=220;
    StringGrid1.ColWidths[9]:=220;
    StringGrid1.ColWidths[10]:=180;
    StringGrid1.ColWidths[11]:=180;
    StringGrid1.ColWidths[12]:=150;
    StringGrid1.ColWidths[13]:=150;
    StringGrid1.ColWidths[14]:=150;
    StringGrid1.ColWidths[15]:=150;
    StringGrid1.ColWidths[16]:=550;
    StringGrid1.ColWidths[17]:=180;
    StringGrid1.ColWidths[18]:=680;
    StringGrid1.ColWidths[19]:=680;
    StringGrid1.ColWidths[20]:=680;
    StringGrid1.Cells[0, 0]:='Fluggesellschaft';
    StringGrid1.Cells[1, 0]:='Flight';
    StringGrid1.Cells[2, 0]:='von Zeit';
    StringGrid1.Cells[3, 0]:='bis Zeit';
    StringGrid1.Cells[4, 0]:='ICAO-ID';
    StringGrid1.Cells[5, 0]:='Anzahl Daten';
    StringGrid1.Cells[6, 0]:='von Alt [m]';
    StringGrid1.Cells[7, 0]:='bis Alt [m]';
    StringGrid1.Cells[8, 0]:='von Speed [Km/h]';
    StringGrid1.Cells[9, 0]:='bis Speed [Km/h]';
    StringGrid1.Cells[10, 0]:='von Heading [°]';
    StringGrid1.Cells[11, 0]:='bis Heading [°]';
    StringGrid1.Cells[12, 0]:='von Lat [°]';
    StringGrid1.Cells[13, 0]:='von Long [°]';
    StringGrid1.Cells[14, 0]:='bis Lat [°]';
    StringGrid1.Cells[15, 0]:='bis Long [°]';
    StringGrid1.Cells[16, 0]:='Land';
    StringGrid1.Cells[17, 0]:='Flugverfolgung';
    StringGrid1.Cells[18, 0]:='Abflughafen';
    StringGrid1.Cells[19, 0]:='Zielflughafen';
    StringGrid1.Cells[20, 0]:='Flugzeug';
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
    StringGrid1.Cells[20, 1]:='';
  end;
  Z:=1;
  hm:=0;
  vh:=0;
  bh:=99999;
  hr:=0;
  if sort = 'Flüge mit Änderung Höhe 1 - 10 m' then
  begin
    hr:=1;
    bh:=10;
    vh:=0;
  end;
  if sort = 'Flüge mit Änderung Höhe 11 - 50 m' then
  begin
    hr:=1;
    bh:=50;
    vh:=10;
  end;
  if sort = 'Flüge mit Änderung Höhe 51 - 100 m' then
  begin
    hr:=1;
    bh:=100;
    vh:=50;
  end;
  if sort = 'Flüge mit Änderung Höhe 101 - 1000 m' then
  begin
    hr:=1;
    bh:=1000;
    vh:=100;
  end;
  if sort = 'Flüge mit Änderung Höhe über 1000 m' then
  begin
    hr:=1;
    bh:=99999;
    vh:=1000;
  end;
  Form1.ZQuery1.SQL.Text:='SELECT * FROM flight';
  if sort = 'Flüge mit Anfangsposition = Endposition' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE vlat = blat AND vlong = blong ORDER BY flight';
  if sort = 'Flüge mit Änderung Höhe 1 - 10 m' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE valt <> balt ORDER BY valt';
  if sort = 'Flüge mit Änderung Höhe 11 - 50 m' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE valt <> balt ORDER BY valt';
  if sort = 'Flüge mit Änderung Höhe 51 - 100 m' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE valt <> balt ORDER BY valt';
  if sort = 'Flüge mit Änderung Höhe 101 - 1000 m' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE valt <> balt ORDER BY valt';
  if sort = 'Flüge mit Änderung Höhe über 1000 m' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE valt <> balt ORDER BY valt';
  if sort = 'Flüge mit Änderung Geschwindigkeit' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE vspeed <> bspeed ORDER BY vspeed';
  if sort = 'Flüge mit Änderung Flugrichtung' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE vheading <> bheading ORDER BY vheading';
  if sort = 'Hex-ID' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY hexid';
  if sort = 'Datum und Zeit' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vonzeit';
  if sort = 'Flight' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY flight';
  if sort = 'Alt' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY valt';
  if sort = 'Speed' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vspeed';
  if sort = 'Heading' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vheading';
  if sort = 'Lat' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vlat';
  if sort = 'Long' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY vlong';
  if sort = 'Anzahl Daten' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY anz';
  if sort = 'Flüge mit Flugverfolgung' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY verfolgung';
  if sort = 'Abflughafen' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY von';
  if sort = 'Zielflughafen' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY nach';
  if sort = 'Flugzeugtyp' then Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY ftyp';
  if ((sort <> 'Fluggesellschaft') and (sort <> 'Land')) then
  begin
    if sort = 'wiederkehrende Flüge' then
    begin
      sflug:='';
      sfa:=0;
      wfluganz:=0;
      Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY flight, vonzeit';
      Form1.ZQuery1.Open;
      while not Form1.ZQuery1.EOF do
      begin
        h2:=Form1.ZQuery1.Fields[1].AsDateTime;
        h4:=Form1.ZQuery1.Fields[3].AsString;
        if h4 <> '' then
        begin
          if sflug = h4 then
          begin
            if wfluganz < 99999 then
            begin
              wfluganz:=wfluganz+1;
              wflug[wfluganz].flight:=h4;
              wflug[wfluganz].vonzeit:=h2;
            end;
          end else begin
            sflug:=h4;
            if wfluganz < 99999 then
            begin
              wfluganz:=wfluganz+1;
              wflug[wfluganz].flight:=h4;
              wflug[wfluganz].vonzeit:=h2;
            end;
          end;
        end;
        Form1.ZQuery1.Next;
      end;
      Form1.ZQuery1.Close;
      if wfluganz > 0 then
      begin
        sflug:='';
        sfluggs:='';
        for sfa:=1 to wfluganz do
        begin
          mflug:=1;
          vflug:=wflug[sfa].flight;
          if sflug <> vflug then
          begin
            if sfa < wfluganz then
            begin
              xflug:=wflug[sfa+1].flight;
              if vflug <> xflug then mflug:=0;
            end else begin
              mflug:=0;
            end;
          end;
          if mflug = 1 then
          begin
            Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE flight=:fly AND vonzeit=:zei';
            Form1.ZQuery1.ParamByName('fly').asString:=wflug[sfa].flight;
            Form1.ZQuery1.ParamByName('zei').asDateTime:=wflug[sfa].vonzeit;
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
              hm:=hm+1;
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
              StringGrid1.Cells[0, z]:='';
              StringGrid1.Cells[1, z]:='';
              if sfluggs <> he then
              begin
                StringGrid1.Cells[0, z]:=he;
                sfluggs:=he;
              end;
              if sflug <> h4 then
              begin
                StringGrid1.Cells[1, z]:=h4;
                sflug:=h4;
              end;
              StringGrid1.Cells[2, z]:=DateTimeToStr(h2);
              StringGrid1.Cells[3, z]:=DateTimeToStr(h3);
              StringGrid1.Cells[4, z]:=h1;
              StringGrid1.Cells[5, z]:=IntToStr(hd);
              hj:=h5*0.3;
              StringGrid1.Cells[6, z]:=IntToStr(Round(hj));
              hj:=hk*0.3;
              StringGrid1.Cells[7, z]:=IntToStr(Round(hj));
              hj:=h6*1.852;
              StringGrid1.Cells[8, z]:=FloatToStrF(hj,ffFixed,7,2);
              hj:=hl*1.852;
              StringGrid1.Cells[9, z]:=FloatToStrF(hj,ffFixed,7,2);
              StringGrid1.Cells[10, z]:=IntToStr(h7);
              StringGrid1.Cells[11, z]:=IntToStr(h8);
              StringGrid1.Cells[12, z]:=FloatToStrF(h9,ffFixed,6,3);
              StringGrid1.Cells[13, z]:=FloatToStrF(ha,ffFixed,6,3);
              StringGrid1.Cells[14, z]:=FloatToStrF(hb,ffFixed,6,3);
              StringGrid1.Cells[15, z]:=FloatToStrF(hc,ffFixed,6,3);
              StringGrid1.Cells[16, z]:=hf;
              ha2:='Nein';
              if ha1 = 'J' then ha2:='Ja';
              StringGrid1.Cells[17, z]:=ha2;
              z:=z + 1;
              Form1.ZQuery1.Next;
            end;
            Form1.ZQuery1.Close;
          end;
        end;
      end;
    end else begin
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
        fzt:=Form1.ZQuery1.Fields[18].AsString;
        hs:=1;
        if hr = 1 then
        begin
          hs:=0;
          hj:=h5*0.3;
          ht:=hk*0.3;
          dh:=ht-hj;
          if hj > ht then dh:=hj-ht;
          if ((dh > vh) and (dh <= bh)) then hs:=1;
        end;
        if hs = 1 then
        begin
          hm:=hm+1;
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
          StringGrid1.Cells[20, z]:=fzt;
          ha2:='Nein';
          if ha1 = 'J' then ha2:='Ja';
          StringGrid1.Cells[17, z]:=ha2;
          z:=z + 1;
        end;
        Form1.ZQuery1.Next;
      end;
      Form1.ZQuery1.Close;
    end;
    Label8.Caption:=IntToStr(hm);
  end else begin
    Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub ORDER BY name';
    if sort = 'Land' then Form1.ZQuery2.SQL.Text:='SELECT * FROM flightclub ORDER BY land';
    Form1.ZQuery2.Open;
    while not Form1.ZQuery2.EOF do
    begin
      hn:=1;
      he:=Form1.ZQuery2.Fields[0].AsString;
      hp:=Form1.ZQuery2.Fields[2].AsString;
      hf:=Form1.ZQuery2.Fields[4].AsString;
      if ((hp <> '001') and (hp <> '002')) then
      begin
        Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE LEFT(flight, 3) LIKE :fly ORDER BY flight';
        Form1.ZQuery1.ParamByName('fly').asString:=hp;
      end;
      if hp = '001' then
      begin
        Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY flight';
      end;
      if hp = '002' then
      begin
        Form1.ZQuery1.SQL.Text:='SELECT * FROM flight ORDER BY flight';
      end;
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
        hfl:=1;
        if hfl = 1 then
        begin
          if hp = '001' then
          begin
            hfl:=0;
            hi:=0;
            Form1.ZQuery3.SQL.Text:='SELECT * FROM flightclub WHERE icao=:fly';
            Form1.ZQuery3.ParamByName('fly').asString:=Copy(h4,1,3);
            Form1.ZQuery3.Open;
            while not Form1.ZQuery3.EOF do
            begin
              hi:=1;
              Form1.ZQuery3.Next;
            end;
            Form1.ZQuery3.Close;
            if hi = 0 then
            begin
              hh:=Copy(h4,1,3);
              ialpha:=h4;
              Privflug;
              if inummer = 1 then hfl:=1;
            end;
          end;
          if hp = '002' then
          begin
            hfl:=0;
            hi:=0;
            Form1.ZQuery3.SQL.Text:='SELECT * FROM flightclub WHERE icao=:fly';
            Form1.ZQuery3.ParamByName('fly').asString:=Copy(h4,1,3);
            Form1.ZQuery3.Open;
            while not Form1.ZQuery3.EOF do
            begin
              hi:=1;
              Form1.ZQuery3.Next;
            end;
            Form1.ZQuery3.Close;
            if hi = 0 then
            begin
              ialpha:=Copy(h4,1,1);
              inummer:=1;
              Nummer;
              hi:=Length(ialpha);
              if hi > 0 then
              begin
                hfl:=1;
              end else begin
                ialpha:=Copy(h4,2,1);
                inummer:=1;
                Nummer;
                hi:=Length(ialpha);
                if hi > 0 then
                begin
                  hfl:=1;
                end;
              end;
            end;
          end;
        end;
        if hfl = 1 then
        begin
          z:=z + 1;
          StringGrid1.RowCount:=z;
          z:=z - 1;
          hm:=hm+1;
          hg:=h4;
          hi:=Length(hg);
          hh:='';
          hn:=0;
          ialpha:=h1;
          Hexum;
          hu:=inummer;
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
          ha2:='Nein';
          if ha1 = 'J' then ha2:='Ja';
          StringGrid1.Cells[17, z]:=ha2;
          StringGrid1.Cells[18, z]:='';
          StringGrid1.Cells[19, z]:='';
          z:=z + 1;
        end;
        Form1.ZQuery1.Next;
      end;
      Form1.ZQuery1.Close;
      Form1.ZQuery2.Next;
    end;
    Form1.ZQuery2.Close;
    Label8.Caption:=IntToStr(hm);
  end;
  Screen.Cursor:=crDefault;
  Form1.Cursor:=crDefault;
  Form1.Refresh;
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
    StringGrid1.Cells[20, 1]:='';
  end;
  egrid:=0;
end;

procedure TForm1.zeichne;
  var h5: double;
  var h6: TColor;
  var h9: integer;
  var c: TColor;
  var x: integer;
  var y: integer;
  var pi: TPlaneItem;
begin
  h5:=flugh*0.3;
  h6:=clWhite;
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
  h9:=flugr;
  if h9 > 0 then
  begin
    flugr:=360-h9;
  end;
  if flugr = 360 then flugr:=0;
  flugx2:=flugx;
  flugy2:=flugy;
// Flugzeug zeichnen
  if zeichenart = 1 then
  begin
// neues Flugzeug
    pi:=TPlaneItem.Create;
    pi.PlaneStream:=PreparePlane(h6, flugr, 50);
    pi.Location.X:=flugx2;
    pi.Location.Y:=flugy2;
    pi.Angle:=flugr;
    pi.Color:=h6;
    planelist.Add(pi);
  end else begin
// Weiterflug
    PlaneList.Items[0].PlaneStream:=PreparePlane(h6, flugr, 50);
    PlaneList.Items[0].Angle:=flugr;
    PlaneList.Items[0].Location.X:=flugx2;
    PlaneList.Items[0].Location.Y:=flugy2;
    PlaneList.Items[0].Color:=h6;
  end;
  PaintBox1.Invalidate;
  PaintBox1.Repaint;
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
      pmeterb:=h3/652;
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
      pmeterl:=h3/1600;
    end;
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

procedure TForm1.FormCreate(Sender: TObject);
  var heute: string;
  var h1: integer;
  var h3: string;
  var Rec: LongRec;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
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
  Rec:=LongRec(GetFileVersion(ParamStr(0)));
  vers:=Format('%.*d.%.*d', [2, Rec.Hi,2, Rec.Lo]);
  ZConnection1.Disconnect;
  ZQuery1.Active:=False;
  planelist:=TPlaneList.Create;
  Form1.Caption:='                   F L Ü G E            Version '+vers+'                   <'+BUser+'>';
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if FileExists(ExtractFilePath(ParamStr(0))+'ProcMap.jpg') then
  begin
    DeleteFile(ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  end;
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
  planelist.Free;
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
// Latitude  Breitengrad horizontal oben kleiner als unten
// Longitude Längengrad vertikal links kleiner als rechts
  if FileExists(ExtractFilePath(ParamStr(0))+'ProcMap.jpg') then
  begin
    DeleteFile(ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  end;
  MapView1.SaveToFile(TJpegImage, ExtractFilePath(ParamStr(0))+'ProcMap.jpg');
  PaintBox1.Repaint;
  Kartenpunkt:=MapView1.Center;
end;

procedure TForm1.MapView1MouseLeave(Sender: TObject);
begin
  if mgebiet = 3 then
  begin
    Mapaus;
    b6art:=m6art;
    mgebiet:=0;
    mlauf:=0;
    mtasts:=1;
  end;
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
// Latitude  Breitengrad horizontal oben kleiner als unten
// Longitude Längengrad vertikal links kleiner als rechts
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
  var h1: double;
  var h2: double;
  var h3: double;
  var h4: double;
  var h5: integer;
  var h6: double;
  var h7: double;
  var h8: double;
  var h9: double;
  var ha: double;
  var hb: double;
  var hc: double;
  var hd: double;
  var he: integer;
  var hf: integer;
  var hg: double;
  var vbx: integer;
  var bbx: integer;
  var vby: integer;
  var bby: integer;
  var pi: TPlaneItem;
  var lh1: double;
  var lh2: double;
  var lh3: double;
  var lh4: double;
  var lh5: integer;
  var lhd: double;
  var lhe: integer;
  var lhf: integer;
  var lhh: string;
  var lhi: integer;
  var lhj: integer;
  var lhk: integer;
  var lhl: TDateTime;
begin
  if pfunkt = 2 then
  begin
    if textausgabe = 0 then
    begin
      image2.Canvas.Pen.Color:=clBlack;
      image2.Canvas.Pen.Style:=psSolid;
      image2.Canvas.Pen.Width:=1;
      image2.Canvas.Brush.Color:=clBlack;
      image2.Canvas.Brush.Style:=bsSolid;
      image2.Canvas.Font.Color:=clWhite;
      image2.Canvas.Font.Size:=12;
      image2.Canvas.Font.Name:='Courier';
      image2.Canvas.Font.Style:=[fsBold];
      image2.Canvas.Brush.Style:=bsClear;
      lh5:=1;
      Form1.ZQuery3.SQL.Text:='SELECT * FROM flight WHERE flight=:flight';
      Form1.ZQuery3.ParamByName('flight').asString:=Label10.Caption;
      Form1.ZQuery3.Open;
      while not Form1.ZQuery3.EOF do
      begin
        if lh5 = 1 then
        begin
          lhl:=Form1.ZQuery3.Fields[1].AsDateTime;
          lhh:=Form1.ZQuery3.Fields[3].AsString;
          lhi:=Form1.ZQuery3.Fields[4].AsInteger;
          lhj:=Form1.ZQuery3.Fields[6].AsInteger;
          lhk:=Form1.ZQuery3.Fields[8].AsInteger;
          lh1:=Form1.ZQuery3.Fields[10].AsFloat;
          lh2:=Form1.ZQuery3.Fields[11].AsFloat;
          lh3:=Form1.ZQuery3.Fields[12].AsFloat;
          lh4:=Form1.ZQuery3.Fields[13].AsFloat;
          if lh1 > 0 then
          begin
            if lh2 > 0 then
            begin
              if ((lh1 >= latvy) and (lh1 <= latby)) then
              begin
                if ((lh2 >= longvx) and (lh2 <= longbx)) then
                begin
                  lhe:=5;
                  lhf:=5;
                  image2.Canvas.TextOut(lhe,lhf,' Flight: '+lhh);
                  lhf:=lhf+16;
                  lhd:=lhi*0.3;
                  image2.Canvas.TextOut(lhe,lhf,' ALT: '+IntToStr(Round(lhd))+' m');
                  lhf:=lhf+16;
                  lhd:=lhj*1.852;
                  image2.Canvas.TextOut(lhe,lhf,' Speed: '+FloatToStrF(lhd,ffFixed,7,2)+' Km/h');
                  lhf:=lhf+16;
                  image2.Canvas.TextOut(lhe,lhf,' Heading: '+IntToStr(lhk)+' °');
                  lhf:=lhf+16;
                  image2.Canvas.TextOut(lhe,lhf,' Datum/Zeit: '+DateTimeToStr(lhl));
                  lh5:=0;
                end;
              end;
            end;
          end;
        end;
        Form1.ZQuery3.Next;
      end;
      Form1.ZQuery3.Close;
      if lh5 = 0 then
      begin
        textausgabe:=1;
        image2.Picture.Bitmap.SaveToFile(ExtractFilePath(ParamStr(0))+'Flightdat.bmp');
        pi:=TPlaneItem.Create;
        pi.PlaneStream:=PrepareText;
        pi.Location.X:=10;
        pi.Location.Y:=460;
        pi.Angle:=0;
        pi.Color:=clWhite;
        planelist.Add(pi);
      end;
    end else begin
      if textausgabe = 1 then
      begin
        if textausgabe = 1 then planelist.Delete(1);
        textausgabe:=0;
      end;
    end;
  end;
  if b6art = 1 then
  begin
    if ((b5art = 2) or (b3art = 2)) then
    begin
      h5:=0;
      if b3art = 1 then
      begin
        if Button = mbLeft then
        begin
          xlatv:=0;
          xlongv:=0;
        end;
        if Button = mbRight then
        begin
          xlatb:=0;
          xlongb:=0;
        end;
      end;
      if b3art = 2 then
      begin
         h5:=1;
         h1:=xlatv;
         h2:=xlongb;
         h3:=xlatb;
         h4:=xlongv;
         mim2lx:=1;
         mim2ly:=1;
         Button:=mbRight;
      end;
      vbx:=X-5;
      bbx:=X+5;
      vby:=Y-5;
      bby:=Y+5;
      Label2.Caption:='';
      if b3art = 1 then
      begin
        Form1.ZQuery1.SQL.Text:='SELECT * FROM flight';
        Form1.ZQuery1.Open;
        while not Form1.ZQuery1.EOF do
        begin
          if h5 = 0 then
          begin
            h1:=Form1.ZQuery1.Fields[10].AsFloat;
            h2:=Form1.ZQuery1.Fields[11].AsFloat;
            h3:=Form1.ZQuery1.Fields[12].AsFloat;
            h4:=Form1.ZQuery1.Fields[13].AsFloat;
            if h1 > 0 then
            begin
              if h2 > 0 then
              begin
                if ((h1 >= latvy) and (h1 <= latby)) then
                begin
                  if ((h2 >= longvx) and (h2 <= longbx)) then
                  begin
                    h8:=longbx-longvx;
                    h9:=1600/h8/1000;
                    ha:=h2-longvx;
                    flugx:=Round(ha*1000*h9);
                    h8:=latby-latvy;
                    h9:=584/h8/1000;
                    ha:=latby-h1;
                    flugy:=Round(ha*1000*h9);
                    if ((flugx >= vbx) and (flugx <= bbx)) then
                    begin
                      if ((flugy >= vby) and (flugy <= bby)) then
                      begin
                        h5:=1;
                        if Button = mbLeft then
                        begin
                          xlatv:=h1;
                          xlongv:=h4;
                        end;
                        if Button = mbRight then
                        begin
                          xlatb:=h3;
                          xlongb:=h2;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
          if h5 = 0 then
          begin
            if h3 > 0 then
            begin
              if h4 > 0 then
              begin
                if ((h3 >= latvy) and (h3 <= latby)) then
                begin
                  if ((h4 >= longvx) and (h4 <= longbx)) then
                  begin
                    h8:=longbx-longvx;
                    h9:=1600/h8/1000;
                    ha:=h4-longvx;
                    flugx:=Round(ha*1000*h9);
                    h8:=latby-latvy;
                    h9:=584/h8/1000;
                    ha:=latby-h3;
                    flugy:=Round(ha*1000*h9);
                    if ((flugx >= vbx) and (flugx <= bbx)) then
                    begin
                      if ((flugy >= vby) and (flugy <= bby)) then
                      begin
                        h5:=1;
                        if Button = mbLeft then
                        begin
                          xlatv:=h1;
                          xlongv:=h4;
                        end;
                        if Button = mbRight then
                        begin
                          xlatb:=h3;
                          xlongb:=h2;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
          Form1.ZQuery1.Next;
        end;
        Form1.ZQuery1.Close;
      end;
      if h5 = 1 then
      begin
        if Button = mbLeft then
        begin
          mim2lx:=X;
          mim2ly:=Y;
        end else begin
          if Button = mbRight then
          begin
            if mim2lx > 0 then
            begin
              if mim2ly > 0 then
              begin
                mim2rx:=X;
                mim2ry:=Y;
                if xlatv > xlatb then
                begin
                  hd:=xlatb;
                  xlatb:=xlatv;
                  xlatv:=hd;
                end;
                if xlongv > xlongb then
                begin
                  hd:=xlongb;
                  xlongb:=xlongv;
                  xlongv:=hd;
                end;
                h6:=0;
                hd:=0;
                if ((xlatv > 0) and (xlatb > 0)) then
                begin
                  hc:=xlatb-xlatv;
                  he:=Trunc(hc);
                  hb:=(hc - he)*60;
                  hf:=Trunc(hb);
                  hg:=(hb - hf)*60;
                  hd:=he*71440+hf*1190+hg*19.8;
                  if ((xlongv > 0) and (xlongb > 0)) then
                  begin
                    hc:=xlongb-xlongv;
                    he:=Trunc(hc);
                    h1:=(hc - he)*60;
                    hf:=Trunc(hb);
                    hg:=(hb - hf)*60;
                    h6:=he*111130+hf*1850+hg*30.9;
                    h7:=(Sqrt(h6*h6+hd*hd))/1000;
                    Label2.Caption:='Entfernung zwischen den Punkten '+FloatToStrF(h7,ffFixed,8,3)+' Km';
                  end;
                end;
              end;
            end;
            if h5 = 0 then Label2.Caption:='erst Punkt mit linker Maustaste anklicken';
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
  var
    i: Integer;
    pi: TPlaneItem;
    bmp, pbmp: TBGRABitmap;
begin
  //draw map
  bmp := TBGRABitmap.Create('ProcMap.jpg');
  //draw all planes
  if planelist.Count > 0 then
  begin
    for i:=0 to planelist.Count-1 do
    begin
      pi := planelist.Items[i];
      pi.PlaneStream.Position := 0;
      pbmp := TBGRABitmap.Create(pi.PlaneStream);
      bmp.PutImage(pi.Location.X, pi.Location.Y, pbmp, dmDrawWithTransparency);
      pbmp.Free;
    end;
  end;
  bmp.Draw(PaintBox1.Canvas, 0, 0);
  bmp.Free;
  PaintMassstab;
  PaintHome;
  if pfunkt = 1 then Ausbreitung;
  if pfunkt = 3 then Flugstrecke(Sender);
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
// zoomfakt 2 - 19
  if zoomfakt > 2 then
  begin
    zoomfakt:=zoomfakt-1;
    SpeedButton2.Visible:=True;
  end;
  if zoomfakt = 2 then SpeedButton1.Visible:=False;
  MapView1.Visible:=True;
  MapView1.Zoom:=zoomfakt;
  MapView1.Visible:=False;
  if pfunkt = 1 then Ausbreitung;
  if ((mgebiet > 0) and (mgebiet < 3)) then mgebiet:=1;
  if b6art = 1 then
  begin
    glatv:=vonLat;
    glatb:=bisLat;
    glongv:=vonLon;
    glongb:=bisLon;
    Geoum;
  end;
  if b6art = 2 then
  begin
    Timer2.Enabled:=True;
  end;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
  // zoomfakt 2 - 19
  if zoomfakt < 19 then
  begin
    zoomfakt:=zoomfakt+1;
    SpeedButton1.Visible:=True;
  end;
  if zoomfakt = 19 then SpeedButton2.Visible:=False;
  MapView1.Visible:=True;
  MapView1.Zoom:=zoomfakt;
  MapView1.Visible:=False;
  if pfunkt = 1 then Ausbreitung;
  if ((mgebiet > 0) and (mgebiet < 3)) then mgebiet:=1;
  if b6art = 1 then
  begin
    glatv:=vonLat;
    glatb:=bisLat;
    glongv:=vonLon;
    glongb:=bisLon;
    Geoum;
  end;
  if b6art = 2 then
  begin
    Timer2.Enabled:=True;
  end;
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
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  Kartenpunkt:=Homepunkt;
  MapView1.Visible:=True;
  MapView1.Center:=Kartenpunkt;
  MapView1.Visible:=False;
  if pfunkt = 1 then Ausbreitung;
end;


procedure TForm1.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  CanSelect:=True;
  egrid:=aRow;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
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
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if sta = 1 then
  begin
    Form1.Caption:='                   F L Ü G E            Version '+vers+'                   <'+BUser+'>';
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
    iart:=0;
    b3art:=1;
    b5art:=1;
    b6art:=1;
    mrot:=0;
    mrot2:=0;
    mpr:=0;
    mgebiet:=0;
    pfunkt:=0;
    egrid:=0;
    p6plane:=0;
    textausgabe:=0;
    Image2.Visible:=False;
    SpeedButton1.Visible:=False;
    SpeedButton2.Visible:=False;
    SpeedButton3.Visible:=False;
    SpeedButton4.Visible:=False;
    MapView1.Visible:=False;
    PaintBox1.Visible:=False;
    StringGrid1.Visible:=True;
    WVWindowParent1.Visible:=False;
    Timer1.Enabled:=False;
    Timer2.Enabled:=False;
    Button4.Caption:='Anzeigen Flugdaten';
    webanz:=0;
    Label8.Caption:='';
    Combobox1.Enabled:=False;
    ComboBox1.Color:=clInfoBk;
    ComboBox1.Font.Color:=clGray;
    ComboBox1.Text:='';
    ComboBox1.ItemIndex:=-1;
    ComboBox1.ItemHeight:=22;
    ComboBox1.Items.Clear;
    ComboBox1.Items.Add('Hex_ID');
    ComboBox1.Items.Add('Datum und Zeit');
    ComboBox1.Items.Add('Flight');
    ComboBox1.Items.Add('Alt');
    ComboBox1.Items.Add('Speed');
    ComboBox1.Items.Add('Heading');
    ComboBox1.Items.Add('Lat');
    ComboBox1.Items.Add('Long');
    ComboBox1.Items.Add('Anzahl Daten');
    ComboBox1.Items.Add('Fluggesellschaft');
    ComboBox1.Items.Add('Land');
    ComboBox1.Items.Add('Abflughafen');
    ComboBox1.Items.Add('Zielflughafen');
    ComboBox1.Items.Add('Flugzeugtyp');
    ComboBox1.Items.Add('Flüge mit Flugverfolgung');
    ComboBox1.Items.Add('Flüge mit Änderung Höhe 1 - 10 m');
    ComboBox1.Items.Add('Flüge mit Änderung Höhe 11 - 50 m');
    ComboBox1.Items.Add('Flüge mit Änderung Höhe 51 - 100 m');
    ComboBox1.Items.Add('Flüge mit Änderung Höhe 101 - 1000 m');
    ComboBox1.Items.Add('Flüge mit Änderung Höhe über 1000 m');
    ComboBox1.Items.Add('Flüge mit Änderung Geschwindigkeit');
    ComboBox1.Items.Add('Flüge mit Änderung Flugrichtung');
    ComboBox1.Items.Add('Flüge mit Anfangsposition = Endposition');
    ComboBox1.Items.Add('wiederkehrende Flüge');
    ComboBox1.Text:='Flight';
    h1:=ComboBox1.Items.IndexOf('Flight');
    ComboBox1.ItemIndex:=h1;
    vfhei:=0;
    bfhei:=99999;
    Combobox2.Enabled:=False;
    ComboBox2.Color:=clInfoBk;
    ComboBox2.Font.Color:=clGray;
    ComboBox2.Text:='';
    ComboBox2.ItemIndex:=-1;
    ComboBox2.ItemHeight:=22;
    ComboBox2.Items.Clear;
    ComboBox2.Items.Add('unter 100 m');
    ComboBox2.Items.Add('100 - 199 m');
    ComboBox2.Items.Add('200 - 299 m');
    ComboBox2.Items.Add('300 - 399 m');
    ComboBox2.Items.Add('400 - 499 m');
    ComboBox2.Items.Add('500 - 599 m');
    ComboBox2.Items.Add('600 - 699 m');
    ComboBox2.Items.Add('700 - 799 m');
    ComboBox2.Items.Add('800 - 899 m');
    ComboBox2.Items.Add('900 - 999 m');
    ComboBox2.Items.Add('1000 - 1999 m');
    ComboBox2.Items.Add('2000 - 2999 m');
    ComboBox2.Items.Add('3000 - 3999 m');
    ComboBox2.Items.Add('4000 - 4999 m');
    ComboBox2.Items.Add('5000 - 5999 m');
    ComboBox2.Items.Add('6000 - 6999 m');
    ComboBox2.Items.Add('7000 - 7999 m');
    ComboBox2.Items.Add('8000 - 8999 m');
    ComboBox2.Items.Add('9000 - 9999 m');
    ComboBox2.Items.Add('10000 - 10999 m');
    ComboBox2.Items.Add('11000 - 11999 m');
    ComboBox2.Items.Add('12000 - 12999 m');
    ComboBox2.Items.Add('13000 - 13999 m');
    ComboBox2.Items.Add('14000 - 14999 m');
    ComboBox2.Items.Add('15000 - 15999 m');
    ComboBox2.Items.Add('16000 - 16999 m');
    ComboBox2.Items.Add('0 - 4999 m');
    ComboBox2.Items.Add('5000 - 9999 m');
    ComboBox2.Items.Add('10000 - 16999 m');
    ComboBox2.Items.Add('alle Höhen');
    ComboBox2.Text:='alle Höhen';
    h1:=ComboBox2.Items.IndexOf('alle Höhen');
    ComboBox2.ItemIndex:=h1;
    sort:='Flight';
    grdart:=1;
    StringGrid1.RowCount:=2;
    StringGrid1.ColCount:=21;
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
    StringGrid1.ColWidths[20]:=680;
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
    StringGrid1.Cells[20, 0]:='Flugzeugtyp';
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
    StringGrid1.Cells[20, 1]:='';
    zeit:=1500;
    interzeit:=100;
    orgzoom:=11;
    zoomfakt:=11;
    hlat:=49.509;
    hlong:=8.533;
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
                            interzeit:=StrToInt(hb);
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
              zoomfakt:=orgzoom;
              Homepunkt.Lat:=hlat;
              Homepunkt.Lon:=hlong;
              egrid:=0;
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
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if (Closestat = 0) then
  begin
    if (mtasts = 1) then
    begin
      egrid:=0;
      if textausgabe = 1 then planelist.Delete(1);
      textausgabe:=0;
      if p6plane = 1 then planelist.Delete(0);
      p6plane:=0;
      mtasts:=1;
      mlauf:=0;
      close;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
  var h1: string;
  var h2: Double;
  var h3: Double;
  var h4: Double;
  var h5: Double;
  var h8: double;
  var h9: double;
  var ha: double;
  var hb: double;
  var hc: integer;
  var hf: integer;
  var hg: integer;
begin
  if b5art = 1 then
  begin
    if webanz = 0 then
    begin
      if b6art = 1 then
      begin
        if b3art = 1 then
        begin
          if textausgabe = 1 then planelist.Delete(1);
          textausgabe:=0;
          if p6plane = 1 then planelist.Delete(0);
          p6plane:=0;
          if egrid > 0 then
          begin
            h1:=StringGrid1.Cells[4, egrid];
            h2:=StrToFloat(StringGrid1.Cells[11, egrid]);
            h3:=StrToFloat(StringGrid1.Cells[12, egrid]);
            h4:=StrToFloat(StringGrid1.Cells[13, egrid]);
            h5:=StrToFloat(StringGrid1.Cells[14, egrid]);
            if grdart = 2 then
            begin
              h1:=StringGrid1.Cells[1, egrid];
              if h1 = '' then
              begin
                if egrid > 1 then
                begin
                  hf:=1;
                  hg:=egrid;
                  while hf = 1 do
                  begin
                    hg:=hg-1;
                    h1:=StringGrid1.Cells[1, hg];
                    if h1 <> '' then hf:=0;
                    if hg = 1 then hf:=0;
                  end;
                end;
              end;
              h2:=StrToFloat(StringGrid1.Cells[12, egrid]);
              h3:=StrToFloat(StringGrid1.Cells[13, egrid]);
              h4:=StrToFloat(StringGrid1.Cells[14, egrid]);
              h5:=StrToFloat(StringGrid1.Cells[15, egrid]);
            end;
            egrid:=0;
            pfunkt:=3;
            if mapnr = 0 then mapnr:=zoomfakt;
            mapnrsave:=mapnr;
            zoomsave:=zoomfakt;
            Mapan;
            SpeedButton1.Visible:=False;
            SpeedButton2.Visible:=False;
            SpeedButton3.Visible:=False;
            SpeedButton4.Visible:=False;
            mapnr:=0;
            if h1 <> '' then
            begin
              if h2 > 0 then
              begin
                if h3 > 0 then
                begin
                  if h4 > 0 then
                  begin
                    if h5 > 0 then
                    begin
                      mtasts:=0;
                      hb:=0.002;
                      for hc:=orgzoom downto 3 do
                      begin
                        if mapnr = 0 then
                        begin
                          MapView1.Visible:=True;
                          MapView1.Zoom:=hc;
                          MapView1.Visible:=False;
                          mapnr:=0;
                          latvy:=vonLat;
                          latby:=bisLat;
                          longvx:=vonLon;
                          longbx:=bisLon;
                          if ((h2-hb >= latvy) and (h2+hb <= latby))then
                          begin
                            if ((h3-hb >= longvx) and (h3+hb <= longbx))then
                            begin
                              if ((h4-hb >= latvy) and (h4+hb <= latby))then
                              begin
                                if ((h5-hb >= longvx) and (h5+hb <= longbx))then
                                begin
                                  mapnr:=hc;
                                  zoomfakt:=hc;
                                  mapnrsave:=mapnr;
                                end;
                              end;
                            end;
                          end;
                        end;
                      end;
                      if mapnr = 0 then
                      begin
                        Label2.Caption:='keine Karte gefunden';
                        mtasts:=1;
                      end else begin
                        StringGrid1.Visible:=False;
                        Button3.Caption:='zurück zu den Daten';
                        b3art:=2;
                        glatv:=latvy;
                        glatb:=latby;
                        glongv:=longvx;
                        glongb:=longbx;
                        Geoum;
                        h8:=longbx-longvx;
                        h9:=1595/h8/1000;
                        ha:=h3-longvx;
                        flugx1:=Round(ha*1000*h9);
                        h8:=latby-latvy;
                        h9:=566/h8/1000;
                        ha:=latby-h2;
                        flugy1:=Round(ha*1000*h9);
                        h8:=longbx-longvx;
                        h9:=1595/h8/1000;
                        ha:=h5-longvx;
                        flugx2:=Round(ha*1000*h9);
                        h8:=latby-latvy;
                        h9:=566/h8/1000;
                        ha:=latby-h4;
                        flugy2:=Round(ha*1000*h9);
                        fsh2:=h2;
                        fsh3:=h3;
                        fsh4:=h4;
                        fsh5:=h5;
                        flugx1:=flugx1-XYKorrektur(zoomfakt,1);
                        flugx2:=flugx2-XYKorrektur(zoomfakt,1);
                        flugy1:=flugy1+XYKorrektur(zoomfakt,2);
                        flugy2:=flugy2+XYKorrektur(zoomfakt,2);
                        Flugstrecke(Sender);
                        mtasts:=1;
                      end;
                    end else begin
                      Label2.Caption:='bis Long = Null';
                    end;
                  end else begin
                    Label2.Caption:='bis Lat = Null';
                  end;
                end else begin
                  Label2.Caption:='von Long = Null';
                end;
              end else begin
                Label2.Caption:='von Lat = Null';
              end;
            end else begin
              Label2.Caption:='markierte Zeile (Flight) im Stringgrid ist leer';
            end;
          end else begin
            Label2.Caption:='erst Flug im Stringgrid markieren';
          end;
        end else begin
          Button3.Caption:='Anzeigen Flugpositionen';
          b3art:=1;
          pfunkt:=0;
          if textausgabe = 1 then planelist.Delete(1);
          textausgabe:=0;
          if p6plane = 1 then planelist.Delete(0);
          p6plane:=0;
          zoomfakt:=zoomsave;
          mapnr:=mapnrsave;
          MapView1.Visible:=True;
          MapView1.Zoom:=zoomfakt;
          MapView1.Visible:=False;
          Mapaus;
          StringGrid1.Visible:=True;
          StringGrid1.Refresh;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (mtasts = 1) then
  begin
    if b3art = 1 then
    begin
      if b5art = 1 then
      begin
        if b6art = 1 then
        begin
          Label2.Caption:='';
          mtasts:=0;
          egrid:=0;
          if textausgabe = 1 then planelist.Delete(1);
          textausgabe:=0;
          if p6plane = 1 then planelist.Delete(0);
          p6plane:=0;
          mlauf:=1;
          Combobox1.Enabled:=True;
          ComboBox1.Color:=clYellow;
          ComboBox1.Font.Color:=clBlue;
          Form1.ActiveControl:=ComboBox1;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
  var h1: string;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if b5art = 1 then
  begin
    if (mtasts = 1) then
    begin
      if b3art = 1 then
      begin
        if webanz = 0 then
        begin
          if b6art = 1 then
          begin
            if egrid > 0 then
            begin
              h1:=StringGrid1.Cells[4, egrid];
              if h1 <> '' then
              begin
                mtasts:=0;
                egrid:=0;
                if textausgabe = 1 then planelist.Delete(1);
                textausgabe:=0;
                if p6plane = 1 then planelist.Delete(0);
                p6plane:=0;
                webanz:=1;
                StringGrid1.Visible:=False;
                Button4.Caption:='zurück zu den Daten';
                WVWindowParent1.Visible:=True;
                URL:='https://de.flightaware.com/live/flight/'+h1;
                if GlobalWebView2Loader.InitializationError then
                  showmessage(UTF8Encode(GlobalWebView2Loader.ErrorMessage))
                else
                  if GlobalWebView2Loader.Initialized then
                    WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
                  else
                    Timer1.Enabled:=True;
              end else begin
                Label2.Caption:='markierte Zeile im Stringgrid ist leer';
              end;
            end else begin
              Label2.Caption:='erst Flug im Stringgrid markieren';
            end;
          end;
        end;
      end;
    end else begin
      if (mtasts = 0) then
      begin
        if webanz = 1 then
        begin
          Button4.Caption:='Anzeigen Flugdaten';
          WVWindowParent1.Visible:=False;
          webanz:=0;
          mtasts:=1;
          StringGrid1.Visible:=True;
          StringGrid1.Refresh;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
  var h1: integer;
  var h2: Double;
  var h3: Double;
  var h4: Double;
  var h5: Double;
  var h8: double;
  var h9: Double;
  var ha: Double;
  var hb: Double;
  var hc: Double;
  var hd: Double;
  var he: Double;
  var hf: Double;
  var hg: Double;
  var hh: Double;
  var hi: Double;
  var hj: Double;
  var hk: Double;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (mtasts = 1) then
  begin
    Label2.Caption:='';
    if b3art = 1 then
    begin
      if webanz = 0 then
      begin
        if b5art = 1 then
        begin
          if b6art = 1 then
          begin
            egrid:=0;
            if textausgabe = 1 then planelist.Delete(1);
            textausgabe:=0;
            if p6plane = 1 then planelist.Delete(0);
            p6plane:=0;
            Button5.Caption:='Ausbreitung aus';
            pfunkt:=1;
            if mapnr = 0 then mapnr:=zoomfakt;
            mapnrsave:=mapnr;
            b5art:=2;
            Mapan;
            mtasts:=0;
            latvy:=999;
            latby:=0;
            longvx:=999;
            longbx:=0;
            mim2lx:=0;
            mim2ly:=0;
            mim2rx:=0;
            mim2ry:=0;
            Form1.ZQuery1.SQL.Text:='SELECT * FROM flight';
            Form1.ZQuery1.Open;
            while not Form1.ZQuery1.EOF do
            begin
              h9:=Form1.ZQuery1.Fields[10].AsFloat;
              ha:=Form1.ZQuery1.Fields[11].AsFloat;
              hb:=Form1.ZQuery1.Fields[12].AsFloat;
              hc:=Form1.ZQuery1.Fields[13].AsFloat;
              if h9 > latby then latby:=h9;
              if ha > longbx then longbx:=ha;
              if h9 < latvy then latvy:=h9;
              if ha < longvx then longvx:=ha;
              if hb > latby then latby:=hb;
              if hc > longbx then longbx:=hc;
              if hb < latvy then latvy:=hb;
              if hc < longvx then longvx:=hc;
              Form1.ZQuery1.Next;
            end;
            Form1.ZQuery1.Close;
            mapnr:=0;
            zoomsave:=zoomfakt;
            hh:=latvy;
            hi:=latby;
            hj:=longvx;
            hk:=longbx;
            for zoomfakt:=orgzoom downto 3 do
            begin
              if mapnr = 0 then
              begin
                hd:=latvy;
                he:=latby;
                hf:=longvx;
                hg:=longbx;
                MapView1.Visible:=True;
                MapView1.Zoom:=zoomfakt;
                MapView1.Visible:=False;
                mapnr:=0;
                hh:=vonLat;
                hi:=bisLat;
                hj:=vonLon;
                hk:=bisLon;
                latvy:=hd;
                latby:=he;
                longvx:=hf;
                longbx:=hg;
                if ((latvy >= vonLat) and (latvy <= bisLat))then
                begin
                  if ((longvx >= vonLon) and (longvx <= bisLon))then
                  begin
                    if ((latby >= vonLat) and (latby <= bisLat))then
                    begin
                      if ((longbx >= vonLon) and (longbx <= bisLon))then
                      begin
                        mapnr:=zoomfakt;
                        mapnrsave:=mapnr;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end;
          if mapnr = 0 then
          begin
            Label2.Caption:='nicht alle Flugpositionen auf Karte';
            zoomfakt:=zoomsave;
            mapnr:=mapnrsave;
            MapView1.Visible:=True;
            MapView1.Zoom:=zoomfakt;
            MapView1.Visible:=False;
            Mapaus;
            mtasts:=1;
            Button5.Caption:='Ausbreitung an';
            b5art:=1;
            pfunkt:=0;
            Combobox2.Enabled:=False;
            ComboBox2.Color:=clInfoBk;
            ComboBox2.Font.Color:=clGray;
            StringGrid1.Refresh;
          end else begin
            latvy:=hh;
            latby:=hi;
            longvx:=hj;
            longbx:=hk;
            zoomfakt:=mapnr;
            if ((mgebiet > 0) and (mgebiet < 3)) then mgebiet:=1;
            if b6art = 1 then
            begin
              glatv:=vonLat;
              glatb:=bisLat;
              glongv:=vonLon;
              glongb:=bisLon;
              Geoum;
            end;
            Combobox2.Enabled:=True;
            ComboBox2.Color:=clYellow;
            ComboBox2.Font.Color:=clBlue;
            Ausbreitung;
            mtasts:=1;
          end;
        end else begin
          Button5.Caption:='Ausbreitung an';
          pfunkt:=0;
          b5art:=1;
          zoomfakt:=zoomsave;
          mapnr:=mapnrsave;
          MapView1.Visible:=True;
          MapView1.Zoom:=zoomfakt;
          MapView1.Visible:=False;
          Combobox2.Enabled:=False;
          ComboBox2.Color:=clInfoBk;
          ComboBox2.Font.Color:=clGray;
          Mapaus;
          StringGrid1.Refresh;
        end;
      end;
    end;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
  var h3: Double;
  var h4: Double;
  var h5: Double;
  var h6: Double;
  var h7: Double;
  var h8: Double;
  var h9: Double;
  var ha: Double;
  var hc: integer;
  var hd: TDateTime;
  var he: TDateTime;
  var hf: string;
  var hg: Double;
  var hh: Double;
  var hi: Double;
  var hj: Double;
  var hk: Double;
  var hl: Double;
  var hm: Double;
  var hn: Double;
  var ho: Double;
  var hp: Double;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (mtasts = 1) then
  begin
    Label2.Caption:='';
    if b5art = 1 then
    begin
      if webanz = 0 then
      begin
        if b3art = 1 then
        begin
          if b6art = 1 then
          begin
            if egrid > 0 then
            begin
              p6plane:=0;
              pfunkt:=2;
              if mapnr = 0 then mapnr:=zoomfakt;
              mapnrsave:=mapnr;
              zoomsave:=zoomfakt;
              Mapan;
              SpeedButton1.Visible:=False;
              SpeedButton2.Visible:=False;
              SpeedButton3.Visible:=False;
              SpeedButton4.Visible:=False;
              mvhex:=StringGrid1.Cells[0, egrid];
              mvzeit:=StrToDateTime(StringGrid1.Cells[2, egrid]);
              hd:=IncHour(mvzeit,-1);
              he:=IncHour(mvzeit,1);
              egrid:=0;
              hf:='N';
              Form1.ZQuery1.SQL.Text:='SELECT * FROM flight WHERE hexid=:hex AND vonzeit=:zei';
              Form1.ZQuery1.ParamByName('hex').asString:=mvhex;
              Form1.ZQuery1.ParamByName('zei').asDateTime:=mvzeit;
              Form1.ZQuery1.Open;
              while not Form1.ZQuery1.EOF do
              begin
                mvflight:=Form1.ZQuery1.Fields[3].AsString;
                mvalt:=Form1.ZQuery1.Fields[4].AsInteger;
                mvspeed:=Form1.ZQuery1.Fields[6].AsInteger;
                mvhead:=Form1.ZQuery1.Fields[8].AsInteger;
                mvlat:=Form1.ZQuery1.Fields[10].AsFloat;
                mvlong:=Form1.ZQuery1.Fields[11].AsFloat;
                hf:=Form1.ZQuery1.Fields[15].AsString;
                Form1.ZQuery1.Next;
              end;
              Form1.ZQuery1.Close;
              if hf = 'J' then
              begin
                if mpr = 0 then
                begin
                  hm:=latvy;
                  hn:=latby;
                  ho:=longvx;
                  hp:=longbx;
                  h7:=999;
                  h8:=999;
                  h9:=0;
                  ha:=0;
                  Form1.ZQuery1.SQL.Text:='SELECT * FROM verfolgung WHERE hexid=:hex AND zeit>=:vei AND zeit<=:bei AND flight=:fly';
                  Form1.ZQuery1.ParamByName('hex').asString:=mvhex;
                  Form1.ZQuery1.ParamByName('vei').asDateTime:=hd;
                  Form1.ZQuery1.ParamByName('bei').asDateTime:=he;
                  Form1.ZQuery1.ParamByName('fly').asString:=mvflight;
                  Form1.ZQuery1.Open;
                  while not Form1.ZQuery1.EOF do
                  begin
                    hg:=Form1.ZQuery1.Fields[6].AsFloat;
                    hh:=Form1.ZQuery1.Fields[7].AsFloat;
                    if hg < h7 then h7:=hg;
                    if hh < h8 then h8:=hh;
                    if hg > h9 then h9:=hg;
                    if hh > ha then ha:=hh;
                    Form1.ZQuery1.Next;
                  end;
                  Form1.ZQuery1.Close;
                  latvy:=h7;
                  latby:=h9;
                  longvx:=h8;
                  longbx:=ha;
                  b6art:=2;
                  Button6.Caption:='flugverfolgung aus';
                  StringGrid1.Visible:=False;
                  mapnr:=0;
                  for hc:=orgzoom downto 3 do
                  begin
                    if mapnr = 0 then
                    begin
                      hi:=latvy;
                      hj:=latby;
                      hk:=longvx;
                      hl:=longbx;
                      MapView1.Visible:=True;
                      MapView1.Zoom:=hc;
                      MapView1.Visible:=False;
                      mapnr:=0;
                      hm:=vonLat;
                      hn:=bisLat;
                      ho:=vonLon;
                      hp:=bisLon;
                      latvy:=hi;
                      latby:=hj;
                      longvx:=hk;
                      longbx:=hl;
                      h3:=hm;
                      h4:=hn;
                      h5:=ho;
                      h6:=hp;
                      if ((h7 >= h3) and (h7 <= h4))then
                      begin
                        if ((h8 >= h5) and (h8 <= h6))then
                        begin
                          if ((h9 >= h3) and (h9 <= h4))then
                          begin
                            if ((ha >= h5) and (ha <= h6))then
                            begin
                              mapnr:=hc;
                              zoomfakt:=hc;
                              mapnrsave:=mapnr;
                              latvy:=h3;
                              latby:=h4;
                              longvx:=h5;
                              longbx:=h6;
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end else begin
                  b6art:=2;
                  Button6.Caption:='flugverfolgung aus';
                  StringGrid1.Visible:=False;
                  mpr:=0;
                end;
                if mapnr > 0 then
                begin
                  p6plane:=1;
                  Button6.Enabled:=False;
                  Button6.Refresh;
                  Label10.Visible:=True;
                  Label10.Caption:=mvflight;
                  Label10.Refresh;
                  latvy:=hm;
                  latby:=hn;
                  longvx:=ho;
                  longbx:=hp;
                  zoomfakt:=mapnr;
                  Verfolg;
                  Button6.Enabled:=True;
                  Button6.Refresh;
                end else begin
                  Label2.Caption:='keine Karte gefunden';
                  b6art:=1;
                  Button6.Caption:='flugverfolgung an';
                  pfunkt:=0;
                  zoomfakt:=zoomsave;
                  mapnr:=mapnrsave;
                  MapView1.Visible:=True;
                  MapView1.Zoom:=zoomfakt;
                  MapView1.Visible:=False;
                  Mapaus;
                  StringGrid1.Refresh;
                  Label10.Visible:=False;
                  Label10.Refresh;
                end;
              end else begin
                Label2.Caption:='für den Flug gibt es keine Flugverfolgung, Abbruch';
                Button6.Caption:='flugverfolgung an';
                b6art:=1;
                pfunkt:=0;
                zoomfakt:=zoomsave;
                mapnr:=mapnrsave;
                MapView1.Visible:=True;
                MapView1.Zoom:=zoomfakt;
                MapView1.Visible:=False;
                Mapaus;
                StringGrid1.Refresh;
                Label10.Visible:=False;
                Label10.Refresh;
              end;
            end else begin
              Label2.Caption:='erst Flug im Stringgrid markieren';
            end;
          end else begin
            Button6.Caption:='flugverfolgung an';
            if textausgabe = 1 then planelist.Delete(1);
            textausgabe:=0;
            if p6plane = 1 then planelist.Delete(0);
            p6plane:=0;
            b6art:=1;
            pfunkt:=0;
            zoomfakt:=zoomsave;
            mapnr:=mapnrsave;
            MapView1.Visible:=True;
            MapView1.Zoom:=zoomfakt;
            MapView1.Visible:=False;
            Mapaus;
            StringGrid1.Refresh;
            Label10.Visible:=False;
            Label10.Refresh;
          end;
        end;
      end;
    end;
  end;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if mlauf = 1 then
  begin
    Label2.Caption:='';
    Combobox1.Enabled:=False;
    ComboBox1.Color:=clInfoBk;
    ComboBox1.Font.Color:=clGray;
    ialpha:=ComboBox1.Text;
    Form1.Blankwegh;
    Form1.Blankwegv;
    if ialpha <> '' then
    begin
      sort:=ialpha;
      mlauf:=0;
      Laden;
      mtasts:=1;
    end else begin
      Label2.Caption:='Sortierung muss ausgewählt werden';
      Combobox1.Enabled:=True;
      ComboBox1.Color:=clYellow;
      ComboBox1.Font.Color:=clBlue;
      Form1.ActiveControl:=ComboBox1;
    end;
  end;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
  var h1: integer;
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if b5art = 2 then
  begin
    Label2.Caption:='';
    ialpha:=ComboBox2.Text;
    Form1.Blankwegh;
    Form1.Blankwegv;
    if ialpha <> '' then
    begin
      h1:=0;
      if ialpha = 'unter 100 m' then
      begin
        vfhei:=0;
        bfhei:=99;
        h1:=1;
      end;
      if ialpha = '100 - 199 m' then
      begin
        vfhei:=100;
        bfhei:=199;
        h1:=1;
      end;
      if ialpha = '200 - 299 m' then
      begin
        vfhei:=200;
        bfhei:=299;
        h1:=1;
      end;
      if ialpha = '300 - 399 m' then
      begin
        vfhei:=300;
        bfhei:=399;
        h1:=1;
      end;
      if ialpha = '400 - 499 m' then
      begin
        vfhei:=400;
        bfhei:=499;
        h1:=1;
      end;
      if ialpha = '500 - 599 m' then
      begin
        vfhei:=500;
        bfhei:=599;
        h1:=1;
      end;
      if ialpha = '600 - 699 m' then
      begin
        vfhei:=600;
        bfhei:=699;
        h1:=1;
      end;
      if ialpha = '700 - 799 m' then
      begin
        vfhei:=700;
        bfhei:=799;
        h1:=1;
      end;
      if ialpha = '800 - 899 m' then
      begin
        vfhei:=800;
        bfhei:=899;
        h1:=1;
      end;
      if ialpha = '900 - 999 m' then
      begin
        vfhei:=900;
        bfhei:=999;
        h1:=1;
      end;
      if ialpha = '1000 - 1999 m' then
      begin
        vfhei:=1000;
        bfhei:=1999;
        h1:=1;
      end;
      if ialpha = '2000 - 2999 m' then
      begin
        vfhei:=2000;
        bfhei:=2999;
        h1:=1;
      end;
      if ialpha = '3000 - 3999 m' then
      begin
        vfhei:=3000;
        bfhei:=3999;
        h1:=1;
      end;
      if ialpha = '4000 - 4999 m' then
      begin
        vfhei:=4000;
        bfhei:=4999;
        h1:=1;
      end;
      if ialpha = '5000 - 5999 m' then
      begin
        vfhei:=5000;
        bfhei:=5999;
        h1:=1;
      end;
      if ialpha = '6000 - 6999 m' then
      begin
        vfhei:=6000;
        bfhei:=6999;
        h1:=1;
      end;
      if ialpha = '7000 - 7999 m' then
      begin
        vfhei:=7000;
        bfhei:=7999;
        h1:=1;
      end;
      if ialpha = '8000 - 8999 m' then
      begin
        vfhei:=8000;
        bfhei:=8999;
        h1:=1;
      end;
      if ialpha = '9000 - 9999 m' then
      begin
        vfhei:=9000;
        bfhei:=9999;
        h1:=1;
      end;
      if ialpha = '10000 - 10999 m' then
      begin
        vfhei:=10000;
        bfhei:=10999;
        h1:=1;
      end;
      if ialpha = '11000 - 11999 m' then
      begin
        vfhei:=11000;
        bfhei:=11999;
        h1:=1;
      end;
      if ialpha = '12000 - 12999 m' then
      begin
        vfhei:=12000;
        bfhei:=12999;
        h1:=1;
      end;
      if ialpha = '13000 - 13999 m' then
      begin
        vfhei:=13000;
        bfhei:=13999;
        h1:=1;
      end;
      if ialpha = '14000 - 14999 m' then
      begin
        vfhei:=14000;
        bfhei:=14999;
        h1:=1;
      end;
      if ialpha = '15000 - 15999 m' then
      begin
        vfhei:=15000;
        bfhei:=15999;
        h1:=1;
      end;
      if ialpha = '16000 - 16999 m' then
      begin
        vfhei:=16000;
        bfhei:=16999;
        h1:=1;
      end;
      if ialpha = '0 - 4999 m' then
      begin
        vfhei:=0;
        bfhei:=4999;
        h1:=1;
      end;
      if ialpha = '5000 - 9999 m' then
      begin
        vfhei:=5000;
        bfhei:=9999;
        h1:=1;
      end;
      if ialpha = '10000 - 16999 m' then
      begin
        vfhei:=10000;
        bfhei:=16999;
        h1:=1;
      end;
      if ialpha = 'alle Höhen' then
      begin
        vfhei:=0;
        bfhei:=16999;
        h1:=1;
      end;
      if h1 = 1 then
      begin
        MapView1.Visible:=True;
        if zoomfakt < 19 then
        begin
          MapView1.Zoom:=zoomfakt+1;
        end else begin
          MapView1.Zoom:=zoomfakt-1;
        end;
        MapView1.Zoom:=zoomfakt;
        MapView1.Visible:=False;
        Ausbreitung;
      end else begin
        Label2.Caption:='Flughöhe nicht zulässig';
        Form1.ActiveControl:=ComboBox2;
      end;
    end else begin
      Label2.Caption:='Flughöhe muss ausgewählt werden';
      Form1.ActiveControl:=ComboBox2;
    end;
  end;
end;

procedure TForm1.Edit99KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 27 then
  begin
    Edit99.Visible:=False;
    PaintBox1.Visible:=True;
    MapView1.Visible:=True;
    if zoomfakt < 19 then
    begin
      MapView1.Zoom:=zoomfakt+1;
    end else begin
      MapView1.Zoom:=zoomfakt-1;
    end;
    MapView1.Zoom:=zoomfakt;
    MapView1.Visible:=False;
    if pfunkt = 1 then Ausbreitung;
    SpeedButton1.Visible:=True;
    SpeedButton2.Visible:=True;
    SpeedButton3.Visible:=True;
    SpeedButton4.Visible:=True;
  end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Label1.Caption:=widechar(169)+'LINSOFT               F L '+widechar(220)+' G E                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
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

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled:=False;
  if GlobalWebView2Loader.Initialized then
    WVBrowser1.CreateBrowser(WVWindowParent1.Handle)
  else
    Timer1.Enabled:=True;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled:=False;
  b6art:=1;
  mpr:=1;
  Button6.Click;
end;

procedure TForm1.WVBrowser1AfterCreated(Sender: TObject);
begin
  WVWindowParent1.UpdateSize;
  Caption:='';
  WVBrowser1.Navigate(UTF8Decode(URL));
end;

procedure TForm1.WVBrowser1DocumentTitleChanged(Sender: TObject);
begin
  Caption:=UTF8Encode(WVBrowser1.DocumentTitle);
end;

procedure TForm1.WVBrowser1InitializationError(Sender: TObject;
  aErrorCode: HRESULT; const aErrorMessage: wvstring);
begin
  showmessage(UTF8Encode(aErrorMessage));
end;

procedure TForm1.ZConnection1AfterConnect(Sender: TObject);
begin
  if ZConnection1.Connected then
  begin
    dcon:=1;
    Laden;
  end else begin
    dcon:=2;
    JaNein:=messagedlg('keine Verbindung zur Datenbank flight', mtError, [mbOk], 0);
    close;
  end;
end;

initialization
  GlobalWebView2Loader                := TWVLoader.Create(nil);
  GlobalWebView2Loader.UserDataFolder := UTF8Decode(ExtractFileDir(Application.ExeName) + '\CustomCache');
  GlobalWebView2Loader.StartWebView2;

end.

