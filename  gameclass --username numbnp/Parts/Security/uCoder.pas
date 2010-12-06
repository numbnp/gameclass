unit uCoder;

interface

const
DecryptIndex : array[0..31] of longword =
     ( 0, 1, 2, 3, 4, 5, 6, 7, 0, 1, 2, 3, 4, 5, 6, 7,
       0, 1, 2, 3, 4, 5, 6, 7, 7, 6, 5, 4, 3, 2, 1, 0 );

CryptIndex : array [0..31] of longword=
     ( 0, 1, 2, 3, 4, 5, 6, 7, 7, 6, 5, 4, 3, 2, 1, 0,
       7, 6, 5, 4, 3, 2, 1, 0, 7, 6, 5, 4, 3, 2, 1, 0 );

PermutationBlock : array [0..3, 0..255] of longword   = (
    ( $88, $8B, $82, $08E, $86, $85, $80, $89, $87, $81, $8D, $8F, $8A, $83,$8C, $84,
     $B8, $BB, $B2, $BE, $B6, $B5, $B0, $B9, $B7, $B1, $BD, $BF, $BA, $B3, $BC, $B4,
     $28, $2B, $22, $2E, $26, $25, $20, $29, $27, $21, $2D, $2F, $2A, $23, $2C, $24,
     $E8, $EB, $E2, $EE, $E6, $E5, $E0, $E9, $E7, $E1, $ED, $EF, $EA, $E3, $EC, $E4,
     $68, $6B, $62, $6E, $66, $65, $60, $69, $67, $61, $6D, $6F, $6A, $63, $6C, $64,
     $58, $5B, $52, $5E, $56, $55, $50, $59, $57, $51, $5D, $5F, $5A, $53, $5C, $54,
     $08, $0B, $02, $0E, $06, $05, $00, $09, $07, $01, $0D, $0F, $0A, $03, $0C, $04,
     $98, $9B, $92, $9E, $96, $95, $90, $99, $97, $91, $9D, $9F, $9A, $93, $9C, $94,
     $78, $7B, $72, $7E, $76, $75, $70, $79, $77, $71, $7D, $7F, $7A, $73, $7C, $74,
     $18, $1B, $12, $1E, $16, $15, $10, $19, $17, $11, $1D, $1F, $1A, $13, $1C, $14,
     $D8, $DB, $D2, $DE, $D6, $D5, $D0, $D9, $D7, $D1, $DD, $DF, $DA, $D3, $DC, $D4,
     $F8, $FB, $F2, $FE, $F6, $F5, $F0, $F9, $F7, $F1, $FD, $FF, $FA, $F3, $FC, $F4,
     $A8, $AB, $A2, $AE, $A6, $A5, $A0, $A9, $A7, $A1, $AD, $AF, $AA, $A3, $AC, $A4,
     $38, $3B, $32, $3E, $36, $35, $30, $39, $37, $31, $3D, $3F, $3A, $33, $3C, $34,
     $C8, $CB, $C2, $CE, $C6, $C5, $C0, $C9, $C7, $C1, $CD, $CF, $CA, $C3, $CC, $C4,
     $48, $4B, $42, $4E, $46, $45, $40, $49, $47, $41, $4D, $4F, $4A, $43, $4C, $44 ),

    ($EE00, $ED00, $EA00, $E000, $E700, $E600, $E300, $E100, $EC00, $E400, $E800, $E900, $EF00, $EB00, $E200, $E500,
     $DE00, $DD00, $DA00, $D000, $D700, $D600, $D300, $D100, $DC00, $D400, $D800, $D900, $DF00, $DB00, $D200, $D500,
     $AE00, $AD00, $AA00, $A000, $A700, $A600, $A300, $A100, $AC00, $A400, $A800, $A900, $AF00, $AB00, $A200, $A500,
     $0E00, $0D00, $0A00, $0000, $0700, $0600, $0300, $0100, $0C00, $0400, $0800, $0900, $0F00, $0B00, $0200, $0500,
     $7E00, $7D00, $7A00, $7000, $7700, $7600, $7300, $7100, $7C00, $7400, $7800, $7900, $7F00, $7B00, $7200, $7500,
     $6E00, $6D00, $6A00, $6000, $6700, $6600, $6300, $6100, $6C00, $6400, $6800, $6900, $6F00, $6B00, $6200, $6500,
     $3E00, $3D00, $3A00, $3000, $3700, $3600, $3300, $3100, $3C00, $3400, $3800, $3900, $3F00, $3B00, $3200, $3500,
     $1E00, $1D00, $1A00, $1000, $1700, $1600, $1300, $1100, $1C00, $1400, $1800, $1900, $1F00, $1B00, $1200, $1500,
     $CE00, $CD00, $CA00, $C000, $C700, $C600, $C300, $C100, $CC00, $C400, $C800, $C900, $CF00, $CB00, $C200, $C500,
     $4E00, $4D00, $4A00, $4000, $4700, $4600, $4300, $4100, $4C00, $4400, $4800, $4900, $4F00, $4B00, $4200, $4500,
     $8E00, $8D00, $8A00, $8000, $8700, $8600, $8300, $8100, $8C00, $8400, $8800, $8900, $8F00, $8B00, $8200, $8500,
     $9E00, $9D00, $9A00, $9000, $9700, $9600, $9300, $9100, $9C00, $9400, $9800, $9900, $9F00, $9B00, $9200, $9500,
     $FE00, $FD00, $FA00, $F000, $F700, $F600, $F300, $F100, $FC00, $F400, $F800, $F900, $FF00, $FB00, $F200, $F500,
     $BE00, $BD00, $BA00, $B000, $B700, $B600, $B300, $B100, $BC00, $B400, $B800, $B900, $BF00, $BB00, $B200, $B500,
     $2E00, $2D00, $2A00, $2000, $2700, $2600, $2300, $2100, $2C00, $2400, $2800, $2900, $2F00, $2B00, $2200, $2500,
     $5E00, $5D00, $5A00, $5000, $5700, $5600, $5300, $5100, $5C00, $5400, $5800, $5900, $5F00, $5B00, $5200, $5500 ),

    ($6D0000, $6E0000, $6F0000, $6A0000, $600000, $620000, $640000, $680000, $670000, $650000, $610000, $630000, $690000, $6C0000, $660000, $6B0000,
     $CD0000, $CE0000, $CF0000, $CA0000, $C00000, $C20000, $C40000, $C80000, $C70000, $C50000, $C10000, $C30000, $C90000, $CC0000, $C60000, $CB0000,
     $AD0000, $AE0000, $AF0000, $AA0000, $A00000, $A20000, $A40000, $A80000, $A70000, $A50000, $A10000, $A30000, $A90000, $AC0000, $A60000, $AB0000,
     $8D0000, $8E0000, $8F0000, $8A0000, $800000, $820000, $840000, $880000, $870000, $850000, $810000, $830000, $890000, $8C0000, $860000, $8B0000,
     $ED0000, $EE0000, $EF0000, $EA0000, $E00000, $E20000, $E40000, $E80000, $E70000, $E50000, $E10000, $E30000, $E90000, $EC0000, $E60000, $EB0000,
     $0D0000, $0E0000, $0F0000, $0A0000, $000000, $020000, $040000, $080000, $070000, $050000, $010000, $030000, $090000, $0C0000, $060000, $0B0000,
     $DD0000, $DE0000, $DF0000, $DA0000, $D00000, $D20000, $D40000, $D80000, $D70000, $D50000, $D10000, $D30000, $D90000, $DC0000, $D60000, $DB0000,
     $9D0000, $9E0000, $9F0000, $9A0000, $900000, $920000, $940000, $980000, $970000, $950000, $910000, $930000, $990000, $9C0000, $960000, $9B0000,
     $2D0000, $2E0000, $2F0000, $2A0000, $200000, $220000, $240000, $280000, $270000, $250000, $210000, $230000, $290000, $2C0000, $260000, $2B0000,
     $4D0000, $4E0000, $4F0000, $4A0000, $400000, $420000, $440000, $480000, $470000, $450000, $410000, $430000, $490000, $4C0000, $460000, $4B0000,
     $7D0000, $7E0000, $7F0000, $7A0000, $700000, $720000, $740000, $780000, $770000, $750000, $710000, $730000, $790000, $7C0000, $760000, $7B0000,
     $FD0000, $FE0000, $FF0000, $FA0000, $F00000, $F20000, $F40000, $F80000, $F70000, $F50000, $F10000, $F30000, $F90000, $FC0000, $F60000, $FB0000,
     $5D0000, $5E0000, $5F0000, $5A0000, $500000, $520000, $540000, $580000, $570000, $550000, $510000, $530000, $590000, $5C0000, $560000, $5B0000,
     $3D0000, $3E0000, $3F0000, $3A0000, $300000, $320000, $340000, $380000, $370000, $350000, $310000, $330000, $390000, $3C0000, $360000, $3B0000,
     $BD0000, $BE0000, $BF0000, $BA0000, $B00000, $B20000, $B40000, $B80000, $B70000, $B50000, $B10000, $B30000, $B90000, $BC0000, $B60000, $BB0000,
     $1D0000, $1E0000, $1F0000, $1A0000, $100000, $120000, $140000, $180000, $170000, $150000, $110000, $130000, $190000, $1C0000, $160000, $1B0000 ),

    ($FF000000, $F9000000, $FA000000, $F4000000, $F6000000, $FE000000, $F7000000, $F8000000, $F1000000, $FB000000, $FD000000, $F2000000, $FC000000, $F0000000, $F5000000, $F3000000,
     $9F000000, $99000000, $9A000000, $94000000, $96000000, $9E000000, $97000000, $98000000, $91000000, $9B000000, $9D000000, $92000000, $9C000000, $90000000, $95000000, $93000000,
     $AF000000, $A9000000, $AA000000, $A4000000, $A6000000, $AE000000, $A7000000, $A8000000, $A1000000, $AB000000, $AD000000, $A2000000, $AC000000, $A0000000, $A5000000, $A3000000,
     $4F000000, $49000000, $4A000000, $44000000, $46000000, $4E000000, $47000000, $48000000, $41000000, $4B000000, $4D000000, $42000000, $4C000000, $40000000, $45000000, $43000000,
     $6F000000, $69000000, $6A000000, $64000000, $66000000, $6E000000, $67000000, $68000000, $61000000, $6B000000, $6D000000, $62000000, $6C000000, $60000000, $65000000, $63000000,
     $EF000000, $E9000000, $EA000000, $E4000000, $E6000000, $EE000000, $E7000000, $E8000000, $E1000000, $EB000000, $ED000000, $E2000000, $EC000000, $E0000000, $E5000000, $E3000000,
     $7F000000, $79000000, $7A000000, $74000000, $76000000, $7E000000, $77000000, $78000000, $71000000, $7B000000, $7D000000, $72000000, $7C000000, $70000000, $75000000, $73000000,
     $8F000000, $89000000, $8A000000, $84000000, $86000000, $8E000000, $87000000, $88000000, $81000000, $8B000000, $8D000000, $82000000, $8C000000, $80000000, $85000000, $83000000,
     $1F000000, $19000000, $1A000000, $14000000, $16000000, $1E000000, $17000000, $18000000, $11000000, $1B000000, $1D000000, $12000000, $1C000000, $10000000, $15000000, $13000000,
     $BF000000, $B9000000, $BA000000, $B4000000, $B6000000, $BE000000, $B7000000, $B8000000, $B1000000, $BB000000, $BD000000, $B2000000, $BC000000, $B0000000, $B5000000, $B3000000,
     $DF000000, $D9000000, $DA000000, $D4000000, $D6000000, $DE000000, $D7000000, $D8000000, $D1000000, $DB000000, $DD000000, $D2000000, $DC000000, $D0000000, $D5000000, $D3000000,
     $2F000000, $29000000, $2A000000, $24000000, $26000000, $2E000000, $27000000, $28000000, $21000000, $2B000000, $2D000000, $22000000, $2C000000, $20000000, $25000000, $23000000,
     $CF000000, $C9000000, $CA000000, $C4000000, $C6000000, $CE000000, $C7000000, $C8000000, $C1000000, $CB000000, $CD000000, $C2000000, $CC000000, $C0000000, $C5000000, $C3000000,
     $0F000000, $09000000, $0A000000, $04000000, $06000000, $0E000000, $07000000, $08000000, $01000000, $0B000000, $0D000000, $02000000, $0C000000, $00000000, $05000000, $03000000,
     $5F000000, $59000000, $5A000000, $54000000, $56000000, $5E000000, $57000000, $58000000, $51000000, $5B000000, $5D000000, $52000000, $5C000000, $50000000, $55000000, $53000000,
     $3F000000, $39000000, $3A000000, $34000000, $36000000, $3E000000, $37000000, $38000000, $31000000, $3B000000, $3D000000, $32000000, $3C000000, $30000000, $35000000, $33000000 )
);
Codes64 = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/';

    SimpleKey: array [0..7] of longword = (
      82779826, 618712327, 794034436, 3230538377,
      1806516334, 172116876, 2869668358, 2991933454);

type
  TKeyArray = array [0..7] of longword;

  TLongCodeArray = array of longword;

  //
  // TCoder
  //

  TCoder = class(TObject)
  private
    procedure _SimpleSubstDecrypt(var Key : TKeyArray;
                                  var InData : TLongCodeArray;
                                  Size:longint;
                                  var OutData : TLongCodeArray);
    procedure _Decrypt32 ( var Key:TKeyArray;
                                  InN1:longword;
                                  InN2:longword;
                                  var OutN1:longword;
                                  var OutN2:longword);

    procedure _SimpleSubstEncrypt(var Key : TKeyArray;
                                  var InData : TLongCodeArray;
                                  size : longint;
                                  var OutData : TLongCodeArray);

    procedure _Encrypt32 ( var Key : TKeyArray;
                                  InN1 : longword;
                                  InN2 : longword;
                                  var OutN1 : longword;
                                  var OutN2 : longword);
  public
    procedure _StringToLongCodeArray(strInData: String; var OutData: TLongCodeArray);
    procedure _LongCodeArrayToString(InData: TLongCodeArray; var strOutData: String);
    procedure _RemoveZeroBytes(var str: String);
    procedure _AddZeroBytes(var str: String);
    procedure _RemoveCRLF(var str: String);
    procedure _GiveBackCRLF(var str: String);
    procedure Code(strInData : string; var OutData : TLongCodeArray);
    procedure Decode( var InData : TLongCodeArray; var strOutData : string);
    procedure EncodeString(key:TKeyArray; var str:String);
    procedure DecodeString(key:TKeyArray; var str:String);
    function SimpleEncodeString(const AstrData : String): String;
    function SimpleDecodeString(const AstrData : String): String;
    function _Base64Encode(const S: String): AnsiString;
    function _Base64Decode(const S: String): AnsiString;

  end; // TCoder

implementation

uses
  StrUtils,
  SysUtils;

{$OVERFLOWCHECKS OFF}
procedure TCoder._Decrypt32 ( var Key:TKeyArray;
                 InN1:longword;
                 InN2:longword;
                 var OutN1:longword;
                 var OutN2:longword );
var i:longint;
    old:longword;
begin
  i := 31;
  while ( i>=0 ) do begin
    old := InN2;
    InN2 := InN1;
    InN1 := InN1 + Key [ DecryptIndex [ i ] ];
    InN1 := (PermutationBlock [ 0 ][ InN1 and $FF ] ) or
             PermutationBlock [ 1 ][ ( (InN1 and $FF00) shr 8  ) ] or
             PermutationBlock [ 2 ][ ( (InN1 and $FF0000) shr 16 ) ] or
             PermutationBlock [ 3 ][ InN1 shr 24 ];
    InN1 := ( InN1 shl 11 ) or ( InN1 shr 21 );
    InN1 := InN1 xor old;
    Dec(i);
  end;
  OutN1 := InN2;
  OutN2 := InN1;
end;

procedure TCoder._Encrypt32 ( var Key : TKeyArray;
                              InN1 : longword;
                              InN2 : longword;
                              var OutN1 : longword;
                              var OutN2 : longword);
var i:longint;
    old:longword;
begin
  i := 31;
  while ( i>=0 ) do begin
    old := InN2;
    InN2 := InN1;
    InN1 := InN1 + Key [ CryptIndex [ i ] ];
    InN1 := (PermutationBlock [ 0 ][ InN1 and $FF ] ) or
             PermutationBlock [ 1 ][ ( (InN1 and $FF00) shr 8  ) ] or
             PermutationBlock [ 2 ][ ( (InN1 and $FF0000) shr 16 ) ] or
             PermutationBlock [ 3 ][ InN1 shr 24 ];
    InN1 := ( InN1 shl 11 ) or ( InN1 shr 21 );
    InN1 := InN1 xor old;
    Dec(i);
  end;
  OutN1 := InN2;
  OutN2 := InN1;
end; // TCoder._Encrypt32

procedure TCoder._StringToLongCodeArray(strInData: String; var OutData: TLongCodeArray);
var
  nSize:Integer;
  i:Integer;
  nBuf:LongWord;
  nSize8:Integer;
begin
  nSize := Length(strInData);

  nSize8 := nSize div 8;
  if (nSize mod 8)<>0 then inc(nSize8);

  SetLength(OutData, nSize8*2);

  for i:=0 to nSize8*2 - 1  do begin
    OutData[i] := 0;
    if (i*4+1)>nSize then break;
    nBuf := ord(strInData[i*4+1]);
    OutData[i] := nBuf;
    if (i*4+2)>nSize then break;
    nBuf := (ord(strInData[i*4+2]) shl 8);
    OutData[i] := OutData[i] + nBuf;
    if (i*4+3)>nSize then break;
    nBuf := (ord(strInData[i*4+3]) shl 16);
    OutData[i] := OutData[i] + nBuf;
    if (i*4+4)>nSize then break;
    nBuf := (ord(strInData[i*4+4]) shl 24);
    OutData[i] := OutData[i] + nBuf;
  end;
end;

procedure TCoder._LongCodeArrayToString(InData: TLongCodeArray; var strOutData: String);
var
  i:Integer;
  nBuf:LongWord;
begin
  strOutData := '';
  for i:=0 to High(InData) do begin
    nBuf := (InData[i] and $FF);
    strOutData:=strOutData+chr(nBuf);
    nBuf := (InData[i] and $FF00)shr 8;
    strOutData:=strOutData+chr(nBuf);
    nBuf := (InData[i] and $FF0000)shr 16;
    strOutData:=strOutData+chr(nBuf);
    nBuf := (InData[i] and $FF000000)shr 24;
    strOutData:=strOutData+chr(nBuf);
  end;
end;

procedure TCoder._RemoveZeroBytes(var str: String);
begin
  str:=String(PChar(str));
end;

procedure TCoder._AddZeroBytes(var str: String);
begin
  str:=String(PChar(str));
end;

procedure TCoder._RemoveCRLF(var str: String);
begin
  str := AnsiReplaceStr(str, Chr($0D), 'dddd');
  str := AnsiReplaceStr(str, Chr($0A), 'aaaa');
end;

procedure TCoder._GiveBackCRLF(var str: String);
begin
  str := AnsiReplaceStr(str, 'dddd', Chr($0D) );
  str := AnsiReplaceStr(str, 'aaaa', Chr($0A) );
end;

procedure TCoder.Code(strInData : string; var OutData : TLongCodeArray);
var
  Key:TKeyArray;
  Size:longint;
  InData : TLongCodeArray;
  r:integer;
begin
  Key[7] := 1951537416;
  Key[6] := 3017517518;
  Key[5] := 4056307283;
  Key[4] := 2280356879;
  Key[3] := 2678914080;
  Key[2] := 1098935274;
  Key[1] := 3212398180;
  Key[0] := 1111683305;

  Size := Length(strInData);

  r := Size div 8;
  if (Size mod 8)<>0 then inc(r);

  SetLength(OutData, r*2);

  _StringToLongCodeArray(strInData,InData);
  _SimpleSubstEncrypt (Key, InData, r, OutData);

end; // TCoder.Code

procedure TCoder.Decode(
     var InData : TLongCodeArray;
     var strOutData : string);
var
    Key:TKeyArray;
    OutData : TLongCodeArray;
    Size:Integer;
begin
  Key[7] := 1951537416;
  Key[6] := 3017517518;
  Key[5] := 4056307283;
  Key[4] := 2280356879;
  Key[3] := 2678914080;
  Key[2] := 1098935274;
  Key[1] := 3212398180;
  Key[0] := 1111683305;

  Size := (High(InData)+1) div 2;
  SetLength(OutData, Size*2);

  _SimpleSubstDecrypt (Key, InData, Size, OutData);
  _LongCodeArrayToString(OutData,strOutData);
end; // TCoder.Decode

procedure TCoder.EncodeString(key:TKeyArray; var str:String);
var
  nSize:Integer;
  InData,OutData : TLongCodeArray;
  nSize8:integer;
begin
  nSize := Length(str);
  nSize8 := nSize div 8;
  if (nSize mod 8)<>0 then inc(nSize8);
  SetLength(OutData, nSize8*2);
  _StringToLongCodeArray(str,InData);
  _SimpleSubstEncrypt (Key, InData, nSize8, OutData);
  _LongCodeArrayToString(OutData,str);
  str := _Base64Encode(str);
//  _RemoveCRLF(str);
//  _RemoveZeroBytes(str);
end; // TCoder.Code

procedure TCoder.DecodeString(key:TKeyArray; var str:String);
var
  nSize:Integer;
  InData,OutData : TLongCodeArray;
begin
//  _GiveBackCRLF(str);
  str := _Base64Decode(str);
  _StringToLongCodeArray(str,InData);
  nSize := (High(InData)+1) div 2;
  SetLength(OutData, nSize*2);
  _SimpleSubstDecrypt (Key, InData, nSize, OutData);
  _LongCodeArrayToString(OutData,str);
//  _RemoveZeroBytes(str);
end; // TCoder.Decode

procedure TCoder._SimpleSubstDecrypt (
     var Key : TKeyArray;
     var InData : TLongCodeArray;
     Size:longint;
     var OutData : TLongCodeArray);
var i:integer;
begin
  i := Size-1;
  while ( i >=0 ) do
    begin
      _Decrypt32 ( Key,
                 InData [ i * 2 ],
                 InData [ i * 2 + 1 ],
                 OutData [ i * 2 ],
                 OutData [ i * 2 + 1 ]
     );
     Dec(i);
   end;

end; // TCoder._SimpleSubstDecrypt

procedure TCoder._SimpleSubstEncrypt(
     var Key : TKeyArray;
     var InData : TLongCodeArray;
     size : longint;
     var OutData : TLongCodeArray);
var i:integer;
begin
  i := Size-1;
  while ( i >= 0 ) do
    begin
      _Encrypt32 ( Key,
                   InData [ i * 2 ],
                   InData [ i * 2 + 1 ],
                   OutData [ i * 2 ],
                   OutData [ i * 2 + 1 ]
                    );
      Dec(i);
    end;
end; // TCoder._SimpleSubstEncrypt

function TCoder.SimpleEncodeString(const AstrData : String): String;
var
  strResult: String;
begin
  strResult := AstrData;
  EncodeString(TKeyArray(SimpleKey), strResult);
  Result := strResult;
end; // TCoder.SimpleEncodeString

function TCoder.SimpleDecodeString(const AstrData : String): String;
var
  strResult: String;
begin
  strResult := AstrData;
  DecodeString(TKeyArray(SimpleKey), strResult);
  Result := strResult;
end; // TCoder.SimpleEncodeString


function TCoder._Base64Decode(const S: string): string;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Pos(s[i], codes64) - 1;
    if x >= 0 then
    begin
      b := b * 64 + x;
      a := a + 6;
      if a >= 8 then
      begin
        a := a - 8;
        x := b shr a;
        b := b mod (1 shl a);
        x := x mod 256;
        Result := Result + chr(x);
      end;
    end
    else
      Exit;
  end;
end;

function TCoder._Base64Encode(const S: string): string;
var
  i: Integer;
  a: Integer;
  x: Integer;
  b: Integer;
begin
  Result := '';
  a := 0;
  b := 0;
  for i := 1 to Length(s) do
  begin
    x := Ord(s[i]);
    b := b * 256 + x;
    a := a + 8;
    while a >= 6 do
    begin
      a := a - 6;
      x := b div (1 shl a);
      b := b mod (1 shl a);
      Result := Result + Codes64[x + 1];
    end;
  end;
  if a > 0 then
  begin
    x := b shl (6 - a);
    Result := Result + Codes64[x + 1];
  end;
end;

end.





