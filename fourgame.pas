unit fourgame;

{$IFDEF FPC}
{$MODE DELPHI}
{$H+}
{$ENDIF}

interface

uses
	Classes, SysUtils;

type
	TField = array of array of integer;
	TSettings = record
		timebank, timePerMove, yourBotId, fieldColumns, fieldRows: integer;
		playerName1, playerName2, yourBot: string;
	end;
	TGame = record
		settings: TSettings;
		round: integer;
		field: string;
		fieldArray: TField;
	end;

function CalcBestColumn(game: TGame) : integer;

implementation

function CalcBestColumn(game: TGame) : integer;
begin
	CalcBestColumn:= Random(game.settings.fieldColumns)
end;

end.
