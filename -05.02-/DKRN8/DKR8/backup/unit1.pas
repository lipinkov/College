unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Math;

type

  { TNet }

  TNet = class(TForm)
    btnCalculate: TButton;
    cbFigureType: TComboBox;
    edParam1: TEdit;
    edParam2: TEdit;
    edParam3: TEdit;
    Image1: TImage;
    Label1: TLabel;
    lblResult: TLabel;
    lblParam1: TLabel;
    lblParam2: TLabel;
    lblParam3: TLabel;
    procedure btnCalculateClick(Sender: TObject);
    procedure cbFigureTypeChange(Sender: TObject);
  private
    function CalculateVolume: Double;
  public

  end;

var
  Net: TNet;

implementation

{$R *.lfm}

{ TNet }

function TNet.CalculateVolume: Double;
var
  Param1, Param2, Param3: Double;
begin
  // Перевод текста в числовые значения, по умолчанию 0
  Param1 := StrToFloatDef(edParam1.Text, 0);
  Param2 := StrToFloatDef(edParam2.Text, 0);
  Param3 := StrToFloatDef(edParam3.Text, 0);

  // Расчёт объёма в зависимости от выбранной фигуры
  case cbFigureType.ItemIndex of
    0: Result := Power(Param1, 3); // Объём куба
    1: Result := (4.0/3.0) * Pi * Power(Param1, 3); // Объём сферы
    2: Result := Pi * Power(Param1, 2) * Param2; // Объём цилиндра
    3: Result := (1.0/3.0) * Pi * Power(Param1, 2) * Param2; // Объём конуса
  else
    Result := 0;
  end;
end;

procedure TNet.cbFigureTypeChange(Sender: TObject);
begin

  edParam1.Visible := False;
  lblParam1.Visible := False;
  edParam2.Visible := False;
  lblParam2.Visible := False;
  edParam3.Visible := False;
  lblParam3.Visible := False;

  // Определение, какие поля ввода и метки показывать
  case cbFigureType.ItemIndex of
    0: begin // Куб
      lblParam1.Caption := 'Длина стороны куба (м):';
      edParam1.Visible := True;
      lblParam1.Visible := True;
    end;
    1: begin // Сфера
      lblParam1.Caption := 'Радиус сферы (м):';
      edParam1.Visible := True;
      lblParam1.Visible := True;
    end;
    2: begin // Цилиндр
      lblParam1.Caption := 'Радиус цилиндра (м):';
      lblParam2.Caption := 'Высота цилиндра (м):';
      edParam1.Visible := True;
      lblParam1.Visible := True;
      edParam2.Visible := True;
      lblParam2.Visible := True;
    end;
    3: begin // Конус
      lblParam1.Caption := 'Радиус конуса (м):';
      lblParam2.Caption := 'Высота конуса (м):';
      edParam1.Visible := True;
      lblParam1.Visible := True;
      edParam2.Visible := True;
      lblParam2.Visible := True;
    end;
  end;
end;

procedure TNet.btnCalculateClick(Sender: TObject);
begin
  lblResult.Caption := 'Объём: ' + FloatToStrF(CalculateVolume, ffFixed, 8, 3) + ' м³';
end;

end.


