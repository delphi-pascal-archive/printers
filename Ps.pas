unit Ps;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Jpeg, Printers, ComCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Button1: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Memo1: TMemo;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Bevel3: TBevel;
    Memo2: TMemo;
    Button3: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button4: TButton;
    Button5: TButton;
    Image1: TImage;
    Bevel5: TBevel;
    Label7: TLabel;
    Button6: TButton;
    Label8: TLabel;
    Button7: TButton;
    Button8: TButton;
    PrinterSetupDialog1: TPrinterSetupDialog;
    Bevel4: TBevel;
    Button9: TButton;
    Bevel6: TBevel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label9: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Image2: TImage;
    Image3: TImage;
    PrintDialog1: TPrintDialog;
    TabSheet3: TTabSheet;
    Memo3: TMemo;
    Button10: TButton;
    Bevel7: TBevel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.Button1Click(Sender: TObject);
begin
 ListBox1.Clear;
 ListBox1.Items:=Printer.Printers;
 ListBox1.Sorted:=true;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
 Stroka:System.Text;
 i:integer;
begin
//печать в текстовом режиме
 AssignPrn(Stroka);//связь текстовой переменной с принтером
 Rewrite(Stroka);
 Printer.Canvas.Font:=Memo1.Font;
 for i:=0 to Memo1.Lines.Count-1 do
  Writeln(Stroka,Memo1.Lines[i]); // построчная печать строк
 System.Close(stroka); // разрыв связи после печати
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 x,y,i:longint;
begin
 Printer.Canvas.Font:=Memo1.Font;
 Printer.BeginDoc;
 x:=0; // координаты начала вывода текста
 y:=0;
 for i:=0 to Memo1.Lines.Count-1 do
  begin                                    // TextExtent - высота строки
   Printer.Canvas.TextOut(x,y,Memo1.Lines[i]);
   y:=y+Printer.Canvas.TextExtent(Memo1.Lines[i]).cy; // на след. строку
  end;
 Printer.EndDoc; 
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
 //выводимое изображение содержится в образе Image1
 Printer.BeginDoc;
 Printer.Canvas.Draw(100,100,Image1.Picture.Bitmap);
 Printer.EndDoc;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
//на листе рисуются прямоугольник и круг
 Printer.BeginDoc;
 Printer.Canvas.Rectangle(485,145,540,200);
 Printer.Canvas.Ellipse(525,144,580,200);
 Printer.EndDoc;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
 logo:TBitMap;
begin
//загрузка логотипа
 logo:=TBitMap.Create;
 logo.LoadFromFile('dollars.bmp');  //логотип
//начало вывода
 Printer.BeginDoc;
//вывод логотипа
 Printer.Canvas.Draw(100,100,logo);
//вывод реквизитов
 Printer.Canvas.Font.Name:='Courier';
 Printer.Canvas.Font.Style:=[fsBold]+[fsItalic];
 Printer.Canvas.Font.Size:=14;
 Printer.Canvas.TextOut(Printer.PageWidth div 2,100,'ООО "Мойдодыр"');
 Printer.Canvas.Font.Style:=[];
 Printer.Canvas.Font.Size:=10;
 Printer.Canvas.TextOut(Printer.PageWidth div 2,150,'Спб, Хреновская ул., 34');
 Printer.Canvas.Font.Size:=10;
 Printer.Canvas.TextOut(Printer.PageWidth div 2,200,'Тел: 111-22-33, Факс: 444-55-66');
//вывод разделительной линии
 Printer.Canvas.Pen.Style:=psDash;
 Printer.Canvas.MoveTo(100,250);
 Printer.Canvas.LineTo(Printer.PageWidth-100,250);
//завершение вывода
 Printer.EndDoc;
//удаление экземпляра объекта TBitMap
 logo.Free; 
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
 Form1.Canvas.Pen.Mode:=pmNot;
 Form1.Canvas.Pen.Width:=5;
 Form1.Canvas.Pen.Color:=clGreen;
 Form1.Canvas.Rectangle(485,145,540,200);
 Form1.Canvas.Ellipse(525,144,580,200);
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
 PrinterSetupDialog1.Execute;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
 i, start, stop: integer;
begin
 PrintDialog1.Options:=[poPageNums,poSelection];
 PrintDialog1.FromPage:=1;
 PrintDialog1.ToPage:=PageControl1.PageCount;
 PrintDialog1.MinPage:=1;
 PrintDialog1.MaxPage:=PageControl1.PageCount;
 if not PrintDialog1.Execute then Exit;
 if PrintDialog1.PrintRange=prAllPages
 then
  begin
   Start:=PrintDialog1.MinPage-1;
   Stop:=PrintDialog1.MaxPage-1;
  end
 else // если выбрано отличное от 'Print All'
  if PrintDialog1.PrintRange=prSelection
  then
   begin
    Start:=PageControl1.ActivePageIndex;
    Stop:=Start;
   end
 else // если выбрано отличное от 'Выделенный фрагмент'
  begin
   Start:=PrintDialog1.FromPage-1;
   Stop:=PrintDialog1.ToPage-1;
  end;
 // начало печати
 Printer.BeginDoc;
 for i:=start to stop do
  begin
   PageControl1.Pages[i].PaintTo(Printer.Handle,10,10);
   if i<>stop
   then Printer.NewPage;
  end;
 Printer.EndDoc;  
end;

procedure TForm1.Button10Click(Sender: TObject);
var
 x1,x2,y1,y2: integer;
 PointsX, PointsY: double;
 PrintDlg: TPrintDialog;
begin
 // создание и отображеие стандартного окна печати
 PrintDlg:=TPrintDialog.Create(Owner);
 if PrintDlg.Execute then
  begin
   // новый документ
   Printer.BeginDoc;
   Printer.Canvas.Refresh; // обновление инф-ии на холсте принтера
   // инф-я о разрешении принтера (70 - коэф-т масштабирования)
   PointsX:=GetDeviceCaps(Printer.Canvas.Handle,LOGPIXELSX)/70;
   PointsY:=GetDeviceCaps(Printer.Canvas.Handle,LOGPIXELSY)/70;
   // рассчет размеров изображения
   x1:=round((Printer.PageWidth-Image1.Picture.Bitmap.Width*PointsX)/2);
   y1:=round((Printer.PageHeight-Image1.Picture.Bitmap.Height*PointsY)/2);
   x2:=round(x1+Image1.Picture.Bitmap.Width*PointsX);
   y2:=round(y1+Image1.Picture.Bitmap.Height*PointsY);
   // вывод изображения на печать
   Printer.Canvas.CopyRect(Rect(x1,y1,x2,y2),Image1.Picture.Bitmap.Canvas,
        Rect(0,0,Image1.Picture.Bitmap.Width,Image1.Picture.Bitmap.Height));
   Printer.EndDoc;
  end;
 // уничтожение созданного окна печати
 PrintDlg.Free;
end;

end.
