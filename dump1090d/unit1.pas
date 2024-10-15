unit Unit1;

{*

Hersteller:
           LinSoft Jürgen linder (juelin) dg5uap@darc.de

Lizens:
           Opensource entsprechend

Hardware:
           SDR NEWGEN.RTL2832SDR über USB

Software:
           Folgende Files
           rtlsdr.dll, dump1090.exe, dump1090-abbruch.bat,
           dump1090-batch.bat, dump1090-file.bat und pthreadVC2.dll
           müssen im Soucepfad vorhanden sein

wie Compelieren:
           Lazarus IDE mit FPC
           Packages pl_win_api muss installiert sein
           pl_win_api muss im Objektinspektor als neue
           Anforderung hinzugefügt sein

wie Ausführen:
           Ausführen dump1090d.exe (Icon)

*}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Eingabe, pl_win_api, shellapi,
  LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ListBox1: TListBox;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    function Nummer(Komma: Boolean; var Ntextstring: string): string;        // prüfen ob Ntextstring numerisch ist
                                                                             // wenn nicht wird Result leer zurück gegeben
                                                                             // Kamma=True wenn Komma erlaubt ist
                                                                             // Bei Komma wird aus '.' ein ',' gemacht
    function Blankweg(Art: integer; var Btextstring: string): string;        // Blanks in Btextstring entfernen und in Result zurück geben
                                                                             // Art 1 = vor dem Text
                                                                             // Art 2 = hinter dem Text
                                                                             // Art 3 = vor und hinter dem Text
    function Blankdazu(Pos, Lan: integer; var Htextstring: string): string;  // Blanks im Htextstring einfügen und in Result zurück geben
                                                                             // Lan = Ausgabelänge von Result
                                                                             // Pos 1 = vor dem Text
                                                                             // Pos 2 = hinter dem Text
    procedure LesenADSB;                                                     // Lesen ADS-B Daten aus File daten.dat
                                                                             // alle empfangenen Daten in Tabelle flighttab1 als String
    procedure Ladanzeige(tabnr: integer);                                    // Ausgabezeile für Listbox laden und aufbereiten in listzeile
                                                                             // tabnr = Nummer der Tabelle flightliste
  public
  end;

type tflight = record   // Flugzeugdaten vom SDR
  hex: string;
  mode: string;
  sqwk: string;
  flight: string;
  alt: integer;
  spd: integer;
  hdg: integer;
  lat: double;
  long: double;
  sig: integer;
  msgs: integer;
  ti: integer;
  datenvorhanden: Boolean;
  listennummer: integer;
  datenzeit: TDateTime;
end;

const
  flightanzmax: integer = 101;

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
  vers: string;
  flightliste: array of tflight;
  flightlisteanz: integer;
  listenanz: integer;
  fnum: TextFile;
  zeit: integer;
  beendenTimer: Boolean;
  empfangADSB: Boolean;
  heof: integer;
  flighttab: array of string;
  flighttabanz: integer;
  listzeile: string;
  listanzahl: string;
  listenanzahlstell: integer;
  kummulieren: Boolean;

implementation

{$R *.lfm}

procedure TForm1.FormActivate(Sender: TObject);
  var h3: string;
  var h5: integer;
  var h6: integer;
  var h7: integer;
  var h8: integer;
  var h9: string;
  var ha: integer;
  var hb: string;
  var hf: integer;
begin
  Label1.Caption:=UTF8Encode(#169)+'LINSOFT               D U M P 1 0 9 0 D                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if sta = 1 then
  begin
    Form1.Caption:='  '+Application.Title+'            Version '+vers+'                   <'+BUser+'>';
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
    Timer1.Enabled:=False;
    ListBox1.Items.Clear;
    flightlisteanz:=0;
    listenanz:=0;
    zeit:=10;
    beendenTimer:=False;
    empfangADSB:=False;
    kummulieren:=False;
    SetLength(flightliste, flightanzmax);
    SetLength(flighttab, flightanzmax);
    Label6.Caption:='';
    Label6.Refresh;
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
            end;
            h3:='';
          end;
        end;
        CloseFile(fnum);
        if h5 <> 2 then
        begin
          if h7 <> 1 then
          begin
            Label2.Caption:='Anzahl Sätze in Zeit-Datei stimmt nicht';
            Label2.Refresh;
            sleep(10000);
            abbruch:=True;
            close;
          end;
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
  Label1.Caption:=UTF8Encode(#169)+'LINSOFT               D U M P 1 0 9 0 D                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Label2.Caption:='';
  if (Closestat = 0) then
  begin
    if (mtasts = 1) then
    begin
      mtasts:=0;
      mlauf:=0;
      close;
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if empfangADSB then
  begin
    if Button3.Caption = 'Daten kumulieren an' then
    begin
      kummulieren:=True;
      Button3.Caption:='Daten kumulieren aus';
      Button3.Refresh;
    end else begin
      kummulieren:=False;
      Button3.Caption:='Daten kumulieren an';
      Button3.Refresh;
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ((mtasts = 0) and (empfangADSB)) then
  begin
    beendenTimer:=True;
  end else begin
    if mtasts = 1 then
    begin
      mtasts:=0;
      Label2.Caption:='';
      Button1.Caption:='Stop ADS-B Daten';
      ListBox1.Items.Clear;
      flightlisteanz:=0;
      beendenTimer:=False;
      Label6.Caption:='';
      Label6.Refresh;
      listenanz:=4;
      listanzahl:='Start ADS-B Datenempfang '+DateTimeToStr(now)+'    Anzahl Flüge: ';
      listenanzahlstell:=Length(listanzahl);
      ListBox1.Items.Add(listanzahl+IntToStr(listenanz-4));
      ListBox1.Items.Add('');
      ListBox1.Items.Add('ICAO-ID Mode  Sqwk Flight     Alt  Speed Heading Latitude Longitude Signal Message# Time      Daten empfangen');
      ListBox1.Items.Add('=============================================================================================================');
      empfangADSB:=True;
      Timer1.Enabled:=True;
    end;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Label1.Caption:=UTF8Encode(#169)+'LINSOFT               D U M P 1 0 9 0 D                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  Form1.Cursor:=crDefault;
  Form1.Refresh;
  CloseAction:=caFree;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  Label1.Caption:=UTF8Encode(#169)+'LINSOFT               D U M P 1 0 9 0 D                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
  if (abbruch) then
  begin
    Timer1.Enabled:=False;
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
        Timer1.Enabled:=False;
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
begin
  Label1.Caption:=UTF8Encode(#169)+'LINSOFT               D U M P 1 0 9 0 D                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
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
  abbruch:=false;
  sta:=1;
  Rec:=LongRec(GetFileVersion(ParamStr(0)));
  vers:=Format('%.*d.%.*d', [2, Rec.Hi,2, Rec.Lo]);
  Form1.Caption:='  '+Application.Title+'            Version '+vers+'                   <'+BUser+'>';
  Label1.Caption:=UTF8Encode(#169)+'LINSOFT               D U M P 1 0 9 0 D                 Datum: '+FormatDateTime('DD.MM.YYYY',now);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
  var h1: integer;
  var h2: integer;
  var h3: integer;
  var h4: string;
  var h5: integer;
  var h6: integer;
  var h7: integer;
  var h8: string;
  var h9: integer;
  var ha: Boolean;
  var hb: string;
  var hr: integer;
  var hx: Boolean;
  var w1: string;
  var w2: string;
  var w3: string;
  var w4: string;
  var w5: integer;
  var w6: integer;
  var w7: integer;
  var w8: double;
  var w9: double;
  var w10: integer;
  var w11: integer;
  var w12: integer;
  var w13: TDateTime;
begin
  Timer1.Enabled:=False;
  Label2.Caption:='';
  if not beendenTimer then
  begin
    if FileExists(ExtractFilePath(ParamStr(0))+'daten.dat') then
    begin
      DeleteFile(ExtractFilePath(ParamStr(0))+'daten.dat');
    end;
// Daten empfangen
    h1:=ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-batch.bat'), nil, nil, SW_SHOWMINIMIZED);
    sleep(zeit*10);
    if h1 = 42 then
    begin
      if not beendenTimer then
      begin
        sleep(zeit*20);
      end;
      w13:=now;
      h1:=ShellExecute(0, nil, PChar(ExtractFilePath(ParamStr(0))+'dump1090-abbruch.bat'), nil, nil, SW_SHOWMINIMIZED);
      sleep(zeit*5);
      if h1 = 42 then
      begin
        if not beendenTimer then
        begin
          if FileExists(ExtractFilePath(ParamStr(0))+'daten.dat') then
          begin
            FileMode:=fmOpenRead;
            AssignFile(fnum, ExtractFilePath(ParamStr(0))+'daten.dat');
            hr:=0;
            try
              Reset(fnum);
            except
              hr:=1;
            end;
            if hr = 0 then
            begin
              LesenADSB;     // Lesen ADS-B Daten aus File daten.dat
              CloseFile(fnum);
// Daten verarbeiten
              if not beendenTimer then
              begin
                if heof = 1 then
                begin
                  if flightlisteanz > 0 then
                  begin
                    for h5:=1 to flightlisteanz do
                    begin
                      flightliste[h5].datenvorhanden:=False;
                    end;
                  end;
                  if flighttabanz > 0 then
                  begin
                    hx:=True;
                    for h1:=1 to flighttabanz do
                    begin
                      if hx then
                      begin
                        h4:=flighttab[h1];
                        h2:=Length(h4);
                        hx:=False;
                        w1:='';
                        w2:='';
                        w3:='';
                        w4:='';
                        w5:=0;
                        w6:=0;
                        w7:=0;
                        w8:=0;
                        w9:=0;
                        w10:=0;
                        w11:=0;
                        w12:=0;
                        if h2 = 78 then
                        begin
                          ialpha:=Copy(h4,1,6);
                          ialpha:=Blankweg(3, ialpha);
                          if kummulieren then
                          begin
                            if ialpha = '      ' then ialpha:='';
                          end;
                          h3:=Length(ialpha);
                          hx:=False;
                          if h3 = 6 then
                          begin
                            w1:=ialpha;
                            hx:=True;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,9,1);
                            ialpha:=Blankweg(3, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = ' ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            hx:=False;
                            if h3 > 0 then
                            begin
                              w2:=ialpha;
                              if w2 = 'S' then hx:=True;
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,15,4);
                            ialpha:=Nummer(False, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '    ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w3:=ialpha;
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,21,8);
                            ialpha:=Blankweg(3, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '        ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w4:=ialpha;
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,30,5);
                            ialpha:=Nummer(False, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '     ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w5:=StrToInt(ialpha);
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,37,3);
                            ialpha:=Nummer(False, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '   ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w6:=StrToInt(ialpha);
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,42,3);
                            ialpha:=Nummer(False, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '   ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w7:=StrToInt(ialpha);
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,48,6);
                            ialpha:=Nummer(True, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '      ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w8:=StrToFloat(ialpha);
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,58,6);
                            ialpha:=Nummer(True, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '      ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w9:=StrToFloat(ialpha);
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,65,3);
                            ialpha:=Nummer(False, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '   ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w10:=StrToInt(ialpha);
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,70,4);
                            ialpha:=Nummer(False, ialpha);
                            if kummulieren then
                            begin
                              if ialpha = '    ' then ialpha:='';
                            end;
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w11:=StrToInt(ialpha);
                            end;
                          end;
                          if hx then
                          begin
                            ialpha:=Copy(h4,77,2);
                            ialpha:=Nummer(False, ialpha);
                            h3:=Length(ialpha);
                            if h3 > 0 then
                            begin
                              w12:=StrToInt(ialpha);
                            end;
                          end;
                        end;
// Tabelle laden
                        if not beendenTimer then
                        begin
                          if hx then
                          begin
                            if w8 < 0 then w8:=0;
                            if w9 < 0 then w9:=0;
                            h9:=0;
                            if flightlisteanz > 0 then
                            begin
                              for h7:=1 to flightlisteanz do
                              begin
                                if w1 = flightliste[h7].hex then h9:=h7;
                              end;
                            end;
                            if h9 > 0 then
                            begin
                              if kummulieren then
                              begin
                                if w3 <> '' then flightliste[h9].sqwk:=w3;
                                if w4 <> '' then flightliste[h9].flight:=w4;
                                if w5 > 0 then flightliste[h9].alt:=w5;
                                if w6 > 0 then flightliste[h9].spd:=w6;
                                if w7 > 0 then flightliste[h9].hdg:=w7;
                                if w8 > 0 then flightliste[h9].lat:=w8;
                                if w9 > 0 then flightliste[h9].long:=w9;
                                if w10 > 0 then flightliste[h9].sig:=w10;
                                if w11 > 0 then flightliste[h9].msgs:=w11;
                                if w12 > 0 then flightliste[h9].ti:=w12;
                                flightliste[h9].datenvorhanden:=True;
                                flightliste[h9].listennummer:=0;
                              end else begin
                                flightliste[h9].sqwk:=w3;
                                flightliste[h9].flight:=w4;
                                flightliste[h9].alt:=w5;
                                flightliste[h9].spd:=w6;
                                flightliste[h9].hdg:=w7;
                                flightliste[h9].lat:=w8;
                                flightliste[h9].long:=w9;
                                flightliste[h9].sig:=w10;
                                flightliste[h9].msgs:=w11;
                                flightliste[h9].ti:=w12;
                                flightliste[h9].datenvorhanden:=True;
                                flightliste[h9].listennummer:=0;
                              end;
                            end else begin
                              if flightlisteanz < flightanzmax-1 then
                              begin
                                flightlisteanz:=flightlisteanz+1;
                                flightliste[flightlisteanz].hex:=w1;
                                flightliste[flightlisteanz].mode:=w2;
                                flightliste[flightlisteanz].sqwk:=w3;
                                flightliste[flightlisteanz].flight:=w4;
                                flightliste[flightlisteanz].alt:=w5;
                                flightliste[flightlisteanz].spd:=w6;
                                flightliste[flightlisteanz].hdg:=w7;
                                flightliste[flightlisteanz].lat:=w8;
                                flightliste[flightlisteanz].long:=w9;
                                flightliste[flightlisteanz].sig:=w10;
                                flightliste[flightlisteanz].msgs:=w11;
                                flightliste[flightlisteanz].ti:=w12;
                                flightliste[flightlisteanz].datenzeit:=w13;
                                flightliste[flightlisteanz].datenvorhanden:=True;
                                flightliste[flightlisteanz].listennummer:=0;
                                h9:=flightlisteanz;
                              end;
                            end;
// Daten anzeigen
                            if not beendenTimer then
                            begin
                              if flightlisteanz > 0 then
                              begin
                                h6:=0;
                                if listenanz > 4 then
                                begin
                                  for h7:=5 to listenanz do
                                  begin
                                    h8:=Copy(ListBox1.Items.Strings[h7-1],1,6);
                                    if h8 = w1 then h6:=h7;
                                  end;
                                end;
                                Ladanzeige(h9);
                                if h6 > 0 then
                                begin
                                  ListBox1.Items.Strings[h6-1]:=listzeile;
                                end else begin
                                  if listenanz < flightanzmax-1 then
                                  begin
                                    listenanz:=listenanz+1;
                                    h6:=listenanz;
                                    ListBox1.Items.Add(listzeile);
                                  end;
                                end;
                                ListBox1.Items.Strings[0]:=listanzahl+IntToStr(listenanz-4);
                                ListBox1.Refresh;
                                Label6.Caption:='';
                                if listenanz-4 > 0 then Label6.Caption:=IntToStr(listenanz-4);
                                Label6.Refresh;
                                flightliste[h9].listennummer:=h6;
                              end;
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
// nicht mehr vorhandene Flüge aus Tabelle und Anzeige löschen
                  if not beendenTimer then
                  begin
                    if flightlisteanz > 0 then
                    begin
                      ha:=True;
                      While ha do
                      begin
                        ha:=False;
                        h9:=0;
                        h8:='';
                        for h7:=1 to flightlisteanz do
                        begin
                          if not flightliste[h7].datenvorhanden then
                          begin
                            h9:=h7;
                            h8:=flightliste[h7].hex;
                          end;
                        end;
                        if h9 > 0 then
                        begin
                          ha:=True;
                          if h9 <  flightlisteanz then
                          begin
                            for h7:=h9 to flightlisteanz do
                            begin
                              flightliste[h7].hex:=flightliste[h7+1].hex;
                              flightliste[h7].mode:=flightliste[h7+1].mode;
                              flightliste[h7].sqwk:=flightliste[h7+1].sqwk;
                              flightliste[h7].flight:=flightliste[h7+1].flight;
                              flightliste[h7].alt:=flightliste[h7+1].alt;
                              flightliste[h7].spd:=flightliste[h7+1].spd;
                              flightliste[h7].hdg:=flightliste[h7+1].hdg;
                              flightliste[h7].lat:=flightliste[h7+1].lat;
                              flightliste[h7].long:=flightliste[h7+1].long;
                              flightliste[h7].sig:=flightliste[h7+1].sig;
                              flightliste[h7].msgs:=flightliste[h7+1].msgs;
                              flightliste[h7].ti:=flightliste[h7+1].ti;
                              flightliste[h7].datenzeit:=flightliste[h7+1].datenzeit;
                              flightliste[h7].datenvorhanden:=flightliste[h7+1].datenvorhanden;
                              flightliste[h7].listennummer:=flightliste[h7+1].listennummer;
                            end;
                          end;
                          flightlisteanz:=flightlisteanz-1;
                          if listenanz > 4 then
                          begin
                            h6:=0;
                            if h8 <> '' then
                            begin
                              for h7:=5 to listenanz do
                              begin
                                hb:=Copy(ListBox1.Items.Strings[h7-1],1,6);
                                if h8 = hb then h6:=h7;
                              end;
                            end;
                            if h6 > 0 then
                            begin
                              ListBox1.Items.Delete(h6-1);
                              listenanz:=listenanz-1;
                              ListBox1.Items.Strings[0]:=listanzahl+IntToStr(listenanz-4);
                              ListBox1.Refresh;
                              Label6.Caption:='';
                              if listenanz-4 > 0 then Label6.Caption:=IntToStr(listenanz-4);
                              Label6.Refresh;
                            end;
                          end;
                        end;
                      end;
                    end;
                  end;
                end;
              end;
            end;
          end else begin
            Label2.Caption:='File: '+ExtractFilePath(ParamStr(0))+'daten.dat nicht vorhanden, Abbruch';
            beendenTimer:=True;
          end;
        end;
      end else begin
        Label2.Caption:='ShellExecute Returncode: '+IntToStr(h1);
        beendenTimer:=True;
      end;
    end else begin
      Label2.Caption:='ShellExecute Returncode: '+IntToStr(h1);
      beendenTimer:=True;
    end;
  end;
// Abbruch
  if beendenTimer then
  begin
    beendenTimer:=False;
    empfangADSB:=False;
    mtasts:=1;
    ListBox1.Items.Add('');
    ListBox1.Items.Add('Stop ADS-B Datenempfang '+DateTimeToStr(now));
    ListBox1.Items.Add('Alt in Feet, Speed in Miles, Heading, Latitude und Longitude in Grad');
    Button1.Caption:='Start ADS-B Daten';
    Button1.Refresh;
    kummulieren:=False;
    Button3.Caption:='Daten kumulieren an';
    Button3.Refresh;
  end else begin
    Timer1.Enabled:=True;
  end;
end;

procedure TForm1.LesenADSB;               // Lesen ADS-B Daten aus File daten.dat
                                          // alle empfangenen Daten in Tabelle flighttab1 als String
  var h1: integer;
  var h2: string;
  var h3: integer;
  var h4: AnsiChar;
  var h6: integer;
  var h7: string;
  var h8: string;
  var h9: string;
  var ha: integer;
  var hb: integer;
begin
  flighttabanz:=0;
  h2:='';
  h1:=1;
  h3:=0;
  heof:=0;
  while h1 = 1 do
  begin
    if not beendenTimer then
    begin
      if not Eof(fnum) then
      begin
        if not beendenTimer then
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
                  end;
                end else begin
                  if h3 = 3 then
                  begin
                    h6:=Length(h2);
                    if ((h6 = 4) and (h2 = 'Hex ')) then
                    begin
                      h3:=1;
                    end else begin
                      h6:=Ord(h4);
                      if h6 = 13 then
                      begin
                        h6:=Length(h2);
                        if h6 > 5 then
                        begin
                          hb:=0;
                          if flighttabanz > 0 then
                          begin
                            h8:=Copy(h2,1,6);
                            for ha:=1 to flighttabanz do
                            begin
                              h7:=flighttab[ha];
                              h9:=Copy(h7,1,6);
                              if h8 = h9 then hb:=ha;
                            end;
                          end;
                          if hb > 0 then
                          begin
                            h7:=Copy(h2,1,h6-1);
                            flighttab[hb]:=h7;
                          end else begin
                            if flighttabanz < flightanzmax-1 then
                            begin
                              flighttabanz:=flighttabanz+1;
                              h7:=Copy(h2,1,h6-1);
                              flighttab[flighttabanz]:=h7;
                            end;
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

procedure TForm1.Ladanzeige(tabnr: integer);                              // Ausgabezeile für Listbox laden und aufbereiten in listzeile
                                                                          // tabnr = Nummer der Tabelle flightliste
  var h1: string;
begin
  listzeile:=flightliste[tabnr].hex;
  listzeile:=listzeile+'     ';
  listzeile:=listzeile+flightliste[tabnr].mode;
  listzeile:=listzeile+'  ';
  listzeile:=listzeile+Blankdazu(1, 4, flightliste[tabnr].sqwk);
  listzeile:=listzeile+' ';
  listzeile:=listzeile+Blankdazu(2, 8, flightliste[tabnr].flight);
  listzeile:=listzeile+' ';
  if flightliste[tabnr].alt > 0 then
  begin
    h1:=IntToStr(flightliste[tabnr].alt);
    listzeile:=listzeile+Blankdazu(1, 5, h1);
  end else begin
    listzeile:=listzeile+'     ';
  end;
  listzeile:=listzeile+'    ';
  if flightliste[tabnr].spd > 0 then
  begin
    h1:=IntToStr(flightliste[tabnr].spd);
    listzeile:=listzeile+Blankdazu(1, 3, h1);
  end else begin
    listzeile:=listzeile+'   ';
  end;
  listzeile:=listzeile+'     ';
  if flightliste[tabnr].hdg > 0 then
  begin
    h1:=IntToStr(flightliste[tabnr].hdg);
   listzeile:=listzeile+Blankdazu(1, 3, h1);
  end else begin
    listzeile:=listzeile+'   ';
  end;
  listzeile:=listzeile+'   ';
  if flightliste[tabnr].lat > 0 then
  begin
   h1:=FormatFloat('0.000', flightliste[tabnr].lat);
   listzeile:=listzeile+Blankdazu(1, 6, h1);
  end else begin
    listzeile:=listzeile+'      ';
  end;
  listzeile:=listzeile+'    ';
  if flightliste[tabnr].long > 0 then
  begin
   h1:=FormatFloat('0.000', flightliste[tabnr].long);
   listzeile:=listzeile+Blankdazu(1, 6, h1);
  end else begin
    listzeile:=listzeile+'      ';
  end;
  listzeile:=listzeile+'    ';
  if flightliste[tabnr].sig > 0 then
  begin
    h1:=IntToStr(flightliste[tabnr].sig);
    listzeile:=listzeile+Blankdazu(1, 3, h1);
  end else begin
    listzeile:=listzeile+'   ';
  end;
  listzeile:=listzeile+'     ';
  if flightliste[tabnr].msgs > 0 then
  begin
    h1:=IntToStr(flightliste[tabnr].msgs);
    listzeile:=listzeile+Blankdazu(1, 4, h1);
  end else begin
    listzeile:=listzeile+'    ';
  end;
  listzeile:=listzeile+'   ';
  if flightliste[tabnr].ti > 0 then
  begin
    h1:=IntToStr(flightliste[tabnr].ti);
    listzeile:=listzeile+Blankdazu(1, 2, h1);
  end else begin
    listzeile:=listzeile+'  ';
  end;
  listzeile:=listzeile+'  ';
  if flightliste[tabnr].datenzeit > 0 then
  begin
    h1:=DateTimeToStr(flightliste[tabnr].datenzeit);
    listzeile:=listzeile+h1;
  end else begin
    listzeile:=listzeile+'                   ';
  end;
end;

function TForm1.Blankweg(Art: integer; var Btextstring: string): string;  // Blanks in Btextstring entfernen und in Result zurück geben
                                                                          // Art 1 = vor dem Text
                                                                          // Art 2 = hinter dem Text
                                                                          // Art 3 = vor und hinter dem Text
  var laenge: integer;
  var stelle: integer;
  var vari12: integer;
  var zeichen: string;
  var ausgabe: string;
begin
  laenge:=Length(Btextstring);
  ausgabe:='';
  if laenge > 0 then
  begin
    ausgabe:=Btextstring;
    if ((Art = 1) or (Art = 3)) then
    begin
      vari12:=0;
      for stelle:=1 to laenge do
      begin
        zeichen:=Copy(Btextstring,stelle,1);
        if (vari12 = 0) then
        begin
          if (zeichen <> ' ') then
          begin
            vari12:=stelle;
          end;
        end;
      end;
      if vari12 > 0 then
      begin
        zeichen:=Btextstring;
        ausgabe:=Copy(zeichen,vari12,laenge-(vari12-1));
      end;
    end;
    laenge:=Length(ausgabe);
    if laenge > 0 then
    begin
      if ((Art = 2) or (Art = 3)) then
      begin
        vari12:=0;
        for stelle:=laenge downto 1 do
        begin
          zeichen:=Copy(ausgabe,stelle,1);
          if (vari12 = 0) then
          begin
            if (zeichen <> ' ') then
            begin
              vari12:=stelle;
            end;
          end;
        end;
        if (vari12 > 0) then
        begin
          zeichen:=ausgabe;
          ausgabe:=Copy(zeichen,1,vari12);
        end;
      end;
    end else begin
      ausgabe:='';
    end;
  end;
  Result:=ausgabe;
end;

function TForm1.Blankdazu(Pos, Lan: integer; var Htextstring: string): string;  // Blanks im Htextstring einfügen und in Result zurück geben
                                                                                // Lan = Ausgabelänge von Result
                                                                                // Pos 1 = vor dem Text
                                                                                // Pos 2 = hinter dem Text
  var laenge: integer;
  var stelle: integer;
  var ausgabe: string;
begin
  laenge:=Length(Htextstring);
  ausgabe:=Htextstring;
  if laenge < Lan then
  begin
    while laenge < Lan do
    begin
      if Pos = 1 then
      begin
        ausgabe:=' '+ausgabe;
      end else begin
        ausgabe:=ausgabe+' ';
      end;
      laenge:=Length(ausgabe);
    end;
  end else begin
    if laenge > Lan then
    begin
      if Pos = 1 then
      begin
        stelle:=laenge-Lan+1;
        ausgabe:=Copy(Htextstring,stelle,Lan);
      end else begin
        ausgabe:=Copy(Htextstring,1,Lan);
      end;
    end;
  end;
  Result:=ausgabe;
end;

function TForm1.Nummer(Komma: Boolean; var Ntextstring: string): string;   // prüfen ob Ntextstring numerisch ist
                                                                           // wenn nicht wird Result leer zurück gegeben
                                                                           // Kamma=True wenn Komma erlaubt ist
                                                                           // Bei Komma wird aus '.' ein ',' gemacht
  var laenge: integer;
  var stelle: integer;
  var m: integer;
  var zeichen: string;
  var h1: string;
  var h2: string;
  var tt: string;
begin
  laenge:=Length(Ntextstring);
  tt:='';
  if laenge > 0 then
  begin
    Ntextstring:=Blankweg(3, Ntextstring);
    laenge:=Length(Ntextstring);
    if laenge > 0 then
    begin
      tt:=ialpha;
      for stelle:=1 to laenge do
      begin
        zeichen:=Copy(Ntextstring,stelle,1);
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
        if ((komma) and (zeichen = '.')) then
        begin
          m:=1;
          h1:='';
          h2:='';
          if stelle > 1 then h1:=Copy(Ntextstring,1,stelle-1);
          if ((stelle > 1) and (stelle < laenge)) then h2:=Copy(Ntextstring,stelle+1,laenge-stelle);
          tt:=h1+','+h2;
        end;
        if ((komma) and (zeichen = ',')) then
        begin
          m:=1;
        end;
        if m = 0 then
        begin
          tt:='';
        end;
      end;
    end;
  end;
  Result:=tt;
end;

end.

