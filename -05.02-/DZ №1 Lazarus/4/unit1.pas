unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonCalculate: TButton;
    EditA: TEdit;
    EditB: TEdit;
    EditH: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MemoResult: TMemo;
    procedure ButtonCalculateClick(Sender: TObject);
    procedure EditAChange(Sender: TObject);
    procedure EditHChange(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.EditHChange(Sender: TObject);
begin

end;

procedure TForm1.ButtonCalculateClick(Sender: TObject);
var
  a, b, h, x, y: Double;
begin

    try
      a := StrToFloat(EditA.Text);
      b := StrToFloat(EditB.Text);
      h := StrToFloat(EditH.Text);
    except
      on E: Exception do
      begin

        ShowMessage('Ошибка ввода: ' + E.Message);
        Exit;
      end;
    end;


    MemoResult.Clear;


    x := a;
    while x <= b do
    begin
      y := x * x;
      MemoResult.Lines.Add('x = ' + FloatToStr(x) + '; y = ' + FloatToStr(y));
      x := x + h;
    end;

end;

procedure TForm1.EditAChange(Sender: TObject);
begin

end;

end.

