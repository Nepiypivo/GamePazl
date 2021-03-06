unit soberi_;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, Menus;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormPaint(Sender: TObject);


    procedure ShowPole;
    procedure Mixer;
    procedure NewGame;
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3;

{$R *.dfm}

const
    H = 4;   W = 4;   // ����� ���� - 4�4
var

    wc,hc: integer; // ������ � ������ �������

    // ������ ����
    pole: array[1..H, 1..W] of byte;
    ex,ey: integer; // ���������� ����� �������

    // ��������� ��������� �������
    stp : array[1..H, 1..W] of byte =
    (( 1, 2, 3, 4),
     ( 5, 6, 7, 8),
     ( 9,10,11,12),
     (13,14,15, 0));
     //������� ����
     kilk : integer;
     pic: TBitmap;   // ��������

// ���� ���
procedure TForm1.NewGame;
var
    fname: string[20]; // ���� ��������
    i,j: integer;
begin
  try
  randomize;
  i:=random(9);
  pic.LoadFromFile('pic_'+inttostr(i+1)+'.bmp')


        except
            on EFopenError do
               begin
                ShowMessage('������� ���������� � ����� ' + fname);
                Form1.Close;
               end;
    end;
    // ����� ����� = ������ ��������

    // ����� �������
    hc := Pic.Height div H;
    wc := Pic.Width div W;

    // ����� �����
    ClientWidth  := wc * W;
    ClientHeight := hc * H;

    // ��������� ���������
    for i:=1 to H do
        for j:=1 to W do
            pole[i,j] := stp[i,j];
    kilk:=0;  //������� ����
    Form1.Mixer;    // ��������� �����
    Form1.ShowPole; // ���������� ������ ����
end;

// ������� �� ��������� ��������� �����

function Finish: boolean;
var
    row,col: integer;
    i: integer;
begin
    row :=1; col :=1;
    Finish := True;
    for i:=1 to 15 do
    begin
       if pole[row,col] <> i then
       begin
            Finish:= False;
            break;
       end;
       // �� �������� �������
       if col < 4
          then inc(col)
       else begin
          col :=1;
          inc(row);
       end;
    end;
end;


// ���������� �����

procedure Move(cx,cy: integer);
// cx,cy - ����, �� ���� ������� ������� ������
var
    r: integer;       // ���� ������
begin
    // �������� ��������� �����
    if not (( abs(cx-ex) = 1) and (cy-ey = 0) or
            ( abs(cy-ey) = 1) and (cx-ex = 0))
    then exit;
    // ���� � x,y � ex,ey
    Pole[ey,ex] := Pole[cy,cx];
    Pole[cy,cx] := 0;
    ex:=cx;
    ey:=cy;
    kilk:=kilk+1;
    // ������� ����
    Form1.ShowPole;
    if Finish then
    begin
        pole[4,4] := 16;
        Form1.ShowPole;
        r := MessageDlg('ֳ�� ���������!'+ #13+ 'ʳ������ ����'+inttostr(kilk)+#13+
        '�� ���?',mtInformation,[mbYes,mbNo],0);
        if r = mrNo then Form1.Close; // ������� ������ ��������
        Form1.NewGame;
    end;
end;

// �������� ������ � ��������
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    cx,cy: integer; // ���������� �����
begin
    // ���������� ���������� �������
    cx := Trunc(X / wc) + 1;
    cy := Trunc(Y / hc) + 1;
    Move(cx,cy);
end;

// �������� ������ ����
procedure TForm1.ShowPole;
var
    Source, Dest: Trect;
    sx,sy: integer;
    i,j: integer;

begin

    // ���� �������
    for i := 1 to W do
        for j := 1 to H do
        begin
            // ������������ ����� �������
            // � ���������� ����� ��������� ����
            sy := ((pole[i,j] -1 ) div W) * hc;
            sx := ((pole[i,j] -1 ) mod W) * wc;

            Source := Bounds(sx,sy,wc,hc);
            Dest := Bounds((j-1)*wc,(i-1)*hc,wc,hc);
            if pole[i,j] <> 0
                then Canvas.CopyRect(Dest,pic.Canvas,Source)
                else Canvas.Rectangle((j-1)*wc,(i-1)*hc,j*wc,i*hc);
        end;
end;

// ��������� �����
procedure TForm1.Mixer;
var
    x1,y1: integer; // ����� �������
    x2,y2: integer; // �� ���������� � �����
    d: integer;     // ��������, ������� �����
    i: integer;
begin
    x1:=4; y1:=4; //
    randomize;
    for i:= 1 to 150 do  // �-��� ������������
    begin
        repeat
            x2:=x1;
            y2:=y1;
            d:=random(4)+1;
            case d of
                1: dec(x2);
                2: inc(x2);
                3: dec(y2);
                4: inc(y2);
            end;
        until (x2>=1) and (x2<=4) and (y2>=1) and (y2<=4);
        // ��������� ����
        // ���� ��������� ��������� � ����� �������
        Pole[y1,x1] := Pole[y2,x2];
        Pole[y2,x2] := 0;
        x1:=x2;
        y1:=y2;
    end;
    // ���������� ���������� ����� �������
    ex:= x1;
    ey:= y1;
end;

// ������� ��䳿 OnCreate
procedure TForm1.FormCreate(Sender: TObject);
begin
    pic := TBitMap.Create;
    NewGame;
end;

// ������� ��䳿 OnPaint
procedure TForm1.FormPaint(Sender: TObject);
begin
    Form1.ShowPole;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
Form1.NewGame;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
Form2.Show;
end;

procedure TForm1.N5Click(Sender: TObject);
var
    Source, Dest: Trect;
    sx,sy: integer;
    i,j: integer;
begin
 for i := 1 to 4 do
        for j := 1 to 4 do
        begin
           Form3.ClientWidth  := wc * W;
            Form3.ClientHeight := hc * H;

            // ������������ ����� �������
            // � ���������� ����� ��������� ����
            sy := ((stp[i,j] -1 ) div 4) * hc;
            sx := ((stp[i,j] -1 ) mod 4) * wc;
Form3.Show;
            Source := Bounds(sx,sy,wc,hc);
            Dest := Bounds((j-1)*wc,(i-1)*hc,wc,hc);
            if stp[i,j] <> 0
                then Form3.Canvas.CopyRect(Dest,pic.Canvas,Source)
                else Form3.Canvas.Rectangle((j-1)*wc,(i-1)*hc,j*wc,i*hc);
        end;

end;

end.
