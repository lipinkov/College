unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type
  { TForm1 }

  TForm1 = class(TForm)
    ButtonNumber1: TButton;
    Minus: TButton;
    Multiply: TButton;
    Divided: TButton;
    ButtonNumber0: TButton;
    Point: TButton;
    Plus: TButton;
    Equals: TButton;
    ButtonInverse: TButton;
    Power: TButton;
    Root: TButton;
    ButtonClear: TButton;
    ButtonClearEntry: TButton;
    ButtonBackspace: TButton;
    ButtonNumber2: TButton;
    ButtonNumber3: TButton;
    ButtonNumber4: TButton;
    ButtonNumber5: TButton;
    ButtonNumber6: TButton;
    ButtonNumber7: TButton;
    ButtonNumber8: TButton;
    ButtonNumber9: TButton;
    Edit1: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure EqualsClick(Sender: TObject);
    procedure ButtonInverseClick(Sender: TObject);
    procedure PowerClick(Sender: TObject);
    procedure RootClick(Sender: TObject);
    procedure ButtonClearClick(Sender: TObject);
    procedure ButtonClearEntryClick(Sender: TObject);
    procedure But22Click(Sender: TObject);
    procedure ClickBut(Sender: TObject);
    procedure ClickZnak(Sender: TObject);
  private
    { private declarations }
    function TryGetNumberFromEdit(out Value: Real): Boolean;
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  a, b, c: Real;
  znak: String;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.ReadOnly := True;
  Self.BorderStyle := bsSingle;
end;

function TForm1.TryGetNumberFromEdit(out Value: Real): Boolean;
var
  S: String;
begin
  S := Edit1.Text;
  // Используем Delphi функцию TryStrToFloat для безопасного преобразования строки в число
  Result := TryStrToFloat(S, Value);
  if not Result then
    Edit1.Text := 'Некорректный ввод!';
end;

procedure TForm1.ClickBut(Sender: TObject);
var
  ButtonText, CurrentText: String;
begin
  ButtonText := (Sender as TButton).Caption;
  CurrentText := Edit1.Text;
  if ((ButtonText = '.') or (ButtonText = ',')) and ((Pos('.', CurrentText) > 0) or (Pos(',', CurrentText) > 0)) then Exit;
  if (CurrentText = '0') and (ButtonText <> '.') then
    CurrentText := '';
  if ButtonText = ',' then ButtonText := '.';
  Edit1.Text := CurrentText + ButtonText;
end;

procedure TForm1.ClickZnak(Sender: TObject);
var
  Num: Real;
begin
  if TryGetNumberFromEdit(Num) then
  begin
    a := Num;
    Edit1.Clear;
    znak := (Sender as TButton).Caption;
  end;
end;

procedure TForm1.ButtonClearEntryClick(Sender: TObject);
begin
  Edit1.Clear;
end;

procedure TForm1.But22Click(Sender: TObject);
var
  str: String;
begin
  str := Edit1.Text;
  if str <> '' then Delete(str, Length(str), 1);
  Edit1.Text := str;
end;

procedure TForm1.EqualsClick(Sender: TObject);
begin
  if TryGetNumberFromEdit(b) then
  begin
    case znak of
      '+': c := a + b;
      '-': c := a - b;
      '*': c := a * b;
      '/': if b = 0 then
             Edit1.Text := 'Деление на ноль невозможно!'
           else
             c := a / b;
    else
      Edit1.Text := 'Не выбрана операция!';
      Exit;
    end;
    Edit1.Text := FloatToStr(c);
  end;
end;

procedure TForm1.ButtonInverseClick(Sender: TObject);
begin
  if TryGetNumberFromEdit(a) and (a <> 0) then
  begin
    a := 1 / a;
    Edit1.Text := FloatToStr(a);
  end
  else if a = 0 then
    Edit1.Text := 'Деление на ноль невозможно!';
end;

procedure TForm1.PowerClick(Sender: TObject);
begin
  if TryGetNumberFromEdit(a) then
  begin
    a := sqr(a);
    Edit1.Text := FloatToStr(a);
  end;
end;

procedure TForm1.RootClick(Sender: TObject);
begin
  if TryGetNumberFromEdit(a) and (a >= 0) then
  begin
    a := sqrt(a);
    Edit1.Text := FloatToStr(a);
  end
  else if a < 0 then
    Edit1.Text := 'Корень из отрицательного числа невозможен!';
end;

procedure TForm1.ButtonClearClick(Sender: TObject);
begin
  Edit1.Clear;
  a := 0;
  b := 0;
  c := 0;
  znak := '';
end;

end.

