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
    H = 4;   W = 4;   // розмір поля - 4х4
var

    wc,hc: integer; // ширина і висота клітинки

    // ігрове поле
    pole: array[1..H, 1..W] of byte;
    ex,ey: integer; // координати пустої клітинки

    // правильне положення клітинок
    stp : array[1..H, 1..W] of byte =
    (( 1, 2, 3, 4),
     ( 5, 6, 7, 8),
     ( 9,10,11,12),
     (13,14,15, 0));
     //кількість ходів
     kilk : integer;
     pic: TBitmap;   // картинка

// нова гра
procedure TForm1.NewGame;
var
    fname: string[20]; // файл картинки
    i,j: integer;
begin
  try
  randomize;
  i:=random(9);
  pic.LoadFromFile('pic_'+inttostr(i+1)+'.bmp')


        except
            on EFopenError do
               begin
                ShowMessage('Помилка зчитування з файлу ' + fname);
                Form1.Close;
               end;
    end;
    // Розмір форми = розміру картинки

    // размір клітинки
    hc := Pic.Height div H;
    wc := Pic.Width div W;

    // размір форми
    ClientWidth  := wc * W;
    ClientHeight := hc * H;

    // правильне положення
    for i:=1 to H do
        for j:=1 to W do
            pole[i,j] := stp[i,j];
    kilk:=0;  //кількість ходів
    Form1.Mixer;    // перемішати пазли
    Form1.ShowPole; // відобразити ігрове поле
end;

// первірка на правильне положення пазлів

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
       // на наступну клітинку
       if col < 4
          then inc(col)
       else begin
          col :=1;
          inc(row);
       end;
    end;
end;


// переміщення пазлів

procedure Move(cx,cy: integer);
// cx,cy - пазл, на який гравець клацнув мишкою
var
    r: integer;       // вибір гравця
begin
    // перевірка можливості обміну
    if not (( abs(cx-ex) = 1) and (cy-ey = 0) or
            ( abs(cy-ey) = 1) and (cx-ex = 0))
    then exit;
    // Обмін з x,y в ex,ey
    Pole[ey,ex] := Pole[cy,cx];
    Pole[cy,cx] := 0;
    ex:=cx;
    ey:=cy;
    kilk:=kilk+1;
    // малюємо поле
    Form1.ShowPole;
    if Finish then
    begin
        pole[4,4] := 16;
        Form1.ShowPole;
        r := MessageDlg('Ціль досягнута!'+ #13+ 'Кількість ходів'+inttostr(kilk)+#13+
        'Ще раз?',mtInformation,[mbYes,mbNo],0);
        if r = mrNo then Form1.Close; // завершує работу програми
        Form1.NewGame;
    end;
end;

// клацання мишкою в программі
procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
    cx,cy: integer; // координати пазлу
begin
    // вираховуємо координати клітинки
    cx := Trunc(X / wc) + 1;
    cy := Trunc(Y / hc) + 1;
    Move(cx,cy);
end;

// виводить ігрове поле
procedure TForm1.ShowPole;
var
    Source, Dest: Trect;
    sx,sy: integer;
    i,j: integer;

begin

    // вміст клітинок
    for i := 1 to W do
        for j := 1 to H do
        begin
            // перетворюємо номер клітинки
            // в координати лівого верхнього кута
            sy := ((pole[i,j] -1 ) div W) * hc;
            sx := ((pole[i,j] -1 ) mod W) * wc;

            Source := Bounds(sx,sy,wc,hc);
            Dest := Bounds((j-1)*wc,(i-1)*hc,wc,hc);
            if pole[i,j] <> 0
                then Canvas.CopyRect(Dest,pic.Canvas,Source)
                else Canvas.Rectangle((j-1)*wc,(i-1)*hc,j*wc,i*hc);
        end;
end;

// перемішуємо пазли
procedure TForm1.Mixer;
var
    x1,y1: integer; // пуста клітинка
    x2,y2: integer; // цю перемістити в пусту
    d: integer;     // напрямок, відносто пустої
    i: integer;
begin
    x1:=4; y1:=4; //
    randomize;
    for i:= 1 to 150 do  // к-сть перестановок
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
        // визничимо пазл
        // який необхідно пермістити в пусту клітинку
        Pole[y1,x1] := Pole[y2,x2];
        Pole[y2,x2] := 0;
        x1:=x2;
        y1:=y2;
    end;
    // запамятаємо координати пустої клітинки
    ex:= x1;
    ey:= y1;
end;

// обробка події OnCreate
procedure TForm1.FormCreate(Sender: TObject);
begin
    pic := TBitMap.Create;
    NewGame;
end;

// обробка події OnPaint
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

            // перетворюємо номер клітинки
            // в координати лівого верхнього кута
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
