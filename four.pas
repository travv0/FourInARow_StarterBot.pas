program FourInARow;

{$IFDEF FPC}
	{$MODE DELPHI}
	{$H+}
{$ENDIF}

uses
	Classes, SysUtils;

type
	TSettings = record
		timebank, timePerMove, yourBotId, fieldColumns, fieldRows: integer;
		playerName1, playerName2, yourBot: string;
	end;

var
	line, error, cmd: string;
	parsedLine: TStringList;
	settings: TSettings;

begin
	parsedLine:= TStringList.Create;

	try
		parsedLine.Delimiter:= #32;
		error:= '';

		while not eof(input) do begin
			readln(line);
			if line = '' then begin
				error:= error + 'No input found.' + #10;
				continue
			end;

			parsedLine.delimitedText:= line;

			if parsedLine.count = 0 then begin
				error:= error + 'Unable to parse command.' + #10;
				continue
			end;

			cmd:= parsedLine[0];

			if cmd = 'settings' then begin
				if parsedLine.count = 3 then begin
					if trim(parsedLine[1]) = 'timebank' then begin
						settings.timebank:= StrToIntDef(Trim(parsedLine[2]), 0)
					end
					else if trim(parsedLine[1]) = 'time_per_move' then begin
						settings.timePerMove:= StrToIntDef(Trim(parsedLine[2]), 0)
					end
					else writeln('Invalid command: ' + parsedLine[1]);
				end
				else begin
					writeln('Wrong number of arguments for command ' + cmd);
				end;
			end else if cmd = 'exit' then begin
				break;
			end
			else writeln('Invalid command: ' + cmd);

		end;

		writeln(error);

	finally
		parsedLine.Free;
	end;

	// readln
end.
