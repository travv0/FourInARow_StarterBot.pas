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
	TGame = record
		settings: TSettings;
		round: integer;
		field: string;
	end;

procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings);
begin
	Assert(Assigned(Strings));
	Strings.Clear;
	Strings.StrictDelimiter:= true;
	Strings.Delimiter:= Delimiter;
	Strings.DelimitedText:= Input;
end;

var
	line, cmd: string;
	parsedLine, nameList: TStringList;
	game: TGame;

begin
	parsedLine:= TStringList.Create;
	nameList:= TStringList.Create;

	try
		parsedLine.Delimiter:= #32;

		while not eof(input) do begin
			readln(line);
			if line = '' then begin
				writeln('No input found.');
				continue
			end;

			parsedLine.delimitedText:= line;

			if parsedLine.count = 0 then begin
				writeln('Unable to parse command.');
				continue
			end;

			cmd:= parsedLine[0];

			if cmd = 'settings' then begin
				if parsedLine.count = 3 then begin
					if trim(parsedLine[1]) = 'timebank' then begin
						game.settings.timebank:=
							StrToIntDef(Trim(parsedLine[2]), 0)
					end

					else if trim(parsedLine[1]) = 'time_per_move' then begin
						game.settings.timePerMove:=
							StrToIntDef(Trim(parsedLine[2]), 0)
					end

					else if trim(parsedLine[1]) = 'player_names' then begin
						Split(',', parsedLine[2], nameList);
						game.settings.playerName1:= Trim(nameList[0]);
						game.settings.playerName2:= Trim(nameList[1])
					end

					else if trim(parsedLine[1]) = 'your_bot' then begin
						game.settings.yourBot:= Trim(parsedLine[2])
					end

					else if trim(parsedLine[1]) = 'your_botid' then begin
						game.settings.yourBotId:=
							StrToIntDef(Trim(parsedLine[2]), 1)
					end

					else if trim(parsedLine[1]) = 'field_columns' then begin
						game.settings.fieldColumns:=
							StrToIntDef(Trim(parsedLine[2]), 7)
					end

					else if trim(parsedLine[1]) = 'field_rows' then begin
						game.settings.fieldRows:=
							StrToIntDef(Trim(parsedLine[2]), 6)
					end

					else writeln('Invalid command: ' + parsedLine[1]);
				end

				else begin
					writeln('Wrong number of arguments for command ' + cmd);
				end;
			end

			else if cmd = 'update' then begin
				if parsedLine.count = 4 then begin
					if trim(parsedLine[1]) = 'game' then begin
						if trim(parsedLine[2]) = 'round' then begin
							game.round:= StrToIntDef(Trim(parsedLine[2]), 1)
						end

						else if trim(parsedLine[2]) = 'field' then begin
							game.field:= Trim(parsedLine[2])
						end
					end

					else writeln('Invalid command: ' + parsedLine[1]);
				end

				else begin
					writeln('Wrong number of arguments for command ' + cmd)
				end;
			end

			else if cmd = 'action' then begin
				if parsedLine.count = 3 then begin
					if trim(parsedLine[1]) = 'move' then begin
						// AI logic
					end

					else writeln('Invalid command: ' + parsedLine[1]);
				end

				else begin
					writeln('Wrong number of arguments for command ' + cmd)
				end;
			end

			else if cmd = 'exit' then begin
				break;
			end

			else writeln('Invalid command: ' + cmd);

		end;

	finally
		parsedLine.Free;
		nameList.Free;
	end;

	// readln
end.
